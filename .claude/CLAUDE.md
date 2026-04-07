# oh my claude

You are in **Cleber de Moraes Goncalves**'s project ([@deMGoncalves](https://github.com/deMGoncalves)).
This is the personal AI-assisted development workflow. Follow the conventions below in every interaction.

---

## When receiving a development request

**Classify first.** Before any action, determine the mode:

| Mode | When | What to do |
|------|------|------------|
| **Quick** | Targeted fix, ≤ 2 files, no new entity | Go directly to @developer |
| **Task** | New interface contract, clear scope | Create `changes/00X/` + request specs from @architect |
| **Feature** | New entity, technical uncertainty, broad impact | Execute all 4 phases |

If the request is ambiguous, ask the user which mode they prefer before proceeding.

### Quick heuristic

1. Changes ≤ 2 existing files with no new contract? → **Quick**
2. Has new interface but existing domain? → **Task**
3. New bounded context, auth, or impact across N modules? → **Feature**

---

## Available agents

Consult `.claude/agents/` for the full system prompt of each agent.

| Agent | Color | When to use |
|-------|-------|-------------|
| @leader | blue | Orchestration — classifies, delegates, manages re-spec |
| @architect | green | Research (PRD+design+specs) or specs light |
| @developer | yellow | Implementation (Quick: direct request / Task+Feature: via specs.md) |
| @tester | red | Tests — `bun test --coverage` — coverage ≥85% domain |
| @reviewer | purple | Code review — CDD/ICP + 70 rules + security |

**Feedback loops are limited to 3 iterations.** After 3 @developer failures, trigger re-spec via @architect.

---

## Available skills

Load the relevant skill for the context. Location: `.claude/skills/`

| Context | Skills |
|---------|--------|
| Code review | `cdd`, `codetags`, `software-quality`, `complexity` |
| Implementation | `complexity`, `codetags`, `clean-code`, `anti-patterns` |
| src/ structure | `colocation` — all implementation uses vertical slice `src/[context]/[container]/[component]/` |
| Architectural design | `gof`, `poeaa`, `solid`, `package-principles` |
| Documentation | `arc42`, `c4model`, `adr`, `bdd` |
| Infrastructure | `twelve-factor` |
| React frontend | `react` |

---

## Rules (70)

Apply the rules in `.claude/rules/`. Severity:
- 🔴 **Critical** — do not submit code with violation
- 🟠 **High** — fix before delivering
- 🟡 **Medium** — annotate with codetag

| Category | IDs |
|----------|-----|
| Object Calisthenics | 001–009 |
| SOLID | 010–014 |
| Package Principles | 015–020 |
| Clean Code | 021–039 |
| Twelve-Factor | 040–051 |
| Anti-Patterns | 052–070 |

Next available ID: `071`

---

## Codetags

When identifying violations, annotate directly in the code with an **educational tone** — explain the why, the impact, and the path to improvement. Never reference internal configuration files.

Available tags: `FIXME` (critical), `TODO` (high), `XXX` (medium), `SECURITY` (critical), `OPTIMIZE` (medium), `NOTE` / `INFO` (low)

```typescript
// FIXME: This function concatenates user input directly into the query, opening
// the door for SQL Injection. Prepared statements solve this by separating
// code from data — and they also make the code more readable.

// TODO: With 5 parameters, it's hard to know what each one represents in the
// call. Grouping them into a configuration object makes the intent clear and
// makes it easier to add fields without breaking existing callers.

// XXX: The nested if/else works, but it's tiring to read. Early returns
// (guard clauses) linearize the flow — each condition becomes
// obvious without having to track the nesting.
```

---

## Commands

Use the commands in `.claude/commands/` for workflow operations:

| Command | When to trigger |
|---------|----------------|
| `/start [name]` | Initialize new Feature or Task |
| `/status` | View progress of features in progress |
| `/audit [branch\|pr <n>\|src/path]` | Full code review via @reviewer — posts to PR if desired |
| `/docs [path]` | Sync architectural documentation |
| `/ship` | Commit and publish changes |
| `/sync` | Update branch with remote |

---

## Persistent context

Each Feature/Task maintains context in `changes/00X_name/`:
- `PRD.md` — (Feature only) requirements and business rules
- `design.md` — (Feature only) technical decisions and patterns
- `specs.md` — interfaces, contracts, acceptance criteria
- `tasks.md` — tasks + counters: `<!-- attempts-developer: 0 -->`, `<!-- attempts-tester: 0 -->`, `<!-- attempts-reviewer: 0 -->`

---

## Active hooks

| Event | Behavior |
|-------|----------|
| `PostToolUse` Write/Edit | automatic `biome check --write` on .ts/.tsx/.js/.jsx/.json |
| `Stop` | Blocks if there are pending `- [ ]` items in `changes/*/tasks.md` |
| `UserPromptSubmit` | Injects mode hint (Quick/Task/Feature) when processing requests |

If the loop gets stuck: `touch .claude/.loop-skip` — remove after resolving.

---

## Dependency graph

Consult `.claude/GRAPH.md` for the complete dependency map between rules, skills and agents.
