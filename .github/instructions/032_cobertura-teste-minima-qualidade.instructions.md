---
applyTo: "**"
---

# Cobertura Mínima de Teste e Qualidade (TDD)

**ID**: BEHAVIORAL-032
**Severity**: 🔴 Critical
**Category**: Behavioral

---

## What it is

Estabelece um limite mínimo obrigatório de **Cobertura de Código** para o Módulo de Domínio/Negócio (Use Cases e Entities) e exige que os testes unitários sigam o princípio AAA (*Arrange, Act, Assert*).

## Why it matters

Garante a **confiabilidade** e facilita a refatoração. Código sem testes unitários de alta qualidade é frágil e viola o OCP (Princípio Aberto/Fechado).

## Objective Criteria

- [ ] A cobertura de testes por linha (Line Coverage) deve ser de, no mínimo, **85%** para todos os módulos de domínio/negócio.
- [ ] É proibido usar lógica de controle (ex: `if`, `for`, `while`) diretamente dentro do corpo de um teste unitário.
- [ ] Cada teste unitário deve focar em uma única assertiva (máximo 2) e seguir a estrutura AAA (Preparação, Ação, Verificação).

## Allowed Exceptions

- **Módulos de Inicialização**: Arquivos de configuração e *root composers* (que não contêm lógica de negócio) podem ter cobertura baixa ou zero.

## How to Detect

### Manual

Busca por `if` ou `for` dentro de blocos `test()` ou `it()`.

### Automatic

Bun Test Runner/Jest: Configuração de `coverageThresholds`.

## Related to

- [011 - Open/Closed Principle (OCP)](011_open-closed-principle.md): reinforces
- [010 - Single Responsibility Principle (SRP)](010_single-responsibility-principle.md): reinforces
- [014 - Dependency Inversion Principle (DIP)](014_dependency-inversion-principle.md): complements
- [049 - Dev/Prod Parity](049_dev-prod-parity.md): complements

---

**Created on**: 2025-10-08
**Version**: 1.0
