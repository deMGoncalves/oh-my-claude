# Conformidade com o Princípio de Substituição de Liskov (LSP)

**ID**: BEHAVIORAL-012
**Severity**: 🔴 Critical
**Category**: Behavioral

---

## What it is

Exige que as classes derivadas (subclasses) sejam substituíveis pelas suas classes base (superclasses) sem alterar o comportamento esperado do programa.

## Why it matters

A violação do LSP quebra a coesão do sistema de tipos e o contrato de herança, forçando os clientes a verificar o tipo do objeto, o que leva à violação do OCP e introduz bugs graves em tempo de execução.

## Objective Criteria

- [ ] Subclasses não devem lançar exceções que não são lançadas pela classe base (comportamento).
- [ ] Subclasses não devem enfraquecer pré-condições ou fortalecer pós-condições da classe base (assinatura/contrato).
- [ ] É proibido o uso de verificações de tipo (`instanceof` ou *type guards* complexos) em código cliente que utiliza a interface da classe base.

## Allowed Exceptions

- **Frameworks de Teste**: Uso de *mocks* e *spies* em testes unitários para simular comportamentos de substituição de forma controlada.

## How to Detect

### Manual

Busca por `if (objeto instanceof Subclasse)` ou uso de um método da classe base que lança `UnsupportedOperationException`.

### Automatic

TypeScript/Compilador: Verificação de tipagem rígida de parâmetros e retornos de métodos sobrescritos.

## Related to

- [011 - Open/Closed Principle (OCP)](011_open-closed-principle.md): reinforces
- [009 - Tell, Don't Ask](009_tell-dont-ask.md): reinforces
- [003 - Primitive Domain Encapsulation](003_primitive-encapsulation.md): complements
- [013 - Interface Segregation Principle (ISP)](013_principio-segregacao-interface.md): reinforces
- [036 - Side-Effect Function Restrictions](036_side-effect-restrictions.md): reinforces

---

**Created on**: 2025-10-04
**Version**: 1.0
