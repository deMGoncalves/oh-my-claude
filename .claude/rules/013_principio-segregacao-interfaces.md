# Aplicação do Princípio de Segregação de Interfaces (ISP)

**ID**: STRUCTURAL-013
**Severity**: 🟠 High
**Category**: Structural

---

## What it is

Exige que clientes não sejam forçados a depender de interfaces que não utilizam. Múltiplas interfaces específicas para clientes são preferíveis a uma única interface geral.

## Why it matters

Violações do ISP causam classes anêmicas (com métodos vazios ou lançando exceções) e aumentam o acoplamento desnecessário, pois clientes são forçados a depender de código que nunca será executado.

## Objective Criteria

- [ ] Interfaces devem ter, no máximo, **5** métodos públicos.
- [ ] Classes que implementam interfaces não devem deixar métodos vazios ou lançar exceções de "não suportado".
- [ ] Se uma interface é utilizada por mais de **3** clientes diferentes, ela deve ser revisada para segregação.

## Allowed Exceptions

- **Interfaces de Baixo Nível**: Interfaces de *Frameworks* de terceiros que exigem um alto número de métodos (ex: `HttpRequestHandler`).

## How to Detect

### Manual

Busca por interfaces com 8 ou mais métodos, ou classes implementadoras que deixam métodos sem funcionalidade.

### Automatic

SonarQube: Alta complexidade acoplada devido a métodos não utilizados.

## Related to

- [010 - Single Responsibility Principle (SRP)](010_single-responsibility-principle.md): reinforces
- [011 - Open/Closed Principle (OCP)](011_open-closed-principle.md): complements
- [012 - Liskov Substitution Principle (LSP)](012_liskov-substitution-principle.md): reinforces
- [017 - Common Reuse Principle (CRP)](017_common-reuse-principle.md): complements
- [037 - Prohibition of Flag Arguments](037_prohibition-flag-arguments.md): reinforces

---

**Created on**: 2025-10-04
**Version**: 1.0
