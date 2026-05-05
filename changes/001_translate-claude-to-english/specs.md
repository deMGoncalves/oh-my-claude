# Specs — Translate .claude/ and memory/ to English

## 1. ID Prefix Translation Table

| PT Prefix          | EN Prefix         | Applies to                                 |
|--------------------|-------------------|--------------------------------------------|
| `ESTRUTURAL-NNN`   | `STRUCTURAL-NNN`  | Rules of structural category               |
| `COMPORTAMENTAL-NNN` | `BEHAVIORAL-NNN` | Rules of behavioral category               |
| `CRIACIONAL-NNN`   | `CREATIONAL-NNN`  | Rules of creational category               |
| `INFRAESTRUTURA-NNN` | `INFRASTRUCTURE-NNN` | Rules of infrastructure category       |
| `AP-XX-NNN`        | `AP-XX-NNN`       | Anti-pattern IDs — unchanged               |

Numeric suffixes (001…070) are preserved to keep grep-based tooling and filename ordering stable.

## 2. Filename Mapping (PT → EN)

All rule files keep the `NNN_` numeric prefix. The slug portion is translated to kebab-case English.

| # | PT filename | EN filename |
|---|-------------|-------------|
| 001 | `001_nivel-unico-indentacao.md` | `001_single-indentation-level.md` |
| 002 | `002_proibicao-clausula-else.md` | `002_prohibition-else-clause.md` |
| 003 | `003_encapsulamento-primitivos.md` | `003_primitive-encapsulation.md` |
| 004 | `004_colecoes-primeira-classe.md` | `004_first-class-collections.md` |
| 005 | `005_maximo-uma-chamada-por-linha.md` | `005_one-call-per-line.md` |
| 006 | `006_proibicao-nomes-abreviados.md` | `006_prohibition-abbreviated-names.md` |
| 007 | `007_limite-maximo-linhas-classe.md` | `007_max-lines-per-class.md` |
| 008 | `008_proibicao-getters-setters.md` | `008_prohibition-getters-setters.md` |
| 009 | `009_diga-nao-pergunte.md` | `009_tell-dont-ask.md` |
| 010 | `010_principio-responsabilidade-unica.md` | `010_single-responsibility-principle.md` |
| 011 | `011_principio-aberto-fechado.md` | `011_open-closed-principle.md` |
| 012 | `012_principio-substituicao-liskov.md` | `012_liskov-substitution-principle.md` |
| 013 | `013_principio-segregacao-interfaces.md` | `013_interface-segregation-principle.md` |
| 014 | `014_principio-inversao-dependencia.md` | `014_dependency-inversion-principle.md` |
| 015 | `015_principio-equivalencia-lancamento-reuso.md` | `015_release-reuse-equivalence-principle.md` |
| 016 | `016_principio-fechamento-comum.md` | `016_common-closure-principle.md` |
| 017 | `017_principio-reuso-comum.md` | `017_common-reuse-principle.md` |
| 018 | `018_principio-dependencias-aciclicas.md` | `018_acyclic-dependencies-principle.md` |
| 019 | `019_principio-dependencias-estaveis.md` | `019_stable-dependencies-principle.md` |
| 020 | `020_principio-abstracoes-estaveis.md` | `020_stable-abstractions-principle.md` |
| 021 | `021_proibicao-duplicacao-logica.md` | `021_prohibition-logic-duplication.md` |
| 022 | `022_priorizacao-simplicidade-clareza.md` | `022_simplicity-and-clarity.md` |
| 023 | `023_proibicao-funcionalidade-especulativa.md` | `023_prohibition-speculative-functionality.md` |
| 024 | `024_proibicao-constantes-magicas.md` | `024_prohibition-magic-constants.md` |
| 025 | `025_proibicao-anti-pattern-the-blob.md` | `025_prohibition-the-blob.md` |
| 026 | `026_qualidade-comentarios-porque.md` | `026_comment-quality-why-not-what.md` |
| 027 | `027_qualidade-tratamento-erros-dominio.md` | `027_domain-error-handling-quality.md` |
| 028 | `028_tratamento-excecao-assincrona.md` | `028_async-exception-handling.md` |
| 029 | `029_imutabilidade-objetos-freeze.md` | `029_object-immutability-freeze.md` |
| 030 | `030_proibicao-funcoes-inseguras.md` | `030_prohibition-unsafe-functions.md` |
| 031 | `031_restricao-imports-relativos.md` | `031_prohibition-relative-imports.md` |
| 032 | `032_cobertura-teste-minima-qualidade.md` | `032_minimum-test-coverage-quality.md` |
| 033 | `033_limite-parametros-funcao.md` | `033_max-function-parameters.md` |
| 034 | `034_nomes-classes-metodos-consistentes.md` | `034_consistent-class-method-names.md` |
| 035 | `035_proibicao-nomes-enganosos.md` | `035_prohibition-misleading-names.md` |
| 036 | `036_restricao-funcoes-efeitos-colaterais.md` | `036_side-effect-restrictions.md` |
| 037 | `037_proibicao-argumentos-sinalizadores.md` | `037_prohibition-flag-arguments.md` |
| 038 | `038_conformidade-principio-inversao-consulta.md` | `038_command-query-separation.md` |
| 039 | `039_regra-escoteiro-refatoracao-continua.md` | `039_boy-scout-rule-continuous-refactoring.md` |
| 040 | `040_base-codigo-unica.md` | `040_single-codebase.md` |
| 041 | `041_declaracao-explicita-dependencias.md` | `041_explicit-dependency-declaration.md` |
| 042 | `042_configuracoes-via-ambiente.md` | `042_environment-based-configuration.md` |
| 043 | `043_servicos-apoio-recursos.md` | `043_backing-services-as-resources.md` |
| 044 | `044_separacao-build-release-run.md` | `044_build-release-run-separation.md` |
| 045 | `045_processos-stateless.md` | `045_stateless-processes.md` |
| 046 | `046_port-binding.md` | `046_port-binding.md` |
| 047 | `047_concorrencia-via-processos.md` | `047_concurrency-via-processes.md` |
| 048 | `048_descartabilidade-processos.md` | `048_process-disposability.md` |
| 049 | `049_paridade-dev-prod.md` | `049_dev-prod-parity.md` |
| 050 | `050_logs-fluxo-eventos.md` | `050_logs-as-event-streams.md` |
| 051 | `051_processos-administrativos.md` | `051_admin-processes.md` |
| 052 | `052_proibicao-mutacao-acidental.md` | `052_prohibition-accidental-mutation.md` |
| 053 | `053_proibicao-agrupamentos-dados-repetidos.md` | `053_prohibition-data-clumps.md` |
| 054 | `054_proibicao-mudanca-divergente.md` | `054_prohibition-divergent-change.md` |
| 055 | `055_limite-maximo-linhas-metodo.md` | `055_max-lines-per-method.md` |
| 056 | `056_proibicao-codigo-zombie-lava-flow.md` | `056_prohibition-zombie-code-lava-flow.md` |
| 057 | `057_proibicao-feature-envy.md` | `057_prohibition-feature-envy.md` |
| 058 | `058_proibicao-shotgun-surgery.md` | `058_prohibition-shotgun-surgery.md` |
| 059 | `059_proibicao-heranca-refusao.md` | `059_prohibition-refused-bequest.md` |
| 060 | `060_proibicao-codigo-spaghetti.md` | `060_prohibition-spaghetti-code.md` |
| 061 | `061_proibicao-middle-man.md` | `061_prohibition-middle-man.md` |
| 062 | `062_proibicao-codigo-inteligente-clever-code.md` | `062_prohibition-clever-code.md` |
| 063 | `063_proibicao-inferno-callbacks.md` | `063_prohibition-callback-hell.md` |
| 064 | `064_proibicao-overengineering.md` | `064_prohibition-overengineering.md` |
| 065 | `065_proibicao-poltergeists.md` | `065_prohibition-poltergeists.md` |
| 066 | `066_proibicao-piramide-do-destino.md` | `066_prohibition-pyramid-of-doom.md` |
| 067 | `067_proibicao-dependencia-barco-ancora.md` | `067_prohibition-boat-anchor-dependency.md` |
| 068 | `068_proibicao-martelo-de-ouro.md` | `068_prohibition-golden-hammer.md` |
| 069 | `069_proibicao-otimizacao-prematura.md` | `069_prohibition-premature-optimization.md` |
| 070 | `070_proibicao-estado-mutavel-compartilhado.md` | `070_prohibition-shared-mutable-state.md` |

### Other files (no rename)
All files under `.claude/agents/`, `.claude/commands/`, `.claude/hooks/`, `.claude/skills/`, plus `.claude/CLAUDE.md`, `.claude/GRAPH.md`, `.claude/README.md`, and `memory/*/README.md` keep their current filenames (already English).

## 3. Standard Glossary

| PT | EN |
|----|----|
| Regra | Rule |
| Severidade | Severity |
| Categoria | Category |
| Criado em / Criada em | Created on |
| Atualizada em | Updated on |
| Versão | Version |
| O que é | What it is |
| Por que importa | Why it matters |
| Critérios Objetivos | Objective Criteria |
| Exceções Permitidas | Allowed Exceptions |
| Como Detectar | How to Detect |
| Manual | Manual |
| Automático | Automatic |
| Relacionada com | Related to |
| reforça | reinforces |
| complementa | complements |
| substitui | supersedes |
| depende | depends on |
| Crítica | Critical |
| Alta | High |
| Média | Medium |
| Estrutural | Structural |
| Comportamental | Behavioral |
| Criacional | Creational |
| Infraestrutura | Infrastructure |
| Proibição de | Prohibition of |
| Princípio | Principle |
| proibido / proibida | forbidden |
| permitido / permitida | allowed |

## 4. Link-Rewrite Algorithm

For every `.md` file under `.claude/` and `memory/`:

1. Replace all occurrences of each PT rule filename with its EN counterpart (full string match on `NNN_*.md`).
2. Replace PT link-display text `[NNN - <PT title>]` with `[NNN - <EN title>]` per mapping.
3. Preserve anchor fragments (`#section`) verbatim — none currently in use, but guard against future ones.
4. Validate each link resolves to an existing file after Phase 2 completes.

## 5. Skills Audit Scope

`.claude/skills/` inspection shows filenames and most content already English (e.g., `01_introduction_and_goals.md`, `feature-template.md`, `srp.md`). **Strategy**: grep each SKILL.md and reference file for PT tokens (`ção`, `não`, `é `, `proibiç`, `regra`, `código`); translate only files with hits. Expected volume: low (estimated <20 files need translation).

## 6. Hook Scripts Policy

For `.claude/hooks/*.sh`:
- Translate shell comments (`#`) and any user-facing `echo`/`printf` strings.
- Do not rename variables, functions, paths, or grep patterns — these may be referenced by Claude Code runtime.
- Validate with `bash -n` after each file.

## 7. Acceptance Criteria

- [ ] 70 rule files renamed and content-translated
- [ ] Zero broken Markdown links across `.claude/` and `memory/`
- [ ] Zero Portuguese tokens in prose of any translated file (user-facing ML domain terms excepted)
- [ ] `settings.json`, `settings.local.json`, `telemetry/*.jsonl` byte-identical to pre-change
- [ ] All hooks pass `bash -n`
- [ ] GRAPH.md, README.md, CLAUDE.md updated with new filenames
- [ ] ADR documenting the rename published under `memory/semantic/`
