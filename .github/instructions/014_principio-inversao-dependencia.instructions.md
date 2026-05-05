---
applyTo: "**"
---

# Aplicação do Princípio de Inversão de Dependência (DIP)

**ID**: BEHAVIORAL-014
**Severity**: 🔴 Critical
**Category**: Behavioral

---

## What it is

Módulos de alto nível não devem depender de módulos de baixo nível. Ambos devem depender de abstrações (interfaces).

## Why it matters

O DIP é crucial para desacoplar a política de negócio da implementação. A violação cria acoplamento rígido, dificultando testes (unidade e integração) e impedindo que o módulo de alto nível seja reutilizado em um novo contexto.

## Objective Criteria

- [ ] A criação de novas instâncias de classes concretas (*new Class()*) é proibida dentro de classes de alto nível (ex: *Services* e *Controllers*).
- [ ] Módulos de alto nível devem referenciar apenas interfaces ou classes abstratas (o que será injetado).
- [ ] O número de *imports* para classes concretas em construtores deve ser zero (apenas injeção de abstrações).

## Allowed Exceptions

- **Entidades e Value Objects**: Classes de dados puras que podem ser instanciadas livremente.
- **Root Composer**: O módulo de inicialização do sistema onde a injeção de dependência é configurada.

## How to Detect

### Manual

Busca por `new NomeConcreto()` dentro do código de *Services* ou *Business Logic*.

### Automatic

ESLint: `no-new-without-abstraction` (com regras customizadas).

## Related to

- [011 - Open/Closed Principle (OCP)](011_open-closed-principle.md): reinforces
- [015 - Release-Reuse Equivalence Principle (REP)](015_release-reuse-equivalence-principle.md): reinforces
- [003 - Primitive Domain Encapsulation](003_primitive-encapsulation.md): complements
- [018 - Acyclic Dependencies Principle (ADP)](018_acyclic-dependencies-principle.md): reinforces
- [019 - Stable Dependencies Principle (SDP)](019_stable-dependencies-principle.md): reinforces
- [020 - Stable Abstractions Principle (SAP)](020_stable-abstractions-principle.md): reinforces
- [032 - Minimum Test Coverage Quality](032_minimum-test-coverage-quality.md): complements
- [041 - Explicit Dependency Declaration](041_explicit-dependency-declaration.md): complements
- [043 - Backing Services as Resources](043_backing-services-as-resources.md): complements

---

**Created on**: 2025-10-04
**Updated on**: 2025-10-04
**Version**: 1.1
