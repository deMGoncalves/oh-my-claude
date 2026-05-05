# Restrição de Nível Único de Indentação por Método

**ID**: STRUCTURAL-001
**Severity**: 🟠 High
**Category**: Structural

---

## What it is

Limita a complexidade de um método ou função ao impor um único nível de indentação para blocos de código (condicionais, *loops* ou *try-catch*), forçando a extração de lógica em métodos separados.

## Why it matters

Reduz a Complexidade Ciclomática (CC), melhorando drasticamente a legibilidade e a manutenibilidade do método, e facilitando a escrita de testes unitários focados em uma única responsabilidade.

## Objective Criteria

- [ ] Métodos e funções devem conter, no máximo, um único nível de indentação de bloco de código (após o escopo inicial do método).
- [ ] O uso de *guard clauses* para retornos antecipados não conta como um novo nível de indentação.
- [ ] Funções anônimas passadas como *callbacks* não devem introduzir um segundo nível de indentação no método pai.

## Allowed Exceptions

- **Estruturas de Controle Específicas**: *Try/Catch/Finally* em escopo de tratamento de erro que não possa ser delegado.

## How to Detect

### Manual

Verificar a existência de um bloco de código aninhado (ex: um `if` dentro de um `for`, ou um `for` dentro de um `if`).

### Automatic

SonarQube/ESLint: `complexity.max-depth: 1`

## Related to

- [002 - Prohibition of ELSE Clause](002_prohibition-else-clause.md): reinforces
- [007 - Maximum Lines per Class File](007_max-lines-per-class.md): complements
- [022 - Simplicity and Clarity (KISS)](022_simplicity-and-clarity.md): reinforces
- [010 - Single Responsibility Principle (SRP)](010_single-responsibility-principle.md): complements
- [011 - Open/Closed Principle (OCP)](011_open-closed-principle.md): reinforces

---

**Created on**: 2025-10-04
**Version**: 1.0
