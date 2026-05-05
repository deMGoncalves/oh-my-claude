---
applyTo: "**"
---

# Princípio de Dependências Estáveis (SDP)

**ID**: STRUCTURAL-019
**Severity**: 🟠 High
**Category**: Structural

---

## What it is

As dependências de um módulo devem apontar na direção da estabilidade. Módulos instáveis (que mudam muito) devem depender de módulos estáveis.

## Why it matters

Violações do SDP fazem com que módulos de alto nível (mais importantes para o negócio) dependam de módulos de baixo nível e voláteis, espalhando mudanças e reduzindo a testabilidade.

## Objective Criteria

- [ ] A **instabilidade** do pacote (I), calculada como (Dependências de Saída / Total de Dependências), deve ser **menor** que 0.5.
- [ ] Módulos de política de negócio (alto nível) devem ter a Instabilidade mais baixa (próxima de 0).
- [ ] Pacotes mais utilizados (alto grau de estabilidade) não devem depender de pacotes com baixo grau de estabilidade (alto I).

## Allowed Exceptions

- **Boundary Elements**: Elementos na fronteira do sistema (ex: *Adapters*, *Controllers*) que, por natureza, são voláteis.

## How to Detect

### Manual

Identificar a camada de alto nível (ex: *Domain*) importando classes concretas de camadas externas (ex: *Infrastructure*).

### Automatic

Análise de dependências: Cálculo de métricas de estabilidade (I) do pacote.

## Related to

- [014 - Dependency Inversion Principle (DIP)](014_dependency-inversion-principle.md): reinforces
- [018 - Acyclic Dependencies Principle (ADP)](018_acyclic-dependencies-principle.md): complements
- [020 - Stable Abstractions Principle (SAP)](020_stable-abstractions-principle.md): complements

---

**Created on**: 2025-10-04
**Version**: 1.0
