---
applyTo: "**"
---

# Proibição da Cláusula ELSE para Fluxo de Controle

**ID**: BEHAVIORAL-002
**Severity**: 🟠 High
**Category**: Behavioral

---

## What it is

Restringe o uso das cláusulas `else` e `else if`, promovendo a substituição por *guard clauses* (retorno antecipado) ou padrões de polimorfismo para lidar com diferentes caminhos de execução.

## Why it matters

Melhora a clareza do fluxo de controle, evita a Complexidade Ciclomática desnecessária e força a aderência ao Princípio da Responsabilidade Única (SRP), pois cada bloco de código lida com uma condição específica.

## Objective Criteria

- [ ] O uso explícito das palavras-chave `else` ou `else if` é proibido.
- [ ] Condicionais devem ser usados primariamente como *guard clauses* (verificação de pré-condições e retorno/lançamento de erro).
- [ ] Lógica de ramificação complexa deve ser resolvida via polimorfismo (padrões *Strategy* ou *State*).

## Allowed Exceptions

- **Estruturas de Controle de Linguagem**: Estruturas como `switch` (que geralmente se comportam como `if/else if`) podem ser usadas, desde que cada `case` retorne ou encerre a execução.

## How to Detect

### Manual

Busca por ` else ` ou ` else if ` no código.

### Automatic

ESLint: `no-else-return` e `no-lonely-if` com configurações para forçar a saída antecipada.

## Related to

- [001 - Single-Level Indentation Rule](001_single-indentation-level.md): reinforces
- [008 - Prohibition of Getters/Setters](008_prohibition-getters-setters.md): reinforces
- [011 - Open/Closed Principle (OCP)](011_open-closed-principle.md): reinforces
- [022 - Simplicity and Clarity (KISS)](022_simplicity-and-clarity.md): complements
- [027 - Domain Error Handling Quality](027_domain-error-handling-quality.md): complements

---

**Created on**: 2025-10-04
**Version**: 1.0
