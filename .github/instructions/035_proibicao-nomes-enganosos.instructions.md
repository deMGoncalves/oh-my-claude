---
applyTo: "**"
---

# Proibição de Nomes Enganosos (Desinformação e Encoding)

**ID**: STRUCTURAL-035
**Severity**: 🔴 Critical
**Category**: Structural

---

## What it is

Proíbe o uso de nomes que impliquem falsas pistas ou sugiram um comportamento que o código não possui (ex: chamar um `Set` de `accountList`) e proíbe a codificação de tipos nos nomes (ex: `strName` ou `fValue`).

## Why it matters

Nomes enganosos são uma forma de **desinformação** que quebra a confiança do desenvolvedor no código. O *encoding* de tipo (notação húngara) é redundante e polui o código, aumentando o risco de bugs de tempo de execução quando o tipo é alterado.

## Objective Criteria

- [ ] Variáveis que contêm coleções (`Array`, `Set`, `Map`) devem ser nomeadas conforme a estrutura de dados real.
- [ ] É proibido o uso de prefixos de tipo desnecessários em nomes (ex: `str`, `int`, `f`).
- [ ] Nomes de variáveis não devem contradizer o tipo de dado que armazenam.

## Allowed Exceptions

- **Interfaces Legadas**: Variáveis onde a notação húngara é exigida para interoperabilidade com código legado ou *frameworks* de baixo nível.

## How to Detect

### Manual

Verificar se o nome de uma variável contradiz seu uso ou o tipo real de dado que contém.

### Automatic

ESLint: Regras personalizadas contra notação húngara e para verificar padrões de lista.

## Related to

- [006 - Prohibition of Abbreviated Names](006_prohibition-abbreviated-names.md): complements
- [003 - Primitive Domain Encapsulation](003_primitive-encapsulation.md): reinforces
- [034 - Consistent Class and Method Names](034_consistent-class-method-names.md): complements

---

**Created on**: 2025-10-08
**Version**: 1.0
