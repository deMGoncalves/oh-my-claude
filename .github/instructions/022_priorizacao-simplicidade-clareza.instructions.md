---
applyTo: "**"
---

# Priorização da Simplicidade e Clareza (Princípio KISS)

**ID**: STRUCTURAL-022
**Severity**: 🟠 High
**Category**: Structural

---

## What it is

Impõe que o design e o código devem ser mantidos o mais simples e direto possível, evitando soluções excessivamente inteligentes ou complexas quando uma alternativa clara existe.

## Why it matters

A complexidade desnecessária é um débito que afeta a legibilidade e a manutenibilidade. Soluções simples são mais fáceis de entender, testar, depurar e escalar, reduzindo a tendência a erros e o custo cognitivo.

## Objective Criteria

- [ ] O **Índice de Complexidade Ciclomática (CC)** de qualquer método não deve exceder **5**.
- [ ] Funções e métodos devem realizar apenas uma única tarefa.
- [ ] É proibido o uso de metaprogramação ou recursos avançados da linguagem se o mesmo resultado puder ser alcançado com código direto.

## Allowed Exceptions

- **Bibliotecas de Infraestrutura**: Componentes de baixo nível (ex: *parser*, *serializer*) onde a complexidade é inerente à tarefa, mas isolada.

## How to Detect

### Manual

Verificar se o código exige mais de 5 segundos de análise para entender seu propósito e fluxo de controle.

### Automatic

SonarQube/ESLint: `complexity.max-cycles: 5`.

## Related to

- [001 - Single-Level Indentation Rule](001_single-indentation-level.md): reinforces
- [010 - Single Responsibility Principle (SRP)](010_single-responsibility-principle.md): reinforces
- [005 - Method Chaining Restriction](005_one-call-per-line.md): complements
- [006 - Prohibition of Abbreviated Names](006_prohibition-abbreviated-names.md): complements
- [007 - Maximum Lines per Class File](007_max-lines-per-class.md): complements
- [021 - Prohibition of Logic Duplication (DRY)](021_prohibition-logic-duplication.md): complements
- [026 - Comment Quality: Why, Not What](026_comment-quality-why-not-what.md): complements
- [062 - Prohibition of Clever Code](062_prohibition-clever-code.md): reinforces
- [064 - Prohibition of Overengineering](064_prohibition-overengineering.md): reinforces
- [068 - Prohibition of Golden Hammer](068_prohibition-golden-hammer.md): reinforces
- [069 - Prohibition of Premature Optimization](069_prohibition-premature-optimization.md): reinforces

---

**Created on**: 2025-10-08
**Version**: 1.0
