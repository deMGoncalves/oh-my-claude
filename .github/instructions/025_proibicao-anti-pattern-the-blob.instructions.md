---
applyTo: "**"
---

# Proibição do Anti-Pattern The Blob (God Object)

**ID**: STRUCTURAL-025
**Severity**: 🔴 Critical
**Category**: Structural

---

## What it is

Proíbe a criação de classes que concentram a maior parte da lógica e dados do sistema, resultando em um **Objeto Deus** (The Blob) que outras classes pequenas apenas orbitam e acessam.

*(O anti-pattern Large Class é o estágio inicial de um Blob: Large Class viola SRP por ter responsabilidades demais; The Blob adiciona o domínio de dados centralizados que outras classes apenas orbitam.)*

## Why it matters

Viola o Princípio da Responsabilidade Única (SRP) de forma severa, resultando na **pior forma de acoplamento e baixa coesão**. Torna a classe impossível de testar e o sistema extremamente frágil a mudanças.

## Objective Criteria

- [ ] Uma classe não deve conter mais de **10** métodos públicos (excluindo *getters* e *setters* permitidos).
- [ ] O número de dependências (imports) de classes concretas em uma única classe não deve exceder **5**.
- [ ] Se a classe violar os limites de `STRUCTURAL-007` (50 linhas) e `BEHAVIORAL-010` (7 métodos) deve ser classificada como um *Blob* e refatorada.

## Allowed Exceptions

- **Encapsulamento de Legado**: Grandes classes podem ser aceitas ao encapsular um sistema legado não-OO para acessá-lo a partir do sistema OO.

## How to Detect

### Manual

Identificar classes que estão em constante modificação por vários *feature requests* diferentes.

### Automatic

SonarQube: LCOM (Lack of Cohesion in Methods) e WMC (Weighted Methods Per Class) muito altos.

## Related to

- [010 - Single Responsibility Principle (SRP)](010_single-responsibility-principle.md): supersedes
- [007 - Maximum Lines per Class File](007_max-lines-per-class.md): reinforces
- [039 - Boy Scout Rule (Continuous Refactoring)](039_boy-scout-rule-continuous-refactoring.md): complements
- [056 - Prohibition of Zombie Code (Lava Flow)](056_prohibition-zombie-code-lava-flow.md): reinforces
- [054 - Prohibition of Divergent Change](054_prohibition-divergent-change.md): reinforces

---

**Created on**: 2025-10-08
**Version**: 1.0
