# Aplicação do Princípio da Responsabilidade Única (SRP)

**ID**: BEHAVIORAL-010
**Severity**: 🔴 Critical
**Category**: Behavioral

---

## What it is

Exige que uma classe ou módulo tenha apenas uma razão para mudar, o que implica que deve ter uma única responsabilidade.

## Why it matters

A violação do SRP causa **baixa coesão** e **alto acoplamento**, tornando as classes frágeis e difíceis de testar. Aumenta o custo de manutenção, pois uma mudança em uma área de negócio pode quebrar outra.

## Objective Criteria

- [ ] Uma classe não deve conter lógica de negócio e lógica de persistência (ex: *Service* e *Repository* juntos).
- [ ] O número de métodos públicos de uma classe não deve exceder **7**.
- [ ] O **Lack of Cohesion in Methods (LCOM)** deve ser inferior a 0.75.

## Allowed Exceptions

- **Classes de Utilidade/Helpers**: Classes estáticas que agrupam funções puras sem estado para manipulação de dados genéricos (ex: formatadores de data).

## How to Detect

### Manual

Perguntar: "Se houver uma mudança no requisito X e no requisito Y, esta classe precisa ser alterada em ambas as situações?" (SRP violado se a resposta for sim).

### Automatic

SonarQube: Alta `Cognitive Complexity` e `LCOM (Lack of Cohesion in Methods)` alto.

## Related to

- [007 - Maximum Lines per Class File](007_max-lines-per-class.md): reinforces
- [004 - First-Class Collections](004_first-class-collections.md): reinforces
- [011 - Open/Closed Principle (OCP)](011_open-closed-principle.md): complements
- [025 - Prohibition of The Blob Anti-Pattern](025_prohibition-the-blob.md): complements
- [021 - Prohibition of Logic Duplication (DRY)](021_prohibition-logic-duplication.md): reinforces
- [022 - Simplicity and Clarity (KISS)](022_simplicity-and-clarity.md): reinforces
- [015 - Release-Reuse Equivalence Principle (REP)](015_release-reuse-equivalence-principle.md): reinforces
- [016 - Common Closure Principle (CCP)](016_common-closure-principle.md): reinforces
- [032 - Minimum Test Coverage Quality](032_minimum-test-coverage-quality.md): reinforces
- [033 - Maximum Function Parameters](033_max-function-parameters.md): reinforces
- [034 - Consistent Class and Method Names](034_consistent-class-method-names.md): reinforces
- [037 - Prohibition of Flag Arguments](037_prohibition-flag-arguments.md): reinforces
- [038 - Princípio de Separação de Comando-Consulta](038_command-query-separation.md): reinforces
- [001 - Single-Level Indentation Rule](001_single-indentation-level.md): complements
- [047 - Concurrency via Processes](047_concurrency-via-processes.md): complements
- [054 - Prohibition of Divergent Change](054_prohibition-divergent-change.md): reinforces
- [058 - Prohibition of Shotgun Surgery](058_prohibition-shotgun-surgery.md): reinforces

---

**Created on**: 2025-10-04
**Version**: 1.0
