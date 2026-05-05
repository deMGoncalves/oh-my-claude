---
applyTo: "**"
---

# Proibição de Argumentos Sinalizadores (Flag Arguments)

**ID**: BEHAVIORAL-037
**Severity**: 🟠 High
**Category**: Behavioral

---

## What it is

Proíbe o uso de parâmetros booleanos (*boolean flags*) em assinaturas de funções ou métodos, pois eles são um forte indicador de que a função possui mais de uma responsabilidade.

## Why it matters

Argumentos sinalizadores (ex: `process(data, shouldLog: boolean)`) violam o Princípio da Responsabilidade Única (SRP) e o Princípio Aberto/Fechado (OCP), pois a função se ramifica internamente, tornando-a difícil de testar e manter.

## Objective Criteria

- [ ] Funções não devem ter argumentos booleanos que alteram o caminho de execução principal (ex: `if (flag) { ... } else { ... }`).
- [ ] Funções com *boolean flags* devem ser divididas em métodos separados, com nomes que expressem a intenção de cada ramificação (ex: `processAndLog(data)` e `process(data)`).
- [ ] Limite de **zero** *boolean flags* nos métodos públicos de classes de domínio (`Services`, `Entities`).

## Allowed Exceptions

- **Módulos de Controle de Sistema**: Funções de baixo nível que controlam *debugging* ou *mode* (ex: `isVerbose`).
- **Frameworks/Libraries**: Funções que implementam uma assinatura exigida por um framework de terceiros.

## How to Detect

### Manual

Busca por parâmetros de função tipados como `boolean` ou com nomes como `isX`, `shouldY`, `withZ`.

### Automatic

ESLint: `no-flag-args` (regra customizada) ou `max-params`.

## Related to

- [010 - Single Responsibility Principle (SRP)](010_single-responsibility-principle.md): reinforces
- [011 - Open/Closed Principle (OCP)](011_open-closed-principle.md): reinforces
- [033 - Maximum Function Parameters](033_max-function-parameters.md): reinforces
- [013 - Interface Segregation Principle (ISP)](013_interface-segregation-principle.md): reinforces

---

**Created on**: 2025-10-08
**Version**: 1.0
