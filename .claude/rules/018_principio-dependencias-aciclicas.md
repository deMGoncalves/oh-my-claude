# Princípio de Dependências Acíclicas (ADP)

**ID**: STRUCTURAL-018
**Severity**: 🔴 Critical
**Category**: Structural

---

## What it is

O grafo de dependência entre pacotes deve ser acíclico, ou seja, não deve haver dependências circulares entre os módulos.

## Why it matters

Dependências circulares criam um nó rígido onde as classes em módulos envolvidos se tornam inseparáveis. Isso impede testes isolados, torna a implantação mais complexa e impossibilita o reuso de módulos individualmente.

## Objective Criteria

- [ ] É proibido que o Módulo A dependa do Módulo B, e o Módulo B dependa do Módulo A.
- [ ] Módulos circulares (com laços de dependência) devem ser imediatamente quebrados via DIP (extraindo interface comum).
- [ ] A análise do grafo de dependências deve resultar em um Grafo Direcionado Acíclico (DAG).

## Allowed Exceptions

- **Classes de Infraestrutura**: Dependências circulares entre classes *internas* a um mesmo pacote, desde que não envolvam a interface pública.

## How to Detect

### Manual

Busca por `import { B } from 'module-b'` em `module-a` e `import { A } from 'module-a'` em `module-b`.

### Automatic

Análise de dependências: `dependency-graph-analysis` (detecta ciclos).

## Related to

- [014 - Dependency Inversion Principle (DIP)](014_dependency-inversion-principle.md): reinforces
- [009 - Tell, Don't Ask](009_tell-dont-ask.md): reinforces
- [019 - Stable Dependencies Principle (SDP)](019_stable-dependencies-principle.md): complements
- [041 - Explicit Dependency Declaration](041_explicit-dependency-declaration.md): complements

---

**Created on**: 2025-10-04
**Version**: 1.0
