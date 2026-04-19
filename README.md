# oh my claude

**Autor:** Cleber de Moraes Goncalves · [@deMGoncalves](https://github.com/deMGoncalves)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Required-blueviolet)](https://claude.ai/code)
[![Agents](https://img.shields.io/badge/Agents-6-blue)](#agentes)
[![Rules](https://img.shields.io/badge/Rules-70-orange)](#regras)
[![Skills](https://img.shields.io/badge/Skills-35-green)](#skills)
[![Hooks](https://img.shields.io/badge/Hooks-6-red)](#hooks)
[![Memory](https://img.shields.io/badge/Memory-Persistent-brightgreen)](#memória)

Um harness de engenharia de software para Claude Code que **externaliza cognição** em agentes, regras, skills, hooks e memória persistente — transformando um LLM generalista em um sistema disciplinado de entrega de código.

---

## O que é

`oh my claude` **não é um framework**, **não é um plugin**, e **não é um prompt gigante**. É um diretório `.claude/` que, quando colocado na raiz de qualquer projeto, reconfigura o Claude Code para operar como um sistema de engenharia com papéis especializados, regras arquiteturais mensuráveis, memória de longo prazo e controles automáticos de qualidade.

Na prática, quando você abre o projeto com `claude .`, o harness carrega:

- **6 agentes especializados** (planner, architect, designer, coder, tester, deepdive) — cada um com escopo, ciclos limitados e acesso apenas às skills e regras que precisam.
- **70 regras arquiteturais** (Object Calisthenics, SOLID, 12-Factor, anti-patterns) aplicadas automaticamente por hooks que bloqueiam violações críticas antes que cheguem ao commit.
- **35 skills** organizadas em três níveis de *progressive disclosure*, carregadas sob demanda para evitar inflação de contexto.
- **6 hooks de ciclo de vida** que observam, protegem e instrumentam cada interação.
- **Um sistema de memória em três camadas** (`changes/`, `memory/episodes/`, `memory/patterns/`, `memory/semantic/`) que preserva contexto entre sessões e aprende com execuções anteriores.

O que ele **não faz**: não substitui o modelo, não executa em background, não treina nada, não "melhora o prompt". Ele organiza o ambiente ao redor do modelo para que o modelo possa produzir trabalho reproduzível.

---

## Por que assim

A motivação teórica vem do paper *"Externalization in LLM Agents: A Unified Review of Memory, Skills, Protocols and Harness Engineering"* (2026), cuja tese central é:

> *"Agency is not located in the model alone; it emerges from the coupling of the model with the environment that organizes its cognition into action."*

LLMs têm um perfil cognitivo assimétrico: são excelentes em **síntese flexível** (raciocinar, combinar, adaptar), mas frágeis em três dimensões que engenharia exige:

1. **Memória estável** — esquecem o que decidiram há 30 turnos.
2. **Repetibilidade procedural** — improvisam variações sutis em workflows que deveriam ser idênticos.
3. **Interação governada** — aceitam qualquer entrada e produzem qualquer saída sem contratos firmes.

A solução não é "prompt melhor" nem "modelo maior" — é **construir um sistema cognitivo maior ao redor do modelo**, externalizando as capacidades que ele não tem em artefatos estáveis que ele pode consultar, seguir e atualizar.

### Os três módulos de externalização

| Módulo | O que externaliza | Onde vive | Transforma |
|--------|-------------------|-----------|------------|
| **Memória** | Estado temporal (decisões, progresso, aprendizados) | `changes/`, `memory/` | Recall interno → retrieval externo |
| **Skills** | Expertise procedural (como fazer X corretamente) | `.claude/skills/` | Geração improvisada → execução guiada |
| **Protocolos** | Disciplina de interação (contratos, validações, ciclos) | `hooks/`, `commands/`, `agents/` | Coordenação ad hoc → contratos governados |

Cada decisão de design do `oh my claude` se encaixa em um desses módulos. Não há regras soltas, skills decorativas ou hooks "caso dê certo" — tudo existe para compensar uma fraqueza conhecida do modelo com um artefato externo verificável.

### Por que regras em vez de instruções no prompt

Uma regra como *"arquivos de classe devem ter no máximo 50 linhas"* pode viver em três lugares:

1. **Dentro do prompt** — o modelo esquece em conversas longas, interpreta flexivelmente, e a verificação é subjetiva.
2. **Dentro de um guia textual** — melhora um pouco, mas depende do modelo lembrar de consultar.
3. **Em um arquivo de regra estruturada + hook que bloqueia violações** — verificável, não-negociável, auditável.

O harness escolhe sempre o terceiro caminho. Cada uma das 70 regras tem ID, severidade (🔴 Crítica, 🟠 Alta, 🟡 Média), critérios objetivos e detecção automática. Violações 🔴 Críticas são bloqueadas pelo `guard.sh` antes de o arquivo ser salvo.

### Por que skills com progressive disclosure

Um prompt que contenha todo o conhecimento necessário para codar bem teria centenas de milhares de tokens. Isso é impraticável. A alternativa é **disclosure em três níveis**:

- **Nível 1 — Frontmatter** (50 tokens): nome + descrição curta. Carregado sempre, usado para descoberta.
- **Nível 2 — Manifest** (200–500 tokens): aplicabilidade, pré-requisitos, restrições, escopo. Carregado quando o agente decide "essa skill é relevante".
- **Nível 3 — References** (até 10k tokens): guia completo com exemplos, anti-patterns, casos extremos. Carregado apenas quando o agente vai efetivamente usar.

O resultado: o agente tem acesso potencial a 35 skills, mas consome contexto apenas das que efetivamente usa na tarefa corrente.

### Por que agentes especializados em vez de um "super-agente"

Um único agente que planeja, desenha, codifica e testa tende a misturar os modos: começa a codar antes de especificar, ou começa a testar antes de implementar. Separar em 6 agentes com contratos de entrada/saída explícitos força transições limpas entre fases e permite que cada agente carregue **apenas** o contexto e as skills que importam para seu papel.

### Por que memória em três camadas

Não toda memória tem o mesmo tempo de vida:

- **Working (`changes/`)** — vive uma feature/task. Decisões operacionais que ficam obsoletas ao encerrar.
- **Episódica (`memory/episodes/`)** — vive para sempre. Registro de "o que aconteceu nesta sessão" para recuperação contextual futura.
- **Procedural (`memory/patterns/`)** — padrões recorrentes detectados. Candidatos a virar skills ou regras.
- **Semântica (`memory/semantic/`)** — conhecimento de domínio curado manualmente.

Separar os tempos de vida evita que decisões efêmeras poluam conhecimento estável, e que conhecimento estável seja sobrescrito por decisões operacionais.

---

## Como funciona

Quando você envia um pedido ao Claude Code com o `oh my claude` ativo, acontece o seguinte:

1. **`prompt.sh`** intercepta sua mensagem, detecta verbos de ação, injeta uma dica de modo (Quick/Task/Feature/Research/UI) e, se houver episódios passados relevantes, injeta referências para recuperação contextual.
2. **Tech Lead (CLAUDE.md)** classifica o pedido em um dos 5 modos e delega ao agente apropriado via Agent Tool.
3. **Agente ativo** lê suas regras, carrega suas skills, produz seu entregável e devolve controle.
4. **`lint.sh`**, **`security.sh`** e **`guard.sh`** rodam a cada escrita de arquivo — formatam, bloqueiam credenciais, bloqueiam violações 🔴 Críticas.
5. **`loop.sh`** verifica, antes de encerrar o turno, se há tarefas pendentes (`- [ ]`) em `changes/*/tasks.md`. Se houver, bloqueia e força continuação.
6. **`telemetry.sh`** registra o episódio (passos, agentes usados, duração) em `memory/episodes/` e, se detectar padrões repetíveis, salva candidatos em `memory/patterns/`.

### Os 5 modos de trabalho

| Modo | Quando | Fluxo |
|------|--------|-------|
| **Quick** | ≤2 arquivos, sem nova entidade | `@coder` → `@tester` → `@architect` (review) |
| **Task** | Novo contrato, escopo claro | `@planner` → `@architect` → `@coder` → `@tester` |
| **Feature** | Novo contexto delimitado, impacto amplo | `@planner` → `@architect` → `@coder` → `@tester` → `@architect docs` |
| **Research** | Causa raiz desconhecida, bug misterioso | `@deepdive` → `@planner` → Task ou Feature |
| **UI** | Componente visual | `@planner` → `@designer` + `@architect` → `@coder` → `@tester` |

Cada modo tem um contrato de contexto em `changes/00X_nome/`: `PRD.md`, `specs.md`, `design.md`, `tasks.md` e contadores de tentativas. Isso é a **memória de working**: viva enquanto a feature existe, arquivada quando a feature encerra.

### Ciclos limitados (bounded loops)

Cada agente tem no máximo 3 tentativas por tarefa antes de escalar para o usuário. O contador vive em `tasks.md`:

```html
<!-- attempts-coder: 2 -->
<!-- attempts-tester: 1 -->
```

Na 3ª tentativa, o Tech Lead pergunta: *"re-spec ou continuar?"*. Na 4ª, re-spec é obrigatório. Isso impede loops infinitos onde o agente tenta as mesmas variações até esgotar tokens.

---

## Agentes

| Agente | Modelo | Papel | Entrega principal |
|--------|--------|-------|-------------------|
| `@planner` | Opus | Decompõe pedidos em grafo de tarefas `T-001..T-NNN` | `tasks.md`, `PRD.md` |
| `@architect` | Opus | Specs técnicas, padrões (GoF/PoEAA), revisão, documentação | `specs.md`, `design.md`, `docs/arc42/`, ADRs |
| `@designer` | Sonnet | Specs de UI, design tokens, acessibilidade WCAG | `design-spec.md` |
| `@coder` | Sonnet | Implementa código seguindo specs + 70 regras | código em `src/` |
| `@tester` | Sonnet | Valida via testes (evaluator pattern), cobertura ≥85% domínio | testes + relatório |
| `@deepdive` | Opus | Investigação profunda: bugs, performance, segurança | `findings.md` |

Cada agente tem: contrato de entrada, anti-objetivos (o que **não** faz), skills que carrega, regras que aplica e critérios mensuráveis de conclusão.

---

## Regras

70 regras arquiteturais com severidade explícita. Cada regra tem ID, nome, categoria, critérios objetivos, exceções permitidas, método de detecção manual e automática.

| Categoria | IDs | Fonte | Exemplos |
|-----------|-----|-------|----------|
| **Object Calisthenics** | 001–009 | Jeff Bay (Thoughtworks) | Nível único de indentação, proibição de else, encapsulamento de primitivos |
| **SOLID** | 010–014 | Uncle Bob | SRP, OCP, LSP, ISP, DIP |
| **Princípios de Pacote** | 015–020 | Robert C. Martin | REP, CCP, CRP, ADP, SDP, SAP |
| **Clean Code** | 021–039 | Clean Code practices | DRY, KISS, YAGNI, Boy Scout Rule, nomes consistentes |
| **Twelve-Factor** | 040–051 | 12factor.net | Codebase única, config via ambiente, processos stateless, logs como stream |
| **Anti-Patterns** | 052–070 | Fowler + Brown | God Object, Spaghetti, Feature Envy, Middle Man, Callback Hell, Poltergeists |

**Severidades:**
- 🔴 **Crítica** — bloqueada automaticamente por `guard.sh`. Exemplos: 003 (Primitive Obsession), 008 (Getters/Setters), 010 (SRP), 014 (DIP), 025 (God Object), 030 (eval/secrets), 031 (imports relativos).
- 🟠 **Alta** — requer correção antes do PR. Exemplos: 001 (indentação), 002 (else), 011 (OCP), 015–019 (pacotes), 055 (método longo).
- 🟡 **Média** — melhoria esperada na Regra do Escoteiro. Exemplos: 005 (chaining), 006 (nomes abreviados), 022 (KISS), 061 (Middle Man).

**Próximo ID disponível:** `071`.

---

## Skills

35 módulos de conhecimento carregados sob demanda pelos agentes, organizados em grupos temáticos:

| Grupo | Skills |
|-------|--------|
| **Estrutura de classe** | `anatomy`, `constructor`, `bracket` |
| **Membros** | `getter`, `setter`, `method` |
| **Comportamento** | `event`, `dataflow`, `render`, `state` |
| **Dados** | `enum`, `token`, `alphabetical` |
| **Organização** | `colocation`, `revelation`, `story` |
| **Composição** | `mixin`, `complexity`, `big-o` |
| **Anotação** | `codetags` |
| **Princípios OOP** | `object-calisthenics`, `solid`, `package-principles` |
| **Qualidade de código** | `clean-code`, `cdd`, `software-quality` |
| **Infraestrutura** | `twelve-factor` |
| **Design Patterns** | `gof` (23 padrões), `poeaa` (51 padrões) |
| **Documentação** | `arc42`, `c4model`, `adr`, `bdd` |
| **Frontend** | `react`, `anti-patterns` |

### Progressive Disclosure em 3 níveis

Cada skill segue a estrutura:

```
.claude/skills/gof/
├── SKILL.md              ← nível 1 + 2 (frontmatter + manifest)
└── references/
    ├── strategy.md       ← nível 3 (guia completo do padrão)
    ├── factory.md
    └── ...
```

- **Nível 1 (frontmatter)** — sempre carregado. Descreve quando a skill é relevante. Usado pelo agente para *discovery*.
- **Nível 2 (Manifest)** — carregado quando o agente suspeita que a skill é útil. Contém aplicabilidade, pré-requisitos, restrições, escopo. Usado para *seleção*.
- **Nível 3 (references)** — carregado apenas quando o agente vai executar. Contém guia completo, exemplos, anti-patterns. Usado para *execução*.

Esse modelo evita que 35 skills × 10k tokens = 350k tokens sejam despejados no contexto em toda interação.

---

## Memória

Sistema de memória em três camadas com tempos de vida distintos:

### Working (`changes/`)

Memória de **uma feature/task**. Vive enquanto a entrega estiver ativa. Contém:

```
changes/00X_feature-name/
├── PRD.md          ← (Feature) requisitos + regras de negócio
├── design.md       ← (Feature) decisões técnicas + padrões
├── specs.md        ← (Task + Feature) interfaces + critérios de aceitação
├── design-spec.md  ← (UI) spec de componente + acessibilidade
├── findings.md     ← (Research) relatório de investigação
└── tasks.md        ← T-001…T-NNN + contadores de tentativas
```

Quando a feature é encerrada (`/ship`), o conteúdo é consolidado em `memory/episodes/` e o diretório é arquivado.

### Episódica (`memory/episodes/`)

Memória **cross-session**. Preservada para sempre. Cada arquivo é um registro estruturado de uma feature concluída: modo escolhido, agentes usados, duração, arquivos alterados, decisões tomadas, problemas encontrados. Gravada automaticamente por `telemetry.sh` no evento `Stop`.

Usada por `prompt.sh` no início de sessões futuras para **recuperação contextual**: se você abre uma feature nova parecida com uma antiga, episódios relevantes são injetados como referência.

### Procedural (`memory/patterns/`)

**Candidatos a destilação**. Quando `telemetry.sh` detecta que um episódio terminou com `attempts_coder=1` e `attempts_tester=1` (execução limpa), o fluxo é marcado como *padrão candidato*. Se o mesmo padrão aparecer em N episódios, vira candidato a skill ou regra nova.

### Semântica (`memory/semantic/`)

Conhecimento de **domínio do projeto** curado manualmente. Glossários, vocabulário ubíquo, regras de negócio estáveis. Não é gerado automaticamente — é atualizado pelo time quando o domínio muda.

---

## Hooks

6 scripts shell que observam e intervêm no ciclo de vida das interações. Nenhum precisa ser chamado manualmente.

| Hook | Evento | Função |
|------|--------|--------|
| `prompt.sh` | `UserPromptSubmit` | Detecta verbos de ação, injeta dica de modo, recupera episódios relevantes |
| `lint.sh` | `PostToolUse` (Write/Edit) | Auto-formata arquivos escritos via linter do projeto (Biome/ESLint) |
| `security.sh` | `PostToolUse` (Write/Edit) | Bloqueia se detecta credenciais hardcoded (API keys, tokens, senhas) |
| `guard.sh` | `PostToolUse` (Write/Edit) | Bloqueia se detecta violação 🔴 Crítica das 70 regras |
| `loop.sh` | `Stop` | Bloqueia encerramento se houver `- [ ]` pendente em `changes/*/tasks.md` |
| `telemetry.sh` | `Stop` | Grava episódio em `memory/episodes/` e candidatos de padrão em `memory/patterns/` |

### Escape hatch

Se o workflow travar (ex: `loop.sh` bloqueando indevidamente):

```bash
touch .claude/.loop-skip   # pula uma verificação de loop.sh
rm .claude/.loop-skip      # remove após resolver a causa real
```

O escape deve ser **exceção, não rotina**. Se está usando repetidamente, é sinal de que o fluxo ou as specs estão errados.

---

## Comandos

6 comandos slash que disparam workflows completos:

| Comando | Descrição |
|---------|-----------|
| `/start [nome]` | Inicializa nova Feature ou Task em `changes/` com scaffolding completo |
| `/status` | Dashboard de progresso das features ativas |
| `/audit [branch\|pr N\|src/path]` | Revisão arquitetural completa via `@architect` |
| `/docs [path]` | Sincroniza documentação arquitetural (`arc42/`, `c4/`, `adr/`, `bdd/`) |
| `/ship` | Commit com Conventional Commits + push + arquivamento de `changes/` |
| `/sync` | Atualiza branch com remoto |

---

## Quick Start

```bash
# 1. Clone o harness
git clone https://github.com/deMGoncalves/oh-my-claude
cd oh-my-claude

# 2. Abra com Claude Code
claude .
```

**Pré-requisitos:** apenas o Claude Code CLI.

**Dependências opcionais:**
- `gh` (GitHub CLI) — necessário para `/audit` e `/ship`.
- `jq` — necessário para roteamento dos hooks.

Ao abrir, o Claude Code detecta o diretório `.claude/` e carrega automaticamente agentes, regras, skills e hooks. Na primeira interação, o Tech Lead verifica `changes/*/tasks.md` por trabalho em andamento e informa o estado da sessão.

---

## Estrutura de diretórios

```
.claude/
├── CLAUDE.md              ← hub de orquestração (Tech Lead)
├── GRAPH.md               ← grafos de dependências Mermaid
├── README.md              ← referência interna completa do harness
├── agents/                ← 6 agentes especializados
│   ├── planner.md
│   ├── architect.md
│   ├── designer.md
│   ├── coder.md
│   ├── tester.md
│   └── deepdive.md
├── commands/              ← 6 comandos slash
│   ├── start.md
│   ├── status.md
│   ├── audit.md
│   ├── docs.md
│   ├── ship.md
│   └── sync.md
├── hooks/                 ← 6 hooks automáticos
│   ├── prompt.sh
│   ├── lint.sh
│   ├── security.sh
│   ├── guard.sh
│   ├── loop.sh
│   └── telemetry.sh
├── rules/                 ← 70 regras arquiteturais (001–070)
├── skills/                ← 35 skills com progressive disclosure
└── settings.json          ← permissões + configuração de hooks

changes/                   ← memória working (por feature ativa)
└── 00X_feature-name/
    ├── PRD.md, design.md, specs.md, tasks.md, findings.md

memory/                    ← memória persistente cross-session
├── episodes/              ← gerado por telemetry.sh ao concluir feature
├── patterns/              ← candidatos de destilação
└── semantic/              ← conhecimento de domínio curado

docs/                      ← documentação arquitetural sincronizada
├── arc42/                 ← 12 seções arquiteturais
├── c4/                    ← 4 níveis de abstração
├── adr/                   ← Architecture Decision Records
└── bdd/                   ← features Gherkin
```

A documentação interna do harness (conteúdo de `.claude/`) é escrita em português. Este README e arquivos externos (`LICENSE`, `CONTRIBUTING.md`) também estão em português.

---

## Contribuindo

Contribuições são bem-vindas. Abra uma issue para reportar bugs, propor novas regras, skills ou hooks, ou abra um PR seguindo [CONTRIBUTING.md](CONTRIBUTING.md). Propostas de novas regras devem incluir critérios objetivos e método de detecção automática; propostas de novas skills devem seguir o modelo de progressive disclosure em três níveis.

---

## Licença

MIT © [Cleber de Moraes Goncalves](https://github.com/deMGoncalves)

Veja [LICENSE](LICENSE) para detalhes.
