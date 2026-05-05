---
applyTo: "**"
---

# Conformidade com o Princípio de Inversão de Consulta (CQS)

**ID**: BEHAVIORAL-038
**Severity**: 🟠 High
**Category**: Behavioral

---

## What it is

Exige que um método seja ou uma **Consulta (Query)** que retorna dados sem alteração de estado, ou um **Comando (Command)** que altera o estado mas não retorna dados (exceto DTOs/Entidades).

## Why it matters

A violação do CQS introduz **efeitos colaterais inesperados** e dificulta o raciocínio sobre o código, pois o cliente assume que um método de "consulta" é seguro, mas ele silenciosamente altera o estado do sistema. Isso leva a bugs de concorrência e de estado.

## Objective Criteria

- [ ] Métodos que alteram o estado (Comandos) devem ter o tipo de retorno `void` ou um tipo de entidade (ex: `User`, `Order`), mas **não** um `boolean` ou código de sucesso.
- [ ] Métodos que retornam um valor (Consultas) não devem ter efeitos colaterais perceptíveis (ex: modificação de variáveis de instância, chamadas a métodos de escrita).
- [ ] O número de métodos que são híbridos (fazem Query e Command) deve ser zero.

## Allowed Exceptions

- **Caches**: Métodos de leitura que têm o efeito colateral de atualizar um cache interno (*cache-aside*) são aceitos, desde que este efeito seja uma otimização e não lógica de negócio.

## How to Detect

### Manual

Busca por métodos que retornam um valor, mas que contêm lógica de persistência (`save()`) ou modificação de estado.

### Automatic

ESLint: Regras customizadas que verificam o padrão de nomes de métodos de leitura/escrita e seus retornos.

## Related to

- [036 - Side-Effect Function Restrictions](036_side-effect-restrictions.md): reinforces
- [010 - Single Responsibility Principle (SRP)](010_single-responsibility-principle.md): reinforces
- [009 - Tell, Don't Ask](009_tell-dont-ask.md): reinforces
- [011 - Open/Closed Principle (OCP)](011_open-closed-principle.md): reinforces

---

**Created on**: 2025-10-08
**Version**: 1.0
