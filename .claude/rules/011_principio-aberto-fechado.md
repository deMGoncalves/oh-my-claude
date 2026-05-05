# Conformidade com o Princípio Aberto/Fechado (OCP)

**ID**: BEHAVIORAL-011
**Severity**: 🟠 High
**Category**: Behavioral

---

## What it is

Módulos, classes ou funções devem ser abertos para extensão e fechados para modificação, permitindo a adição de novos comportamentos sem alterar o código existente da unidade.

## Why it matters

A violação do OCP leva a código frágil. A conformidade reduz o risco de regressão e aumenta a manutenibilidade, pois novas funcionalidades são adicionadas sem a necessidade de reescrever lógica já testada.

## Objective Criteria

- [ ] A adição de um novo "tipo" de comportamento deve ser implementada por herança ou composição, e **não** por novos `if/switch` no código existente.
- [ ] Métodos com mais de **3** cláusulas `if/else if/switch case` que lidam com *tipos* (ex: `if (type === 'A')`) violam o OCP.
- [ ] Módulos de alto nível não devem ter dependência direta de mais de **2** classes concretas que implementam uma mesma abstração.

## Allowed Exceptions

- **Classes de Orquestração**: Módulos que atuam como *Factory* para instanciar tipos, onde a lógica `switch` é centralizada.

## How to Detect

### Manual

Sempre que for necessário adicionar uma nova funcionalidade, verificar se foi preciso modificar a classe base (se sim, OCP violado).

### Automatic

ESLint: Regras que detectam alto número de *switch/if-else* em um método.

## Related to

- [002 - Prohibition of ELSE Clause](002_prohibition-else-clause.md): reinforces
- [012 - Liskov Substitution Principle (LSP)](012_liskov-substitution-principle.md): depends on
- [013 - Interface Segregation Principle (ISP)](013_principio-segregacao-interface.md): complements
- [010 - Single Responsibility Principle (SRP)](010_single-responsibility-principle.md): complements
- [014 - Dependency Inversion Principle (DIP)](014_dependency-inversion-principle.md): reinforces
- [020 - Stable Abstractions Principle (SAP)](020_separacao-command-query-cqrs.md): reinforces
- [043 - Backing Services as Resources](043_backing-services-as-resources.md): complements

---

**Created on**: 2025-10-04
**Version**: 1.0
