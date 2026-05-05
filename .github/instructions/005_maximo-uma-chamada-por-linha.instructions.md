---
applyTo: "**"
---

# Restrição de Encadeamento de Chamadas (*Method Chaining*)

**ID**: STRUCTURAL-005
**Severity**: 🟡 Medium
**Category**: Structural

---

## What it is

Limita o encadeamento de chamadas de métodos e o acesso a propriedades encadeadas (*train wrecks*), permitindo no máximo uma chamada de método ou acesso a propriedade por linha.

*(Previne o anti-pattern Message Chains / Train Wreck: sequências `a.getB().getC().getD()` que acoplam o cliente à estrutura interna de toda a cadeia de objetos.)*

## Why it matters

O encadeamento excessivo (ex: `a.b().c().d()`) viola o Princípio de Demeter (Lei do Conhecimento Mínimo), aumentando o acoplamento do cliente a detalhes internos da estrutura de objetos. A restrição melhora a legibilidade ao forçar a quebra de linha ou o uso de variáveis temporárias.

## Objective Criteria

- [ ] Cada instrução deve conter, no máximo, uma chamada de método ou um acesso a propriedade (ex: `a.b()`).
- [ ] Múltiplas chamadas na mesma linha (ex: `objeto.getA().getB()`) são proibidas.
- [ ] Múltiplas chamadas devem ser quebradas em linhas separadas ou delegadas a um novo método.

## Allowed Exceptions

- **Fluent Interfaces/Builders**: Padrões de projeto (*Builder* ou *Chaining*) que retornam `this` para configurar um objeto (ex: `new Query().where().limit()`).
- **Constantes Estáticas**: Acessos a constantes estáticas de classes de utilidade.

## How to Detect

### Manual

Busca por dois ou mais pontos (`.`) consecutivos (excluindo ponto flutuante) em uma única linha de instrução.

### Automatic

ESLint: `no-chaining` (com plugins customizados).

## Related to

- [009 - Tell, Don't Ask](009_tell-dont-ask.md): reinforces
- [006 - Prohibition of Abbreviated Names](006_prohibition-abbreviated-names.md): complements
- [008 - Prohibition of Getters/Setters](008_prohibition-getters-setters.md): reinforces
- [022 - Simplicity and Clarity (KISS)](022_simplicity-and-clarity.md): complements

---

**Created on**: 2025-10-04
**Version**: 1.0
