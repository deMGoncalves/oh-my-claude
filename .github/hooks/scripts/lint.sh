#!/bin/bash
# Hook: lint.sh — Copilot CLI (autocontido)
# Evento: postToolUse (write_file, edit_file)

INPUT=$(cat)
file_path=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

[ -z "$file_path" ] || [ "$file_path" = "null" ] && exit 0
echo "$file_path" | grep -qE '\.(ts|tsx|js|jsx|json)$' || exit 0
[ -f "$file_path" ] || exit 0

CWD=$(echo "$INPUT" | jq -r '.cwd // empty')

if [ -f "${CWD}/biome.json" ] || [ -f "${CWD}/biome.jsonc" ]; then
  bunx biome check --write "$file_path" 2>&1
elif [ -f "${CWD}/.eslintrc.js" ] || [ -f "${CWD}/.eslintrc.cjs" ] || \
     [ -f "${CWD}/.eslintrc.json" ] || [ -f "${CWD}/eslint.config.js" ] || \
     [ -f "${CWD}/eslint.config.mjs" ]; then
  npx eslint --fix "$file_path" 2>&1
elif [ -f "${CWD}/deno.json" ] || [ -f "${CWD}/deno.jsonc" ]; then
  deno fmt "$file_path" 2>&1
fi
exit 0
