# Princípio de Abstrações Estáveis (SAP)

**ID**: STRUCTURAL-020
**Severity**: 🔴 Critical
**Category**: Structural

---

## What it is

Um pacote deve ser o mais abstrato possível (possuir interfaces) se for estável, e o mais concreto possível se for instável.

## Why it matters

O SAP liga a estabilidade do pacote (SDP) à sua abstração (DIP). A violação ocorre quando um módulo altamente estável (difícil de mudar) é concreto, impedindo a extensão. Ou quando um módulo instável (fácil de mudar) é abstrato, atrasando a implementação.

## Objective Criteria

- [ ] A **Abstração** do pacote (A), calculada como (Total de Abstrações / Total de Classes), deve ser **alta** (próxima de 1) se a sua **Instabilidade (I)** for baixa (próxima de 0).
- [ ] A distância do pacote à *Main Sequence* (D) no plano A/I não deve ser maior que **0.1** (D = |A + I - 1|).
- [ ] Pacotes de alto nível (política) devem ter mais de **60%** de classes abstratas ou interfaces.

## Allowed Exceptions

- **Pacotes de Dados Puros**: Módulos que contêm apenas *Value Objects* ou DTOs e não são projetados para polimorfismo (A e I podem ser baixos).

## How to Detect

### Manual

Identificar um módulo de negócio importante (estável) que é composto apenas por classes concretas.

### Automatic

Análise de dependências: Cálculo de métricas de abstração (A), instabilidade (I) e distância (D) do pacote.

## Related to

- [014 - Dependency Inversion Principle (DIP)](014_dependency-inversion-principle.md): reinforces
- [019 - Stable Dependencies Principle (SDP)](019_stable-dependencies-principle.md): complements
- [012 - Liskov Substitution Principle (LSP)](012_liskov-substitution-principle.md): reinforces
- [011 - Open/Closed Principle (OCP)](011_open-closed-principle.md): reinforces

---

**Created on**: 2025-10-04
**Version**: 1.0
