# Restrição de Funções com Efeitos Colaterais (Side Effects)

**ID**: BEHAVIORAL-036
**Severity**: 🔴 Critical
**Category**: Behavioral

---

## What it is

Exige que as funções ou métodos, exceto aqueles explicitamente designados como **Comandos** (que alteram estado), sejam puras e **não alterem o estado** de variáveis de instância, objetos globais ou objetos externos passados por referência.

## Why it matters

Efeitos colaterais inesperados introduzem erros graves e dificultam o raciocínio sobre o código, quebrando a **previsibilidade** e o **Princípio da Surpresa Mínima**. O código impuro é difícil de testar e debugar.

## Objective Criteria

- [ ] Funções que são puramente **Consultas (Queries)** não devem modificar variáveis de instância da classe ou objetos globais/externos.
- [ ] Objetos mutáveis passados como parâmetro devem ser clonados antes de qualquer modificação, a menos que a modificação seja a intenção de negócio do método.
- [ ] Funções que alteram o estado devem ter nomes que começam com verbos de Comando (ex: `update`, `save`, `delete`).

## Allowed Exceptions

- **Comandos de Persistência**: Métodos de `Repository` ou `Service` que explicitamente alteram o estado do sistema (ex: `save`, `delete`).
- **Interfaces Fluidas/Builders**: Classes que retornam `this` para modificar o próprio objeto.

## How to Detect

### Manual

Busca por métodos que retornam um valor de consulta, mas também chamam um `setter` ou modificam um atributo interno/externo.

### Automatic

ESLint: `no-side-effects-in-conditions` e análise de *mutability*.

## Related to

- [009 - Tell, Don't Ask](009_tell-dont-ask.md): reinforces
- [027 - Domain Error Handling Quality](027_domain-error-handling-quality.md): reinforces
- [038 - Command-Query Separation (CQS)](038_command-query-separation.md): reinforces
- [008 - Prohibition of Getters/Setters](008_prohibition-getters-setters.md): complements
- [012 - Liskov Substitution Principle (LSP)](012_liskov-substitution-principle.md): reinforces
- [029 - Object Immutability (freeze)](029_object-immutability-freeze.md): reinforces
- [045 - Stateless Processes](045_stateless-processes.md): complements
- [052 - Prohibition of Accidental Mutation](052_prohibition-accidental-mutation.md): reinforces
- [070 - Prohibition of Shared Mutable State](070_prohibition-shared-mutable-state.md): reinforces

---

**Created on**: 2025-10-08
**Version**: 1.0
