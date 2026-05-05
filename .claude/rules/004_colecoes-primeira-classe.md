# Uso Obrigatório de Coleções de Primeira Classe

**ID**: STRUCTURAL-004
**Severity**: 🟠 High
**Category**: Structural

---

## What it is

Determina que qualquer coleção (lista, array, mapa) com lógica de negócio ou comportamento associado deve ser encapsulada em uma classe dedicada (*First Class Collection*).

## Why it matters

As coleções nativas violam o SRP se tiverem lógica de manipulação distribuída. Encapsular a coleção centraliza a responsabilidade, facilita a adição de comportamentos (ex: filtros, somas) e previne que o estado interno seja exposto e modificado por clientes.

## Objective Criteria

- [ ] Tipos nativos de coleção (Array, List, Map) não devem ser passados como parâmetros ou retornados por métodos públicos, exceto para DTOs puros.
- [ ] Cada coleção com significado de domínio deve ser envolvida por uma classe dedicada (ex: `ListaDePedidos`, `Funcionarios`).
- [ ] A classe de coleção deve fornecer métodos de comportamento (ex: `adicionar()`, `filtrarPorStatus()`), e não apenas acesso direto aos elementos.

## Allowed Exceptions

- **Interfaces de Baixo Nível**: Coleções usadas puramente como estruturas de dados internas sem lógica de negócio associada (ex: `tokens` em um *scanner*).
- **APIs de Framework**: Uso de coleções em interfaces de Frameworks (ex: React, ORMs) que as exigem.

## How to Detect

### Manual

Verificar o uso de `Array.prototype` (map, filter, reduce) em métodos de classes que não sejam *First Class Collections*.

### Automatic

ESLint: Regras personalizadas para proibir o retorno de `Array` em classes de domínio.

## Related to

- [007 - Maximum Lines per Class File](007_max-lines-per-class.md): reinforces
- [008 - Prohibition of Getters/Setters](008_prohibition-getters-setters.md): reinforces
- [010 - Single Responsibility Principle (SRP)](010_single-responsibility-principle.md): reinforces
- [009 - Tell, Don't Ask](009_tell-dont-ask.md): complements
- [003 - Primitive Domain Encapsulation](003_primitive-encapsulation.md): complements

---

**Created on**: 2025-10-04
**Version**: 1.0
