---
applyTo: "**"
---

# Aplicação do Princípio do "Diga, Não Pergunte" (Law of Demeter)

**ID**: BEHAVIORAL-009
**Severity**: 🔴 Critical
**Category**: Behavioral

---

## What it is

Exige que um método chame métodos ou acesse propriedades apenas de seus "vizinhos imediatos": o próprio objeto, objetos passados como argumento, objetos que ele cria ou objetos que são propriedades internas diretas.

*(Previne o anti-pattern Message Chains / Train Wreck: ao dizer ao objeto o que fazer em vez de navegar sua estrutura interna via getters encadeados.)*

## Why it matters

Violações do Princípio de Demeter resultam em acoplamento alto e transitivo (*train wrecks*), tornando o código frágil a mudanças internas em objetos distantes na cadeia de dependência, e obscurecendo a responsabilidade de cada objeto.

## Objective Criteria

- [ ] Um método deve evitar chamar métodos de um objeto retornado por outro método (ex: `a.getB().getC().f()`).
- [ ] A chamada de métodos deve ser restrita aos objetos que o método tem conhecimento direto.
- [ ] O objeto cliente deve *dizer* ao objeto dependente o que fazer, em vez de *perguntar* pelo estado interno para tomar uma decisão.

## Allowed Exceptions

- **Padrões de Interface Fluida (Chaining)**: Desde que o método retorne `this` (ou a mesma interface), como em Builders.
- **Acesso a DTOs/Value Objects**: Acesso a dados de objetos que são puramente recipientes de dados.

## How to Detect

### Manual

Busca por encadeamento de chamadas (*dot-chaining*) com três ou mais chamadas consecutivas, indicando conhecimento de objetos aninhados.

### Automatic

ESLint: `no-chaining` com alta profundidade e `no-access-target` (com plugins customizados).

## Related to

- [008 - Prohibition of Getters/Setters](008_prohibition-getters-setters.md): reinforces
- [005 - Method Chaining Restriction](005_one-call-per-line.md): reinforces
- [012 - Liskov Substitution Principle (LSP)](012_liskov-substitution-principle.md): reinforces
- [003 - Primitive Domain Encapsulation](003_primitive-encapsulation.md): reinforces
- [004 - First-Class Collections](004_first-class-collections.md): complements
- [018 - Acyclic Dependencies Principle (ADP)](018_acyclic-dependencies-principle.md): reinforces
- [036 - Side-Effect Function Restrictions](036_side-effect-restrictions.md): reinforces
- [038 - Princípio de Separação de Comando-Consulta](038_command-query-separation.md): reinforces
- [057 - Prohibition of Feature Envy](057_prohibition-feature-envy.md): complements

---

**Created on**: 2025-10-04
**Version**: 1.0
