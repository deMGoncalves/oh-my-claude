# Plan — Translate .claude/ and memory/ from Portuguese to English

<!-- mode: Feature -->
<!-- attempts-coder: 0 -->
<!-- attempts-tester: 0 -->

## Summary

Full translation of the harness configuration (`.claude/` and `memory/`) from Brazilian Portuguese to English, including file renames, content translation, and revalidation of cross-references across all Markdown links. Structural config files (`settings.json`, `settings.local.json`, `telemetry/*.jsonl`) are preserved as-is. Skills directory (`.claude/skills/`) is already predominantly in English — requires audit, not full translation.

## Classification: Feature

## Estimated Scope

- Files to rename: 70 rules + ~15 other .md = ~85 renames
- Files to modify (content-only): ~250 (skills audits + docs)
- Files to create: 0 new
- Risk: **High**

## Risk Flags

- **Reversibility Risk**: large-scale rename breaks any external link to old filenames; git history preserved via `git mv`.
- **Coordination Risk**: hooks (`prompt.sh`, `loop.sh`, etc.) may reference specific filenames or strings in Portuguese — search required before mutation.
- **Cross-reference integrity**: each rule links to 3–15 other rules. One missed rename cascades into dozens of broken links. Automated validation required.
- **ID stability**: Portuguese category IDs (`ESTRUTURAL-001`, `COMPORTAMENTAL-010`, `CRIACIONAL-003`, `INFRAESTRUTURA-040`, `AP-XX-NNN`) must be translated consistently (`STRUCTURAL`, `BEHAVIORAL`, `CREATIONAL`, `INFRASTRUCTURE`, `AP-XX-NNN`). Changing IDs breaks any grep-based tooling; propose to **keep numeric suffixes**, translate category prefixes.
- **Scope creep**: `.claude/skills/` is ~170 files largely in English already — must be audited, not blindly retranslated.

## Agent Sequence

1. @architect → finalize `specs.md` with exact filename mapping + ID translation table + link-rewrite algorithm
2. @coder → execute rename + content translation in phases (P1…P5)
3. @tester → validate: zero broken links, zero untranslated PT strings, all hooks still executable
4. @architect → sync `GRAPH.md`, `README.md`, `CLAUDE.md` cross-refs + write ADR for the rename decision

## Tasks

### T-001: Finalize translation specs
**Agent:** @architect
**Input:** This `tasks.md` + full file inventory (listed below)
**Output:** `changes/001_translate-claude-to-english/specs.md`
**Success:** Complete mapping table (PT filename → EN filename) for all 70 rules + all other .md files; ID translation table; decision on skills/ audit scope; link-rewrite algorithm documented
- [ ] specs.md created with 85+ filename mappings
- [ ] ID prefix translation table (ESTRUTURAL→STRUCTURAL, etc.)
- [ ] Glossary of standard term translations (regra→rule, severidade→severity, etc.)

### T-002: Phase 1 — Translate rules content (no renames yet)
**Agent:** @coder
**Input:** `specs.md` + 70 files in `.claude/rules/`
**Output:** 70 rules with English content, original PT filenames kept temporarily
**Success:** All 70 rules: title, body, "What is", "Why it matters", "Objective Criteria", "Allowed Exceptions", "How to Detect", "Related to" translated to English; IDs translated per spec; internal rule-to-rule link text translated but paths unchanged
- [ ] All 70 rule files content-translated
- [ ] Link texts updated (e.g., `[008 - Proibição de Getters/Setters]` → `[008 - Prohibition of Getters/Setters]`)
- [ ] Link paths still point to PT filenames (phase 2 will rename)

### T-003: Phase 2 — Rename rule files + rewrite link paths
**Agent:** @coder
**Input:** Translated rules + mapping table in `specs.md`
**Output:** 70 rules renamed; all `.md` link paths updated across entire `.claude/` tree
**Success:** `git mv` used for each rename (history preserved); all occurrences of old filenames replaced in every `.md` inside `.claude/` and `memory/`; zero references to PT filenames remain
- [ ] All 70 files renamed via `git mv`
- [ ] Global find-replace of old paths in all .md files
- [ ] grep for old PT filenames returns zero matches

### T-004: Phase 3 — Translate agents, commands, root docs
**Agent:** @coder
**Input:** `.claude/agents/*.md`, `.claude/commands/*.md`, `.claude/CLAUDE.md`, `.claude/GRAPH.md`, `.claude/README.md`
**Output:** All these files in English; no renames (names already English)
**Success:** All prose, tables, headings, code-block comments translated; any references to rule filenames updated to EN paths
- [ ] 6 agents + 6 commands + 3 root docs translated
- [ ] All rule path references use new EN filenames

### T-005: Phase 4 — Translate hooks (comments only)
**Agent:** @coder
**Input:** `.claude/hooks/*.sh` (6 files)
**Output:** Shell scripts with English comments; shell logic byte-identical
**Success:** Only `#` comments, `echo`/log strings in Portuguese, and hint messages are translated; no change to control flow, variable names, or paths; `bash -n` syntax check passes for each script
- [ ] 6 hook scripts translated
- [ ] `bash -n` passes on each
- [ ] Functional behavior unchanged

### T-006: Phase 5 — Audit and translate skills/ + memory/
**Agent:** @coder
**Input:** `.claude/skills/**/*.md` (~170 files), `memory/**/README.md` (3 files)
**Output:** Any Portuguese content translated; English-only files untouched
**Success:** grep for PT-specific tokens (é, são, não, proibição, código, não é, etc.) returns zero matches in skills/ and memory/
- [ ] skills/ audited file-by-file; only PT content translated
- [ ] 3 memory/ READMEs translated
- [ ] PT-token grep returns zero

### T-007: Validation — cross-references + untranslated strings
**Agent:** @tester
**Input:** Full post-translation tree
**Output:** Validation report
**Success:** (1) Every `[text](path.md)` link resolves to an existing file; (2) zero occurrences of common PT words in any .md except intentional (user-facing ML terms); (3) all .sh hooks executable and syntax-valid; (4) `.claude/settings.json` + `.jsonl` untouched (diff confirms)
- [ ] Link checker: 100% of internal .md links resolve
- [ ] PT-token scan: zero false positives
- [ ] `bash -n` passes for all hooks
- [ ] Settings/telemetry bytes unchanged

### T-008: Sync docs and write ADR
**Agent:** @architect
**Input:** Fully translated tree
**Output:** Updated `GRAPH.md`, `README.md`, `CLAUDE.md`; new ADR in memory/semantic/ documenting rename
**Success:** GRAPH.md reflects new EN filenames; README.md cites EN rule names; ADR entry explains translation decision + ID mapping
- [ ] GRAPH.md updated
- [ ] README.md updated
- [ ] ADR written

## File Inventory (authoritative)

### To rename + translate (rules, 70 files)
`.claude/rules/001_nivel-unico-indentacao.md` … `.claude/rules/070_proibicao-estado-mutavel-compartilhado.md`
(Full list in specs.md with EN target names.)

### To translate, no rename (names already English)
- `.claude/CLAUDE.md`, `.claude/GRAPH.md`, `.claude/README.md`
- `.claude/agents/{architect,coder,deepdive,designer,planner,tester}.md`
- `.claude/commands/{audit,docs,ship,start,status,sync}.md`
- `.claude/hooks/{guard,lint,loop,prompt,security,telemetry}.sh` (comments only)

### To audit (translate only if PT found)
- `.claude/skills/**/*.md` (~170 files — SKILL.md + references/)
- `memory/{episodes,patterns,semantic}/README.md`

### Do NOT touch
- `.claude/settings.json`, `.claude/settings.local.json`
- `.claude/telemetry/intent.jsonl`, `.claude/telemetry/sessions.jsonl`
