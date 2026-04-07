# How to Contribute

Thank you for wanting to contribute to **oh my claude**! This project is an AI-assisted development workflow — your contribution can help other developers write better code with Claude Code.

## What you can contribute

| Type | Description | Where it lives |
|------|-------------|----------------|
| **New rule** | Architectural rule with objective criteria | `.claude/rules/` |
| **New skill** | Knowledge module for agents | `.claude/skills/` |
| **New command** | Invokable command with `/name` | `.claude/commands/` |
| **Agent improvement** | Refinement of existing agent | `.claude/agents/` |
| **Bug fix** | Error in hook, command or agent | Where the bug is |
| **Documentation** | Improvement to README or markdowns | Project root |

---

## Adding a Rule

Create the file in `.claude/rules/` following the template:

```markdown
# [Rule Title]

**ID**: [CATEGORY-NNN]
**Severity**: [🔴 Critical | 🟠 High | 🟡 Medium]
**Category**: [Structural | Behavioral | Creational | Infrastructure]

---

## What it is

[Clear and concise description]

## Why it matters

[Impact on code and maintainability]

## Objective Criteria

- [ ] [Measurable criterion 1]
- [ ] [Measurable criterion 2]

## Allowed Exceptions

- [When the rule can be ignored]

## How to Detect

### Manual
[What to check in code]

### Automatic
[Tool and configuration: ESLint, Biome, SonarQube]

## Related to

- [NNN - Rule Name](NNN_name.md): [type of relationship]

---

**Created on**: YYYY-MM-DD  **Version**: 1.0
```

**Rules for ID:**
- Object Calisthenics: `001–009` (next: `010`)
- SOLID: `010–014`
- Package Principles: `015–020`
- Clean Code: `021–039`
- Twelve-Factor: `040–051`
- Anti-Patterns: `052–070`
- **New rules:** next available ID is `071`

---

## Adding a Skill

Create directory in `.claude/skills/skill-name/` with `SKILL.md`:

```yaml
---
name: skill-name          # kebab-case
description: "[What it is]. Use when [condition] — [specific triggers]."
model: haiku               # haiku for quick reference, sonnet for analysis
allowed-tools: Read        # minimum necessary
metadata:
  author: YourName
  version: "1.0.0"
---
```

**Body structure:**
```
## When to Use
## [Main content]
## Examples (❌ Bad / ✅ Good)
## Prohibitions
## Rationale  ← links to related rules
```

For skills with lots of content, use `references/`:
```
skill-name/
├── SKILL.md          ← lightweight index
└── references/
    └── detail.md     ← content loaded on demand
```

---

## Adding a Command

Create file in `.claude/commands/name.md`:

```yaml
---
description: "[Main usage in ≤ 250 chars, front-loaded]"
argument-hint: "[expected args]"  # optional
allowed-tools: Tool, Bash(specific command *)
---

## Purpose

[1-2 lines + live context with !`command`]

## Instructions

1. [Step 1]
2. [Step 2]
```

---

## PR Process

1. **Fork** the repository
2. **Create a branch** with descriptive name:
   - `rule/071-rule-name`
   - `skill/skill-name`
   - `fix/bug-description`
3. **Implement** following templates above
4. **Add to CHANGELOG.md** in `[Unreleased]` section
5. **Open a Pull Request** with filled template

### Quality checklist

For **rules:**
- [ ] Unique ID in correct category
- [ ] Objective and measurable criteria (not subjective)
- [ ] Bidirectional cross-references with related rules
- [ ] Justified severity

For **skills:**
- [ ] Complete frontmatter with `metadata.author`
- [ ] Section `## Examples` with ❌/✅
- [ ] `## Rationale` with links to rules
- [ ] Description with specific triggers (≤ 250 chars)

For **commands:**
- [ ] Tested with Claude Code CLI
- [ ] `allowed-tools` with minimum permissions
- [ ] Live context injection with `!`cmd`` where applicable
- [ ] `$ARGUMENTS` used where command accepts args

---

## Code standards

- **Language:** Portuguese for documentation, English for TypeScript code
- **File names:** `kebab-case`
- **Codetags:** educational — explain why, not just what
- **Examples:** always `❌ Bad` before `✅ Good`

## Questions?

Open a [Discussion](https://github.com/melisource/fury_oh-my-claude/discussions) to talk before implementing something big.
