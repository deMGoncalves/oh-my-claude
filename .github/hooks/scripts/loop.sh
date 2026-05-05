#!/bin/bash
# Hook: loop.sh — Copilot CLI (autocontido)
# Evento: sessionEnd
# Objetivo: Bloquear encerramento se houver tarefas pendentes em tasks.md

INPUT=$(cat)
STOP_ACTIVE=$(echo "$INPUT" | jq -r '.stop_hook_active // "false"')
[ "$STOP_ACTIVE" = "true" ] && exit 0

CWD=$(echo "$INPUT" | jq -r '.cwd // empty')

PENDING_FILES=$(find "${CWD}/changes" -name "tasks.md" -maxdepth 2 2>/dev/null | \
  xargs grep -l "^\s*- \[ \]" 2>/dev/null | sort)

[ -z "$PENDING_FILES" ] && exit 0

SUMMARY=""
for TASKS_FILE in $PENDING_FILES; do
  FEATURE=$(echo "$TASKS_FILE" | sed "s|${CWD}/changes/||" | sed "s|/tasks.md||")
  PENDING=$(grep -cE "^\s*- \[ \]" "$TASKS_FILE" 2>/dev/null || echo "?")
  DONE=$(grep -cE "^\s*- \[x\]" "$TASKS_FILE" 2>/dev/null || echo "0")
  CODER=$(grep -oE "attempts-coder: [0-9]+" "$TASKS_FILE" 2>/dev/null | grep -oE "[0-9]+" || echo "0")
  TESTER=$(grep -oE "attempts-tester: [0-9]+" "$TASKS_FILE" 2>/dev/null | grep -oE "[0-9]+" || echo "0")
  SUMMARY="${SUMMARY}\n  📋 ${FEATURE}: ${PENDING} pendentes, ${DONE} concluídas | coder=${CODER}/3 tester=${TESTER}/3"
done

jq -n --arg s "$SUMMARY" \
  '{decision:"block",reason:("⚠️ Sessão com tarefas pendentes:"+$s+"\n\nUse /status para ver progresso ou /ship quando concluído.")}'
exit 0
