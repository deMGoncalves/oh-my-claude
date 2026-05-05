# Encapsulamento de Primitivos de Domínio (Value Objects)

**ID**: CREATIONAL-003
**Severity**: 🔴 Critical
**Category**: Creational

---

## What it is

Exige que tipos primitivos (como `number`, `boolean`) e a classe `String` que representam conceitos de domínio (ex: *Email*, *CPF*, *Moeda*) sejam encapsulados em seus próprios *Value Objects* imutáveis.

*(Previne o anti-pattern Primitive Obsession: uso de `string`, `number`, `boolean` para representar conceitos de domínio que deveriam ser objetos com comportamento próprio.)*

## Why it matters

Garante que a validação, formatação e as regras de negócio intrínsecas ao dado sejam definidas e verificadas uma única vez no construtor, evitando inconsistências e bugs graves por passagem de dados inválidos entre métodos.

## Objective Criteria

- [ ] Parâmetros de entrada e valores de retorno de métodos públicos não devem ser tipos primitivos/String se representarem um conceito de domínio específico.
- [ ] Todos os *Value Objects* devem ser imutáveis.
- [ ] A lógica de validação do formato e regras de negócio do valor deve estar contida e ser executada no construtor do *Value Object*.

## Allowed Exceptions

- **Primitivos Genéricos**: Tipos primitivos usados para contagem (`i`, `index`), booleanos de controle (`isValid`), ou números sem significado de domínio (ex: delta temporal).

## How to Detect

### Manual

Identificar String ou Number sendo passado como argumento em múltiplos métodos, representando, por exemplo, um *ID* ou *Path*.

### Automatic

TypeScript: Detectar o uso excessivo de `string` ou `number` para campos tipados que deveriam ser classes dedicadas.

## Related to

- [008 - Prohibition of Getters/Setters](008_prohibition-getters-setters.md): reinforces
- [009 - Tell, Don't Ask](009_tell-dont-ask.md): reinforces
- [024 - Prohibition of Magic Constants](024_prohibition-magic-constants.md): reinforces
- [006 - Prohibition of Abbreviated Names](006_prohibition-abbreviated-names.md): reinforces
- [033 - Maximum Function Parameters](033_max-function-parameters.md): reinforces
- [029 - Object Immutability (freeze)](029_object-immutability-freeze.md): reinforces
- [012 - Liskov Substitution Principle (LSP)](012_liskov-substitution-principle.md): complements
- [014 - Dependency Inversion Principle (DIP)](014_dependency-inversion-principle.md): complements
- [035 - Prohibition of Misleading Names](035_prohibition-misleading-names.md): reinforces
- [053 - Prohibition of Data Clumps](053_prohibition-data-clumps.md): complements

---

**Created on**: 2025-10-04
**Version**: 1.0
