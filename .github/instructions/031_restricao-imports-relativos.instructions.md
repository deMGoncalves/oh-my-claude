---
applyTo: "**"
---

# Proibição de Imports Relativos (Obrigatoriedade de Path Aliases)

**ID**: STRUCTURAL-031
**Severity**: 🔴 Critical
**Category**: Structural

---

## What it is

Proíbe **completamente** o uso de caminhos relativos com `../` e impõe o uso obrigatório de *path aliases* para todos os imports entre módulos.

## Why it matters

*Imports* relativos quebram a **portabilidade** e a **legibilidade** do código. A regra reforça a **Arquitetura Limpa**, garantindo que módulos sejam sempre referenciados por seus aliases (`@agent`, `@dom`, `@event`, etc.), tornando o código mais consistente e fácil de refatorar.

## Objective Criteria

- [ ] É **proibido** o uso de `../` em qualquer caminho de *import*.
- [ ] Todos os módulos devem ser importados exclusivamente por *path aliases* (ex: `import { X } from "@dom/html"`).
- [ ] Apenas imports do mesmo diretório (`./file`) são permitidos para arquivos irmãos.
- [ ] O arquivo de configuração (`vite.config.js` ou `tsconfig.json`) deve definir todos os *paths* necessários.

## Allowed Exceptions

- **Arquivos Irmãos**: *Imports* diretos para arquivos no mesmo diretório (`./file`) são permitidos.

## How to Detect

### Manual

Busca por `../` em qualquer arquivo de código-fonte.

### Automatic

ESLint/Biome: Regra `no-relative-imports` configurada para proibir qualquer uso de `../`.

## Related to

- [014 - Dependency Inversion Principle (DIP)](014_dependency-inversion-principle.md): reinforces
- [018 - Acyclic Dependencies Principle (ADP)](018_acyclic-dependencies-principle.md): reinforces

---

**Created on**: 2025-10-08
**Updated on**: 2026-01-11
**Version**: 2.0
