#!/bin/bash
# Hook: guard.sh — Copilot CLI (autocontido)
# Evento: postToolUse (write_file, edit_file)
# Regras: 007 (50 LOC), 033 (3 params), 030 (eval), 024 (magic numbers)

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

[ -z "$FILE_PATH" ] || [ "$FILE_PATH" = "null" ] && exit 0
echo "$FILE_PATH" | grep -qE '\.(ts|tsx|js|jsx)$' || exit 0
echo "$FILE_PATH" | grep -qE '\.(test|spec)\.(ts|tsx|js|jsx)$' && exit 0
[ -f "$FILE_PATH" ] || exit 0

CWD=$(echo "$INPUT" | jq -r '.cwd // empty')
RELATIVE_PATH="${FILE_PATH#${CWD}/}"
VIOLATIONS=""

# Rule 007: LOC > 50
LOC=$(grep -cE '^[[:space:]]*[^/[:space:]]' "$FILE_PATH" 2>/dev/null || echo "0")
[ "$LOC" -gt 50 ] 2>/dev/null && \
  VIOLATIONS="${VIOLATIONS}  [Rule 007] 🔴 ${LOC} LOC (máximo: 50). Extrair responsabilidades.\n"

# Rule 033: > 3 parâmetros
LONG_PARAMS=$(grep -nE 'function[[:space:]]+\w*[[:space:]]*\([^)]*,[^)]*,[^)]*,[^)]' "$FILE_PATH" 2>/dev/null | head -5)
[ -z "$LONG_PARAMS" ] && LONG_PARAMS=$(grep -nE '(const|let|var)[[:space:]]+\w+[[:space:]]*=[[:space:]]*\([^)]*,[^)]*,[^)]*,[^)]+\)[[:space:]]*=>' "$FILE_PATH" 2>/dev/null | head -5)
[ -n "$LONG_PARAMS" ] && \
  VIOLATIONS="${VIOLATIONS}  [Rule 033] 🔴 Função com > 3 parâmetros. Agrupar em DTO:\n$(echo "$LONG_PARAMS" | sed 's/^/    /')\n"

# Rule 030: eval / new Function
UNSAFE=$(grep -nE '\beval\s*\(|new\s+Function\s*\(' "$FILE_PATH" 2>/dev/null | grep -v '^\s*[//*]' | head -3)
[ -n "$UNSAFE" ] && \
  VIOLATIONS="${VIOLATIONS}  [Rule 030] 🔴 eval/new Function detectado (vetor RCE):\n$(echo "$UNSAFE" | sed 's/^/    /')\n"

# Rule 024: magic numbers
MAGIC=$(grep -nE '[^a-zA-Z_0-9][0-9]{2,}[^a-zA-Z_0-9.]' "$FILE_PATH" 2>/dev/null | \
  grep -vE '^\s*(const|let|var|\/\/|\/\*|\*)' | grep -vE 'Rule|version|0x[0-9a-fA-F]+' | head -3)
[ -n "$MAGIC" ] && \
  VIOLATIONS="${VIOLATIONS}  [Rule 024] 🟠 Constante mágica. Usar UPPER_SNAKE_CASE:\n$(echo "$MAGIC" | sed 's/^/    /')\n"

[ -z "$VIOLATIONS" ] && exit 0

HAS_CRITICAL=$(echo "$VIOLATIONS" | grep -c "🔴" || echo "0")
if [ "$HAS_CRITICAL" -gt 0 ] 2>/dev/null; then
  jq -n --arg f "$RELATIVE_PATH" --arg v "$VIOLATIONS" \
    '{decision:"block",reason:("🔴 Violações críticas em "+$f+":\n\n"+$v+"\nCorrigir antes de submeter.")}'
else
  jq -n --arg f "$RELATIVE_PATH" --arg v "$VIOLATIONS" \
    '{decision:"approve",reason:("⚠️ Melhorias sugeridas em "+$f+":\n\n"+$v)}'
fi
exit 0
