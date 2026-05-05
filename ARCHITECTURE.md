# Arquitetura

Uma análise profunda de como o oh my claude foi projetado e por quê.

---

## Conceito Central

oh my claude é um **harness de engenharia de software** com suporte a dois CLIs:

- **Claude Code** (primário) — via diretório `.claude/`, com Agent tool para orquestração multi-agente nativa.
- **GitHub Copilot CLI** (fallback) — via `.github/` + `copilot-instructions.md`, com `--agent` e `/fleet`.

Ambos compartilham as mesmas abstrações (agentes, regras, skills, hooks) em formatos nativos de cada ferramenta. `changes/` e `memory/` são compartilhados entre os dois — uma feature iniciada em um CLI pode ser continuada no outro.

```
Claude Code:   CLAUDE.md → agents (.md) → rules (.md) → hooks (.sh) → workflow executa
Copilot CLI:   copilot-instructions.md → agents (.agent.md) → instructions (applyTo) → hooks (.json+.sh)
```

---

## Mapa de Componentes

```
.claude/                     ← Claude Code
│
├── CLAUDE.md                ← System prompt do Tech Lead
├── GRAPH.md                 ← Mapa de dependências (Mermaid)
│
├── agents/                  ← 6 agentes (.md com frontmatter Claude Code)
├── rules/                   ← 70 regras arquiteturais (001–070)
├── skills/                  ← 35 skills com progressive disclosure
├── commands/                ← 6 slash commands
├── hooks/                   ← 6 hooks shell (prompt/lint/security/guard/loop/telemetry)
└── settings.json            ← registro de hooks + permissões

.github/                     ← GitHub Copilot CLI (estrutura espelho)
│
├── agents/                  ← 6 agentes (.agent.md com YAML frontmatter)
├── instructions/            ← 70 regras (*.instructions.md, applyTo: "**")
├── skills/                  ← 35 skills + 7 workflow + context
└── hooks/
    ├── post-write.json      ← lint + guard + security (postToolUse)
    ├── user-prompt.json     ← prompt.sh (userPromptSubmitted)
    ├── session-end.json     ← loop + telemetry (sessionEnd)
    └── scripts/             ← 6 hooks shell autocontidos

copilot-instructions.md      ← Tech Lead para Copilot CLI (na raiz)
```

---

## O Sistema de Agents

### Comparação entre CLIs

| Conceito | Claude Code | Copilot CLI |
|----------|-------------|-------------|
| System prompt | `.claude/CLAUDE.md` | `copilot-instructions.md` |
| Agente | `.claude/agents/*.md` | `.github/agents/*.agent.md` |
| Invocar agente | Agent tool (`subagent_type`) | `--agent nome` |
| Agentes paralelos | Agent tool (múltiplos) | `/fleet` |
| Regras | `.claude/rules/*.md` | `.github/instructions/*.instructions.md` |
| Skills | `.claude/skills/*/SKILL.md` | `.github/skills/*/SKILL.md` |
| Slash commands | `.claude/commands/*.md` | `.github/skills/*/SKILL.md` |
| Hook write | `PostToolUse` Write/Edit | `postToolUse` write_file/edit_file |
| Hook prompt | `UserPromptSubmit` | `userPromptSubmitted` |
| Hook encerrar | `Stop` | `sessionEnd` |
| Memória episódica | nativa (telemetry.sh) | workaround via `/context` |
| Escape hatch | `.claude/.loop-skip` | `.github/.loop-skip` |

### Padrões Utilizados

oh my claude implementa dois padrões de [Building Effective Agents](https://anthropic.com/research/building-effective-agents):

**Orquestrador-Trabalhador:** O Tech Lead (CLAUDE.md / copilot-instructions.md) roteia requisições para sub-agents especializados. Cada agent tem uma única responsabilidade e contratos explícitos de entrada/saída.

**Avaliador-Otimizador:** `@tester` avalia a saída do `@coder`. Se os testes falham, `@coder` corrige e resubmete. Esse loop executa até 3 vezes antes de escalar para o humano.

### Responsabilidades dos Agents

```
Requisição
  │
  ▼
Tech Lead (Claude Code + CLAUDE.md)
  │ classifica o modo
  ├── Quick ──────────────────────────────► @coder
  ├── Task ─────────► @planner ──► @architect ──► @coder
  ├── Feature ──────► @planner ──► @architect ──► @coder
  ├── Research ─────► @deepdive ──► @planner ──► (Task/Feature)
  └── UI ──────────► @designer + @architect ──► @coder
                                                    │
                                                    ▼
                                                 @tester (avaliador)
                                                    │
                                              passa / falha (≤3×)
                                                    │
                                                    ▼
                                              @architect (revisão)
```

### Limites de Loop

Cada agent possui loops de retry limitados, rastreados em `changes/00X/tasks.md`:

```html
<!-- attempts-coder: 0 -->
<!-- attempts-tester: 0 -->
```

| Agent | Máximo de tentativas | Ao atingir o limite |
|-------|---------------------|---------------------|
| @coder | 3 | Re-spec via @architect |
| @tester | 3 | Escalada para o usuário |
| Revisão do @architect | 3 | Escalada para o usuário |

---

## O Sistema de Rules

70 rules em `.claude/rules/` formam um sistema de restrições que previne a degradação arquitetural:

```
Arquivo de rule → Agent lê → Aplica durante implementação → @architect mede via ICP
```

### ICP — Persistência Cognitiva Integrada

`@architect` mede a carga cognitiva de cada método:

```
ICP = CC_base + Aninhamento + Responsabilidades + Acoplamento
```

| ICP | Status | Ação |
|-----|--------|------|
| ≤ 3 | Excelente | Manter |
| 4–6 | Aceitável | Considerar refatoração |
| 7–10 | Preocupante | Refatorar antes da próxima feature |
| > 10 | Crítico | Refatoração obrigatória |

### Severidade das Rules

| Severidade | Tag | Significado |
|------------|-----|-------------|
| 🔴 Crítica | `FIXME` | Bloqueia PR — deve corrigir |
| 🟠 Alta | `TODO` | Corrigir antes da entrega |
| 🟡 Média | `XXX` | Anotar e melhorar depois |

---

## O Sistema de Skills

35 skills em `.claude/skills/` são módulos de conhecimento carregados sob demanda:

```
Agent precisa de contexto → lê SKILL.md (índice) → carrega references/ se necessário
```

### Divulgação Progressiva

Cada skill segue:
```
SKILL.md          ← índice leve (sempre carregado)
references/       ← conteúdo detalhado (carregado quando necessário)
  ├── pattern.md
  └── example.md
```

Isso previne o inchaço de contexto — agents carregam apenas o que precisam para a task atual.

---

## O Pipeline de Hooks

3 hooks formam um pipeline automático — sem invocação manual necessária:

```
Usuário digita prompt
      │
[1] prompt.sh (UserPromptSubmit)
    Detecta verbos de ação → injeta dica de modo de workflow no system prompt
      │
Claude responde, escreve/edita arquivos
      │
[2] lint.sh (PostToolUse: Write|Edit)
    Auto-formata cada arquivo usando o linter do projeto
      │
Claude termina de responder
      │
[3] loop.sh (Stop)
    Lê changes/*/tasks.md
    Se algum - [ ] existir → bloqueia resposta + retorna ao Tech Lead
```

---

## O Sistema de Contexto changes/

Contexto persistente para Features e Tasks:

```
changes/
└── 001_nome-da-feature/
    ├── PRD.md          ← (Feature) Requisitos de negócio
    ├── design.md       ← (Feature) Decisões técnicas + padrões
    ├── design-spec.md  ← (modo UI) Especificação de componente
    ├── specs.md        ← (Task + Feature) Interfaces + critérios de aceitação
    ├── findings.md     ← (modo Research) Relatório de investigação
    └── tasks.md        ← T-001...T-NNN + contadores de tentativas + marcador de modo
```

Esse contexto sobrevive entre sessões de conversa — agents retomam de onde outros pararam.

---

## Grafo de Dependências

O arquivo `GRAPH.md` mantém um diagrama Mermaid do grafo completo de dependências:

```
Rules → Skills → Agents
(Rules 001–009) → (skill: object-calisthenics) → (@coder)
(Rules 010–014) → (skill: solid) → (@architect)
...
```

Veja [GRAPH.md](.claude/GRAPH.md) para o diagrama interativo completo.

---

## Decisões de Design

### Por que português para documentação interna?

O autor do projeto é brasileiro. A documentação interna (agents, skills, rules) está em português para corresponder ao domínio cognitivo do autor. A documentação externa (README, CONTRIBUTING) está em inglês para alcance de OSS.

### Por que loops limitados?

Loops de retry sem limite em sistemas de agent de IA causam custos descontrolados e estouro de contexto. O limite de 3 tentativas força revisão humana antes de continuar — uma escolha de design deliberada seguindo as recomendações da Anthropic.

### Por que agents agnósticos de tecnologia?

Os arquivos de agent não mencionam ferramentas específicas (sem Biome, Vitest, Storybook no texto dos agents) porque o harness deve funcionar com qualquer stack tecnológica. Escolhas de ferramentas específicas do projeto pertencem ao CLAUDE.md ou à configuração própria do projeto.

### Por que 70 rules?

O número é deliberado: suficiente para cobrir todas as categorias significativas (Object Calisthenics, SOLID, Princípios de Pacote, Clean Code, Twelve-Factor, Anti-Patterns) sem se tornar inaplicável. Rules com IDs > 070 podem ser adicionadas por contribuidores.

---

**Voltar para [README.md](README.md)**
