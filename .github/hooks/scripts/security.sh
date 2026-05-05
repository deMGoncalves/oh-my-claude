#!/bin/bash
# Hook: security.sh — Copilot CLI (autocontido)
# Evento: postToolUse (write_file, edit_file)
# Objetivo: Bloquear credenciais hardcoded (Rule 030 + Rule 042)

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

[ -z "$FILE_PATH" ] || [ "$FILE_PATH" = "null" ] && exit 0
echo "$FILE_PATH" | grep -qE '\.(example|sample|template|test|spec)\.|\.example$' && exit 0
echo "$FILE_PATH" | grep -qE '\.(ts|tsx|js|jsx|py|json|yaml|yml|env|sh|bash)$' || echo "$FILE_PATH" | grep -qE '\.env' || exit 0
[ -f "$FILE_PATH" ] || exit 0

FINDINGS=""
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')
RELATIVE_PATH="${FILE_PATH#${CWD}/}"

check() {
  local MATCH
  MATCH=$(grep -nE "$1" "$FILE_PATH" 2>/dev/null | grep -v 'process\.env\.' | grep -v '\$\{' | grep -v '^\s*[#/]' | grep -v 'your[_-]\|example\|placeholder\|CHANGE_ME')
  [ -n "$MATCH" ] && FINDINGS="${FINDINGS}${MATCH}\n"
}

check '(api[_-]?key|password|passwd|secret[_-]?key|auth[_-]?token|private[_-]?key|access[_-]?token|client[_-]?secret)\s*[=:]\s*['"'"'"][^'"'"'"${}][^'"'"'"]{7,}['"'"'"]'
check 'gh[phosr]_[A-Za-z0-9]{36}'
check '"(sk|pk|rk)[-_][a-zA-Z0-9]{20,}"'
check 'Bearer\s+[A-Za-z0-9+/]{20,}[=]*'

[ -z "$FINDINGS" ] && exit 0

jq -n --arg f "$RELATIVE_PATH" --arg findings "$FINDINGS" \
  '{decision:"block",reason:("🔴 SECURITY [Rule 042]: Credencial hardcoded em "+$f+".\n\n"+$findings+"\nUse process.env.NOME.")}'
exit 0
