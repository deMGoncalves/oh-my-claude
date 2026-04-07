# Changelog

All notable changes to this project are documented here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/).

---

## [Unreleased]

### Added
- MCP support: `fetch`, `figma`, `github`, `memory`
- Command `/audit` for code review of branch, PR, or src/ path
- Skill `colocation` with Vertical Slice Architecture (Context → Container → Component)
- Skill `software-quality` with McCall Quality Model (12 factors)
- 8 new principle skills: `object-calisthenics`, `solid`, `package-principles`, `clean-code`, `cdd`, `twelve-factor`, `anti-patterns`, `react`

---

## [1.0.0] — 2026-04-01

### Added

**Agents (5)**
- `@leader` — Tech Lead that classifies Quick/Task/Feature and orchestrates workflow
- `@architect` — Solution Architect with full Research and Light Specs
- `@developer` — Developer with Vertical Slice Architecture
- `@tester` — QA Engineer with `bun test --coverage` (≥85% domain)
- `@reviewer` — Code Reviewer with CDD/ICP + 70 rules + security

**Rules (70)**
- Object Calisthenics 001–009 (Jeff Bay)
- SOLID 010–014 (Uncle Bob)
- Package Principles 015–020 (Robert C. Martin)
- Clean Code 021–039
- Twelve-Factor 040–051
- Anti-Patterns 052–070 (Fowler + Brown)

**Skills (27 initial)**
- Class structure: anatomy, constructor, bracket
- Members: getter, setter, method
- Behavior: event, dataflow, render, state
- Data: enum, token, alphabetical
- Organization: colocation, revelation, story
- Composition: mixin, complexity
- Performance: big-o
- Annotation: codetags
- Design Patterns: gof (23 patterns), poeaa (51 patterns)
- Documentation: arc42, c4model, adr, bdd

**Commands (5)**
- `/start` — Initialize feature with templates
- `/status` — Progress dashboard
- `/docs` — Sync architectural documentation
- `/ship` — Commit with Conventional Commits + push
- `/sync` — Update branch with remote

**Hooks (3)**
- `lint.sh` — Auto-format with Biome on PostToolUse
- `loop.sh` — Guard workflow with tasks.md on Stop
- `prompt.sh` — Quick/Task/Feature routing on UserPromptSubmit

**MCPs (4 initial)**
- cloudflare, context7, puppeteer, storybook

---

[Unreleased]: https://github.com/melisource/fury_oh-my-claude/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/melisource/fury_oh-my-claude/releases/tag/v1.0.0
