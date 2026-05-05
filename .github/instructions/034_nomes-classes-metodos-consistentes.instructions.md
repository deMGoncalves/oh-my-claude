---
applyTo: "**"
---

# Nomes de Classes e Métodos Consistentes (Funções são Verbos)

**ID**: STRUCTURAL-034
**Severity**: 🟠 High
**Category**: Structural

---

## What it is

Exige que nomes de classes sejam **substantivos singulares** (ex: `User`, `Order`) e que nomes de métodos sejam **verbos ou frases verbais** que descrevem a intenção (ex: `calculateFee`, `sendNotification`).

## Why it matters

A consistência na nomenclatura é fundamental para a **legibilidade** e **previsibilidade** do código. Uma violação quebra o modelo mental do leitor, aumentando o **custo cognitivo** e o risco de má interpretação da intenção e do sistema de tipos.

## Objective Criteria

- [ ] Nomes de classes e interfaces devem ser substantivos e usar `PascalCase`.
- [ ] Nomes de métodos públicos devem começar com um verbo (ex: `get`, `create`, `validate`) e usar `camelCase`.
- [ ] Variáveis que armazenam valores booleanos (predicados) devem usar prefixos claros (ex: `is`, `has`, `can`).

## Allowed Exceptions

- **Factories/Builders**: Classes com o sufixo `Factory` ou `Builder` são aceitas, pois seu papel é estritamente criacional.

## How to Detect

### Manual

Verificar classes que terminam em verbos (`Manager`, `Processor`) ou funções com nomes de substantivos (`User`).

### Automatic

ESLint: `naming-convention` com regras para classes e funções.

## Related to

- [006 - Prohibition of Abbreviated Names](006_prohibition-abbreviated-names.md): reinforces
- [010 - Single Responsibility Principle (SRP)](010_single-responsibility-principle.md): reinforces
- [035 - Prohibition of Misleading Names](035_prohibition-misleading-names.md): complements

---

**Created on**: 2025-10-08
**Version**: 1.0
