# Proibição de Constantes Mágicas (Magic Strings e Numbers)

**ID**: CREATIONAL-024
**Severity**: 🔴 Critical
**Category**: Creational

---

## What it is

Proíbe o uso direto de valores literais (números ou strings) que possuam um significado contextual ou de negócio (ex: códigos de status, limites de tempo) em vez de constantes nomeadas ou *Value Objects*.

## Why it matters

Constantes mágicas degradam a legibilidade. Uma alteração de valor em vários locais introduz erros graves e dificulta a manutenção, pois o contexto do valor é perdido.

## Objective Criteria

- [ ] Valores numéricos (exceto 0 e 1) usados em lógica de negócio ou condições devem ser substituídos por constantes `UPPER_SNAKE_CASE`.
- [ ] Strings usadas para representar estados, tipos, URLs base ou *tokens* devem ser substituídas por `Enums` ou constantes.
- [ ] Constantes devem ser definidas em um módulo centralizado e importadas, não duplicadas.

## Allowed Exceptions

- **Matemática Pura**: Valores numéricos usados em operações matemáticas básicas (ex: `total / 2`).
- **Frameworks/Infraestrutura**: Strings exigidas por APIs de baixo nível.

## How to Detect

### Manual

Busca por `string` ou `number` literal dentro de `if`, `switch` ou cálculos de negócio.

### Automatic

SonarQube/ESLint: `no-magic-numbers`, `no-magic-strings`.

## Related to

- [003 - Primitive Domain Encapsulation](003_primitive-encapsulation.md): reinforces
- [006 - Prohibition of Abbreviated Names](006_prohibition-abbreviated-names.md): complements
- [030 - Prohibition of Unsafe Functions](030_prohibition-unsafe-functions.md): complements
- [042 - Environment-Based Configuration](042_environment-based-configuration.md): complements

---

**Created on**: 2025-10-08
**Version**: 1.0
