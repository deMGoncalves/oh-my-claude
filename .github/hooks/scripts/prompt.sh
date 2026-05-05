#!/bin/bash
# Hook: prompt.sh — Copilot CLI (autocontido)
# Evento: userPromptSubmitted
# Objetivo: Injetar contexto de roteamento + sessão ativa + episódios similares

INPUT=$(cat)
PROMPT=$(echo "$INPUT" | jq -r '.prompt // empty')
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')

[ -z "$PROMPT" ] && exit 0

# Bootstrap: detectar feature ativa com tarefas pendentes
BOOTSTRAP_HINT=""
ACTIVE_TASKS=$(find "${CWD}/changes" -name "tasks.md" -maxdepth 2 2>/dev/null | \
  xargs grep -l "^\s*- \[ \]" 2>/dev/null | sort | head -1)

FEATURE=""
if [ -n "$ACTIVE_TASKS" ]; then
  FEATURE=$(echo "$ACTIVE_TASKS" | sed "s|${CWD}/changes/||" | sed "s|/tasks.md||")
  PENDING=$(grep -cE "^\s*- \[ \]" "$ACTIVE_TASKS" 2>/dev/null || echo "?")
  CODER=$(grep -oE "attempts-coder: [0-9]+" "$ACTIVE_TASKS" 2>/dev/null | grep -oE "[0-9]+" || echo "0")
  BOOTSTRAP_HINT="[SESSÃO ATIVA] Feature: changes/${FEATURE}/ | Pendentes: ${PENDING} tarefas | coder: ${CODER}/3. Verificar tasks.md e perguntar ao usuário se deseja continuar. "
fi

# Perguntas conceituais: injetar apenas bootstrap
if echo "$PROMPT" | grep -qiE '^(how (does|do|is|are)|what (is|are|does)|which|why|when|where|explain|tell me|understand|can you explain|what.s the difference)'; then
  [ -n "$BOOTSTRAP_HINT" ] && jq -n --arg h "$BOOTSTRAP_HINT" \
    '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalSystemPrompt":$h}}'
  exit 0
fi

if echo "$PROMPT" | grep -qE '\?$' && \
   ! echo "$PROMPT" | grep -qiE '(implement|create|add|fix|refactor|develop|build|write|generate|configure|migrate|update|delete|remove)'; then
  [ -n "$BOOTSTRAP_HINT" ] && jq -n --arg h "$BOOTSTRAP_HINT" \
    '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalSystemPrompt":$h}}'
  exit 0
fi

# Prompts de ação: detectar modo e injetar hint
if echo "$PROMPT" | grep -qiE '(implement|create|build|add|fix|refactor|develop|new feature|feature|new task|endpoint|write|generate|configure|migration|migrate|phase [0-9]|spec flow|start feature|pending task)'; then

  MODE_HINT="(Classificar como Quick/Task/Feature/Research/UI antes de agir)"

  echo "$PROMPT" | grep -qiE '(fix|typo|bug|remove|delete|line [0-9]|console\.log|import|unused|dead code|refactor (the|a)|on line|in file|in src/)' && \
    MODE_HINT="(Modo provável: Quick — verificar se escopo é 1-2 arquivos)"

  echo "$PROMPT" | grep -qiE '(endpoint|route|field|validat|middleware|add (to|in|on)|new field|new route)' && \
    MODE_HINT="(Modo provável: Task — escopo claro, architect cria apenas specs.md)"

  echo "$PROMPT" | grep -qiE '(system|module|authenticat|authoriz|permiss|oauth|jwt|payment|notificat|event.driven|microservi|architect|refactor (entire|system|architecture))' && \
    MODE_HINT="(Modo provável: Feature — Fluxo Spec Completo recomendado)"

  echo "$PROMPT" | grep -qiE '(why (is|does|did|are)|root cause|debug|diagnos|investigate|trace|how does.*work|explore|performance issue|slow|bottleneck|security.*issue|what.s wrong|analyze codebase)' && \
    MODE_HINT="(Modo provável: Research — acionar deepdive antes de planejar)"

  echo "$PROMPT" | grep -qiE '(component|button|form|modal|dialog|ui|ux|design|layout|style|accessibility|a11y|token|visual)' && \
    MODE_HINT="(Modo provável: UI — designer cria design-spec.md + architect cria specs.md)"

  COVERAGE_HINT=""
  if echo "$PROMPT" | grep -qiE '(src/|source/)' && ! echo "$PROMPT" | grep -qiE '(test|spec|coverage|tester)'; then
    COVERAGE_HINT=" Lembrete: mudanças em src/ requerem cobertura ≥85% no domínio."
  fi

  # Episode injection: buscar episódios similares
  EPISODE_CONTEXT=""
  EPISODES_DIR="${CWD}/memory/episodes"
  if [ -d "$EPISODES_DIR" ] && [ "$(ls -A "$EPISODES_DIR" 2>/dev/null)" ]; then
    KEYWORDS=$(echo "$PROMPT" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z' '\n' | \
      grep -E '^.{4,}$' | \
      grep -v -E '^(para|como|mais|quando|onde|este|essa|isso|the|and|for|with|this|that|from|have|will|your|are|not|but|can|was|all|has|been|they|more|about|which|when|what|you|how|should)$' | \
      sort -u | head -6 | paste -sd '|')
    if [ -n "$KEYWORDS" ]; then
      MATCHING=$(grep -rl -i -E "$KEYWORDS" "$EPISODES_DIR" 2>/dev/null | xargs ls -t 2>/dev/null | head -2)
      if [ -n "$MATCHING" ]; then
        EPISODE_CONTEXT="\n\n[EPISÓDIOS SIMILARES — referência de padrões, não spec]"
        for EP_FILE in $MATCHING; do
          EP_NAME=$(basename "$EP_FILE" .md)
          EP_CONTENT=$(head -50 "$EP_FILE" 2>/dev/null)
          EPISODE_CONTEXT="${EPISODE_CONTEXT}\n\n--- Episódio: ${EP_NAME} ---\n${EP_CONTENT}\n---"
        done
      fi
    fi
  fi

  FULL_PROMPT="Você é o Tech Lead. Classifique em Quick/Task/Feature/Research/UI antes de agir. Use --agent para delegar. ${BOOTSTRAP_HINT}${MODE_HINT}${COVERAGE_HINT}${EPISODE_CONTEXT}"

  jq -n --arg p "$FULL_PROMPT" \
    '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalSystemPrompt":$p}}'
  exit 0
fi

# Sem prompt de ação: injetar apenas bootstrap se houver sessão ativa
[ -n "$BOOTSTRAP_HINT" ] && jq -n --arg h "$BOOTSTRAP_HINT" \
  '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalSystemPrompt":$h}}'

exit 0
