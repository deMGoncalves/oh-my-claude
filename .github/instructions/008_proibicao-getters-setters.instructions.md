---
applyTo: "**"
---

# Proibição de Exposição Direta de Estado (Getters/Setters)

**ID**: BEHAVIORAL-008
**Severity**: 🔴 Critical
**Category**: Behavioral

---

## What it is

Proíbe a criação de métodos puramente para acesso ou modificação direta do estado interno do objeto (como `getPropriedade()` e `setPropriedade()`), reforçando o encapsulamento e o princípio "Diga, Não Pergunte".

## Why it matters

A exposição direta do estado interno viola o encapsulamento, forçando o código cliente a decidir a lógica de negócio (*procedural programming*), resultando em classes anêmicas e acoplamento a detalhes de implementação.

## Objective Criteria

- [ ] Métodos que retornam o valor exato de uma propriedade interna sem transformações ou lógica são proibidos (puros *getters*).
- [ ] Métodos que apenas atribuem um valor a uma propriedade interna são proibidos (puros *setters*).
- [ ] A interação com o objeto deve ocorrer por métodos que expressam *intenção* de negócio (ex: `agendarReuniao()` em vez de `setStatus(Agendado)`).

## Allowed Exceptions

- **Objetos de Transferência de Dados (DTOs)**: Classes puras usadas apenas para transferência de dados entre camadas, sem lógica de negócio.
- **Frameworks de Serialização**: Bibliotecas que exigem *getters* e *setters* para mapeamento.

## How to Detect

### Manual

Busca por métodos que contenham prefixos `get` ou `set` seguidos por um nome de propriedade, ou métodos que não possuam lógica de negócio própria.

### Automatic

ESLint: Regras customizadas para identificar padrões de métodos `get/set` vazios ou triviais.

## Related to

- [009 - Tell, Don't Ask](009_tell-dont-ask.md): reinforces
- [003 - Primitive Domain Encapsulation](003_primitive-encapsulation.md): complements
- [002 - Prohibition of ELSE Clause](002_prohibition-else-clause.md): reinforces
- [004 - First-Class Collections](004_first-class-collections.md): reinforces
- [005 - Method Chaining Restriction](005_one-call-per-line.md): reinforces
- [029 - Object Immutability (freeze)](029_object-immutability-freeze.md): reinforces
- [036 - Side-Effect Function Restrictions](036_side-effect-restrictions.md): complements

---

**Created on**: 2025-10-04
**Version**: 1.0
