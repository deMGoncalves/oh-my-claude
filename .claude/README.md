# oh my claude — Workflow Reference

Personal AI-assisted development workflow encoded into agents, rules and skills for [Claude Code](https://code.claude.com). This file documents how `.claude/` works.

---

## Structure

```
.claude/
├── CLAUDE.md          ← central hub (loaded automatically by Claude Code)
├── GRAPH.md           ← dependency map between rules, skills and agents (Mermaid)
├── agents/            ← 5 specialized agents
├── skills/            ← 35 skills (code + architecture + quality)
├── rules/             ← 70 architectural rules (001–070)
├── commands/          ← 6 workflow commands
├── hooks/             ← 3 automatic hooks
└── settings.json      ← permissions + hooks configuration

changes/               ← persistent feature context (created per feature/task)
└── 00X_feature-name/
    ├── PRD.md         ← (Feature only) requirements + business rules
    ├── design.md      ← (Feature only) technical decisions + patterns
    ├── specs.md       ← (Task + Feature) interfaces + acceptance criteria
    └── tasks.md       ← T-001…T-NNN + attempt counters

docs/                  ← synced architectural documentation
├── arc42/             ← 12 architectural sections
├── c4/                ← 4 abstraction levels
├── adr/               ← Architecture Decision Records
└── bdd/               ← Gherkin features
```

---

## Architecture

### Components and connections

```
 ┌──────────────────────────────────────────────────────────────┐
 │                          .claude/                            │
 │                                                              │
 │  ┌──────────────┐  ┌────────────────┐  ┌─────────────────┐   │
 │  │   hooks/     │  │   commands/    │  │    agents/      │   │
 │  │              │  │                │  │                 │   │
 │  │ prompt.sh    │  │  /start        │  │  🔵 @leader     │   │
 │  │ ↳ mode hint  │  │  /status       │  │  🟢 @architect  │   │
 │  │              │  │  /audit        │  │  🟡 @developer  │   │
 │  │ lint.sh      │  │  /docs         │  │  🔴 @tester     │   │
 │  │ ↳ biome fmt  │  │  /ship  /sync  │  │  🟣 @reviewer   │   │
 │  │              │  │                │  │                 │   │
 │  │ loop.sh      │  └────────────────┘  └────────┬────────┘   │
 │  │ ↳ tasks.md   │                               │            │
 │  └──────┬───────┘                               │            │
 │         └───────────────────────────────────────┘            │
 │                              │ load                          │
 │  ┌───────────────────────────▼───────────────────────────┐   │
 │  │   skills/ (35)                    rules/ (70)         │   │
 │  │                                                       │   │
 │  │  cdd · codetags · complexity    001–009 Object Cal.   │   │
 │  │  solid · gof · poeaa            010–014 SOLID         │   │
 │  │  colocation · clean-code · ...  052–070 Anti-Patterns │   │
 │  └───────────────────────────────────────────────────────┘   │
 └──────────────────────────────────────────────────────────────┘
```

### Task flow

```
  user input
       │
  ┌────▼──────────────────────────────────────────┐
  │ prompt.sh — detects action verb → injects mode │
  └────┬──────────────────────────────────────────┘
       │
  ┌────▼─────────────────────────────────────────────────┐
  │                  🔵 @leader                          │
  │         classifies → Quick / Task / Feature          │
  └────┬─────────────────────┬──────────────┬────────────┘
       │                     │              │
    Quick                  Task          Feature
       │                     │              │
       │              ┌──────▼──────┐  ┌───▼──────────────┐
       │              │ 🟢 @arch    │  │   🟢 @architect   │
       │              │ light specs │  │ PRD+design+specs │
       │              └──────┬──────┘  └───┬──────────────┘
       │                     │             │
       └─────────────────────┴─────────────┘
                             │
                  src/[context]/[container]/[component]/
                             │
  ┌──────────────────────────▼────────────────────────────┐
  │ 🟡 @developer — controller · service · model · repo   │
  └──────────────────────────┬────────────────────────────┘
                  [lint.sh → biome format on each Write]
  ┌──────────────────────────▼────────────────────────────┐
  │ 🔴 @tester — bun test --coverage  ≥ 85% domain        │
  └──────────────────────────┬────────────────────────────┘
  ┌──────────────────────────▼────────────────────────────┐
  │ 🟣 @reviewer — ICP · 70 rules · security              │
  │               educational codetags in code            │
  └────────────┬─────────────────────────┬────────────────┘
               │                         │
         ✅ Approved              ❌ Rejected
               │                    ↩ @developer (up to 3x)
  [loop.sh checks tasks.md · blocks if - [ ] exists]
```

---

## How it works

Every development request goes through `@leader`, which **classifies the request into one of 3 modes before acting**:

### Quick Mode — 🟡 @developer direct

For point changes in ≤ 2 files without new domain entity.

```
"fix typo in UserController"
"remove console.log from src/"
"adjust timeout from 30s to 60s"
    ↓
🟡 @developer → 🔴 @tester → 🟣 @reviewer → Done
```

### Task Mode — light specs + Code

For new interface contract, clear scope, without architectural uncertainty.

```
"add endpoint POST /users/:id/roles"
"integrate SendGrid in registration flow"
    ↓
changes/00X/ + 🟢 @architect specs.md
    ↓
🟡 @developer → 🔴 @tester → 🟣 @reviewer → Done
```

### Feature Mode — Full Spec Flow

For new domain entity, technical uncertainty, broad architectural impact.

```
"implement OAuth2 authentication with Google"
"create billing module with Stripe"
    ↓
Phase 1: 🟢 @architect Research (PRD + design + specs)
Phase 2: 🔵 @leader creates tasks.md
Phase 3: 🟡 @developer → 🔴 @tester → 🟣 @reviewer (loops ≤ 3x)
Phase 4: 🟢 @architect Docs Sync (arc42, c4, adr, bdd)
```

### Feedback loop (Phase 3)

```
🟡 @developer → 🔴 @tester ──(failed ≤3x)──→ 🟡 @developer
                      │
                   (passed)
                      ↓
              🟣 @reviewer ──(rejected ≤3x)──→ 🟡 @developer
                      │                                │
                  (approved)            (attempts-developer ≥ 3)
                      ↓                                ↓
              🔵 @leader finalizes          🔵 @leader → Re-Spec
             (Docs if Feature)         (🟢 @architect revises specs.md)
```

---

## Agents

| Agent        | Model  | Role                                                                            |
| ------------ | ------ | ------------------------------------------------------------------------------- |
| `@leader`    | opus   | Classifies Quick/Task/Feature, orchestrates phases, manages re-spec             |
| `@architect` | opus   | Full Research (PRD+design+specs) or light specs — maintains docs/               |
| `@developer` | sonnet | Implements via specs.md or direct request (Quick)                               |
| `@tester`    | sonnet | Generates and runs tests — `bun test --coverage` — coverage ≥85% domain         |
| `@reviewer`  | opus   | CDD/ICP + 70 rules + security (ApplicationSecurityMCP) — annotates via codetags |

### Anti-goals (what each agent does NOT do)

| Agent        | Does not                                                              |
| ------------ | --------------------------------------------------------------------- |
| `@leader`    | Write code, create tests, do review, create architectural docs        |
| `@architect` | Implement code, run tests, do functional review                       |
| `@developer` | Decide architecture/patterns, create specs, do CDD/ICP review         |
| `@tester`    | Change production code, do architectural review                       |
| `@reviewer`  | Implement code, create tests, sync docs                               |

Full system prompts in `agents/`.

---

## Commands

| Command                              | When to use                                                                 |
| ------------------------------------ | --------------------------------------------------------------------------- |
| `/start [feature-name]`              | Initializes `changes/00X_name/` with PRD, design, specs and tasks templates |
| `/status`                            | Dashboard: features in progress, completed tasks, current phase, counters   |
| `/audit [branch\|pr <n>\|src/path]`  | Full code review via @reviewer — posts result directly to PRs               |
| `/docs [src/path]`                   | Syncs `docs/` (arc42, c4, adr, bdd) — works without Spec Flow              |
| `/ship`                              | Prepares Conventional Commits commit and pushes to remote                   |
| `/sync`                              | Updates branch with latest changes from remote repository                   |

Full prompts in `commands/`.

---

## Automatic hooks

The 3 hooks form an automatic chain — execute without any manual invocation:

```
User types something
    ↓
[1] prompt.sh ← UserPromptSubmit
    Detects if dev task → injects mode hint for @leader

Claude responds, writes/edits files
    ↓
[2] lint.sh ← PostToolUse (Write|Edit|NotebookEdit)
    Auto-formats with biome entire .ts/.tsx/.js/.jsx/.json file

Claude finishes responding
    ↓
[3] loop.sh ← Stop
    Checks tasks.md — blocks if pending tasks exist ( - [ ] )
```

### Details of each hook

**`prompt.sh` — Mode routing**

Detects action verbs in the user prompt and injects a mode hint into the system prompt so `@leader` classifies before acting:

```bash
"create endpoint POST /users"    → hint: Task Mode
"implement OAuth2"               → hint: Feature Mode
"fix typo in controller"         → hint: Quick Mode

# Does NOT trigger (conceptual questions are ignored)
"what is SOLID principle?"
"how does @reviewer work?"
```

**`lint.sh` — Automatic formatting**

Runs `bunx biome check --write` on every file written or edited. Covered extensions: `.ts` `.tsx` `.js` `.jsx` `.json`.

**`loop.sh` — Workflow guardian**

Searches `changes/*/tasks.md` for unchecked items (`- [ ]`). If any exist, blocks the response and returns to `@leader` to continue.

```bash
# Escape hatch — use if the workflow gets stuck:
touch .claude/.loop-skip
rm .claude/.loop-skip  # remove after resolving
```

| Event                                        | Hook        | File                      |
| -------------------------------------------- | ----------- | ------------------------- |
| `PostToolUse` — `Write\|Edit\|NotebookEdit`  | `lint.sh`   | `.claude/hooks/lint.sh`   |
| `Stop`                                       | `loop.sh`   | `.claude/hooks/loop.sh`   |
| `UserPromptSubmit`                           | `prompt.sh` | `.claude/hooks/prompt.sh` |

---

## Rules (70)

Architectural rules organized by category. Each rule has: definition, objective criteria, exceptions, how to detect (manual + automatic) and bidirectional cross-references.

| Category            | IDs     | Source                         |
| ------------------- | ------- | ------------------------------ |
| Object Calisthenics | 001–009 | Jeff Bay                       |
| SOLID               | 010–014 | Uncle Bob                      |
| Package Principles  | 015–020 | Uncle Bob                      |
| Clean Code          | 021–039 | Clean Code + general practices |
| Twelve-Factor       | 040–051 | 12factor.net                   |
| Anti-Patterns       | 052–070 | Fowler + Brown                 |

**Severity:** 🔴 blocks PR · 🟠 requires justification · 🟡 improvement expected

**Next available ID:** `071`

Full rules in `rules/`.

---

## Skills (35)

Knowledge modules agents load on demand. Follow the **Progressive Disclosure** principle: `SKILL.md` is the lightweight index; details are in `references/`.

| Group               | Skills                                                                                             |
| ------------------- | -------------------------------------------------------------------------------------------------- |
| Class structure     | anatomy, constructor, bracket                                                                      |
| Members             | getter, setter, method                                                                             |
| Behavior            | event, dataflow, render, state                                                                     |
| Data                | enum, token, alphabetical                                                                          |
| Organization        | colocation, revelation, story                                                                      |
| Composition         | mixin, complexity                                                                                  |
| Performance         | big-o                                                                                              |
| Annotation          | **codetags** (16 documented tags)                                                                  |
| OOP Principles      | **object-calisthenics** (9 rules), **solid** (5 principles), **package-principles** (6 principles) |
| Code Practices      | **clean-code** (rules 021–039)                                                                     |
| Methodology         | **cdd** (Cognitive-Driven Development — ICP = CC_base + Nesting + Responsibilities + Coupling)     |
| Infrastructure      | **twelve-factor** (12 factors)                                                                     |
| Design Patterns     | **gof** (23 patterns), **poeaa** (51 patterns)                                                     |
| Documentation       | **arc42** (12 sections), **c4model** (4 levels), **adr**, **bdd**                                  |
| Quality             | **software-quality** (McCall Model — 12 factors)                                                   |
| Frontend            | **react** (patterns + 2026 rendering strategies)                                                   |
| Anti-Patterns       | **anti-patterns** (26 cataloged patterns)                                                          |

Full skills in `skills/`.

---

## ICP — Integrated Cognitive Persistence

`@reviewer` measures cognitive load of each method using ICP:

```
ICP = CC_base + Nesting + Responsibilities + Coupling
```

| ICP  | Status        | Action                          |
| ---- | ------------- | ------------------------------- |
| ≤ 3  | 🟢 Excellent  | Maintain                        |
| 4–6  | 🟡 Acceptable | Consider refactoring            |
| 7–10 | 🟠 Concerning | Refactor before new feature     |
| > 10 | 🔴 Critical   | Mandatory refactoring           |

Objective limits that define approved/rejected ICP:

| Metric                           | Limit | Rule |
| -------------------------------- | ----- | ---- |
| Cyclomatic Complexity per method | ≤ 5   | 022  |
| Lines per class                  | ≤ 50  | 007  |
| Lines per method                 | ≤ 15  | 055  |
| Parameters per function          | ≤ 3   | 033  |
| Chaining per line                | ≤ 1   | 005  |
| Indentation level                | ≤ 1   | 001  |

---

## Codetags

`@reviewer` annotates violations directly in code with educational tone — explaining why and the path to improve. Never reference internal configuration files.

| Tag             | Severity | Blocks PR?      |
| --------------- | -------- | --------------- |
| `FIXME`         | Critical | Yes             |
| `TODO`          | High     | No — should fix |
| `XXX`           | Medium   | No — improvement|
| `SECURITY`      | Critical | Yes             |
| `HACK`          | High     | No              |
| `OPTIMIZE`      | Medium   | No              |
| `NOTE` / `INFO` | Low      | No              |

```typescript
// FIXME: This class is taking on too many responsibilities — handles both
// authentication and database access. This makes it hard to test each part
// independently. Separating into Repository resolves this.

// TODO: With 5 parameters, it's hard to know what each represents.
// Grouping into UserCreateInput makes the call more expressive.

// XXX: The nested if/else works, but reading is tiring.
// Early returns (guard clauses) linearize the flow.
```

Full tag reference in `skills/codetags/`.

---

## Dependency graph

`GRAPH.md` contains 4 Mermaid diagrams:

1. **Rule layers** — OC → SOLID → Package → Clean Code → 12-Factor + Anti-Patterns
2. **Skills → Rules** — which skill covers which rules
3. **Skills → Skills** — interdependencies between skills
4. **Agents → Skills → Rules** — which agent uses what
