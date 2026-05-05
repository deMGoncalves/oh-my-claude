#!/bin/bash
# Hook: telemetry.sh — Copilot CLI (autocontido)
# Evento: sessionEnd
# Objetivo: Registrar trace de sessão + gerar episódio quando feature concluída

INPUT=$(cat)
STOP_ACTIVE=$(echo "$INPUT" | jq -r '.stop_hook_active // "false"')
[ "$STOP_ACTIVE" = "true" ] && exit 0

CWD=$(echo "$INPUT" | jq -r '.cwd // empty')
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"')
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

TELEMETRY_DIR="${CWD}/.github/telemetry"
mkdir -p "$TELEMETRY_DIR" 2>/dev/null

FEATURE_NAME="" PENDING_COUNT=0 DONE_COUNT=0 CODER_ATTEMPTS=0 TESTER_ATTEMPTS=0 MODE="unknown"

TASKS_FILE=$(find "${CWD}/changes" -name "tasks.md" -maxdepth 2 2>/dev/null | sort | head -1)
if [ -n "$TASKS_FILE" ] && [ -f "$TASKS_FILE" ]; then
  FEATURE_NAME=$(echo "$TASKS_FILE" | sed "s|${CWD}/changes/||" | sed "s|/tasks.md||")
  PENDING_COUNT=$(grep -cE "^\s*-\s*\[ \]" "$TASKS_FILE" 2>/dev/null || echo 0)
  DONE_COUNT=$(grep -cE "^\s*-\s*\[x\]" "$TASKS_FILE" 2>/dev/null || echo 0)
  CODER_ATTEMPTS=$(grep -oE "attempts-coder: [0-9]+" "$TASKS_FILE" 2>/dev/null | grep -oE "[0-9]+" || echo 0)
  TESTER_ATTEMPTS=$(grep -oE "attempts-tester: [0-9]+" "$TASKS_FILE" 2>/dev/null | grep -oE "[0-9]+" || echo 0)
  MODE=$(grep -oE "mode: (Quick|Task|Feature|Research|UI)" "$TASKS_FILE" 2>/dev/null | grep -oE "(Quick|Task|Feature|Research|UI)" || echo "unknown")
fi

# Registrar trace de sessão
jq -cn \
  --arg ts "$TIMESTAMP" --arg sid "$SESSION_ID" --arg cwd "$CWD" \
  --arg feature "$FEATURE_NAME" --arg mode "$MODE" \
  --argjson pending "$PENDING_COUNT" --argjson done "$DONE_COUNT" \
  --argjson coder "$CODER_ATTEMPTS" --argjson tester "$TESTER_ATTEMPTS" \
  '{timestamp:$ts,session_id:$sid,cwd:$cwd,feature:$feature,mode:$mode,
    tasks:{pending:$pending,done:$done},attempts:{coder:$coder,tester:$tester}}' \
  >> "${TELEMETRY_DIR}/sessions.jsonl" 2>/dev/null

# Episodic Memory: gerar episódio quando feature concluída
if [ "$PENDING_COUNT" -eq 0 ] && [ "$DONE_COUNT" -gt 0 ] && [ -n "$FEATURE_NAME" ]; then
  EPISODE_DIR="${CWD}/memory/episodes"
  mkdir -p "$EPISODE_DIR" 2>/dev/null
  EPISODE_FILE="${EPISODE_DIR}/$(date +%Y-%m-%d)_${FEATURE_NAME}.md"

  if [ ! -f "$EPISODE_FILE" ]; then
    FEATURE_PATH="${CWD}/changes/${FEATURE_NAME}"
    SPECS=$(head -60 "${FEATURE_PATH}/specs.md" 2>/dev/null)
    DESIGN=$(head -30 "${FEATURE_PATH}/design.md" 2>/dev/null)
    FINDINGS=$(head -20 "${FEATURE_PATH}/findings.md" 2>/dev/null)

    cat > "$EPISODE_FILE" << EPISODE_EOF
---
date: $(date -u +"%Y-%m-%d")
feature: ${FEATURE_NAME}
mode: ${MODE}
attempts_coder: ${CODER_ATTEMPTS}
attempts_tester: ${TESTER_ATTEMPTS}
tasks_completed: ${DONE_COUNT}
---

## Specs

${SPECS}

## Decisões de Design

${DESIGN}

## Findings

${FINDINGS}
EPISODE_EOF
  fi
fi

# Skill Distillation: candidatos quando coder passou na primeira tentativa
if [ "$PENDING_COUNT" -eq 0 ] && [ "$DONE_COUNT" -gt 0 ] && \
   [ -n "$FEATURE_NAME" ] && [ "$CODER_ATTEMPTS" = "1" ]; then
  PATTERNS_DIR="${CWD}/memory/patterns"
  mkdir -p "$PATTERNS_DIR" 2>/dev/null
  CANDIDATES_FILE="${PATTERNS_DIR}/candidates.md"

  if ! grep -q "^### .*${FEATURE_NAME}" "$CANDIDATES_FILE" 2>/dev/null; then
    cat >> "$CANDIDATES_FILE" << CANDIDATE_EOF

### $(date +%Y-%m-%d) — ${FEATURE_NAME}
- **Modo**: ${MODE}
- **Tentativas coder/tester**: ${CODER_ATTEMPTS}/${TESTER_ATTEMPTS}
- **Tasks concluídas**: ${DONE_COUNT}
- **Specs**: \`changes/${FEATURE_NAME}/specs.md\`
- [ ] Revisado — skill atualizado ou descartado
CANDIDATE_EOF
  fi
fi

exit 0
