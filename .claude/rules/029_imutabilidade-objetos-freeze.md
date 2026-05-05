# Imutabilidade de Objetos de Domínio (Object.freeze)

**ID**: CREATIONAL-029
**Severity**: 🟠 High
**Category**: Creational

---

## What it is

Exige que todos os objetos criados para representar Entidades ou *Value Objects* do Domínio sejam **imutáveis**, aplicando explicitamente métodos de congelamento (`Object.freeze()`) antes de serem expostos.

## Why it matters

A mutabilidade acidental introduz bugs graves e dificulta o rastreamento da origem da mudança de estado, violando o princípio do **Encapsulamento**. O congelamento garante que o objeto não mude após sua criação.

## Objective Criteria

- [ ] Todas as instâncias de `Value Objects` ou `Entities` de domínio devem ser congeladas antes de sair do construtor ou da camada de persistência.
- [ ] É proibido aceitar objetos do domínio como parâmetro em métodos públicos e modificá-los sem clonar ou forçar um método de intenção.
- [ ] A imutabilidade deve ser aplicada de forma *shallow* (superficial) ou *deep* (profunda), dependendo do objeto.

## Allowed Exceptions

- **DTOs Puros**: Objetos de transferência de dados usados estritamente para comunicação externa ou mapeamento de dados.

## How to Detect

### Manual

Verificar a ausência de `Object.freeze()` em métodos *Factory* ou construtores de Entidades.

### Automatic

TypeScript: Uso de `readonly` em propriedades.

## Related to

- [003 - Primitive Domain Encapsulation](003_primitive-encapsulation.md): reinforces
- [008 - Prohibition of Getters/Setters](008_prohibition-getters-setters.md): reinforces
- [036 - Side-Effect Function Restrictions](036_side-effect-restrictions.md): reinforces
- [045 - Stateless Processes](045_stateless-processes.md): complements
- [070 - Prohibition of Shared Mutable State](070_prohibition-shared-mutable-state.md): reinforces

---

**Created on**: 2025-10-08
**Version**: 1.0
