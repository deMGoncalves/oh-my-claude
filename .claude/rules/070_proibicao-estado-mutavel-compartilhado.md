# Proibição de Estado Mutável Compartilhado

**ID**: AP-08-070
**Severity**: 🟠 High
**Category**: Behavioral

---

## What it is

Estado Mutável Compartilhado (Shared Mutable State) ocorre quando múltiplos módulos, funções ou contextos de execução leem e modificam o mesmo objeto sem coordenação. Qualquer parte do sistema pode alterar estado a qualquer momento, tornando o comportamento imprevisível. Distinto de Mutação Acidental (052): aqui o compartilhamento é estrutural, não acidental.

## Why it matters

- Bugs fantasma: a origem da mutação está em módulo diferente do ponto de falha
- Testes frágeis: resultado depende de estado global deixado por testes anteriores
- Rastreabilidade zero: impossível saber quem mudou estado sem breakpoints
- Concorrência impossível: qualquer paralelismo introduz race conditions

## Objective Criteria

- [ ] Objeto de domínio passado por referência e modificado em dois ou mais módulos distintos
- [ ] Variável de módulo ou global alterada por múltiplas funções sem coordenação explícita
- [ ] Testes que falham dependendo da ordem de execução (sinal de estado compartilhado)
- [ ] Array ou objeto usado como "buffer de comunicação" entre partes do sistema sem cópia
- [ ] Ausência de `Object.freeze()` em objetos passados para múltiplos consumidores

## Allowed Exceptions

- **Stores Explícitos**: Gerenciadores de estado (Redux, Zustand, MobX) onde padrão de mutação é centralizado, rastreado e intencional.
- **Objetos de Configuração Somente Leitura**: Configurações congeladas com `Object.freeze()` passadas como constantes de leitura.

## How to Detect

### Manual

Rastrear ciclo de vida de um objeto: se ele é passado para múltiplas funções e cada uma pode modificá-lo, é Estado Mutável Compartilhado.

### Automatic

ESLint: `no-param-reassign`, TypeScript: `Readonly<T>`, `as const`. Testes: executar em ordem aleatória detecta dependência de estado global.

## Related to

- [029 - Object Immutability (freeze)](029_object-immutability-freeze.md): reinforces
- [036 - Side-Effect Function Restrictions](036_side-effect-restrictions.md): reinforces
- [045 - Stateless Processes](045_stateless-processes.md): complements
- [052 - Prohibition of Accidental Mutation](052_prohibition-accidental-mutation.md): complements
- [069 - Prohibition of Premature Optimization](069_prohibition-premature-optimization.md): complements

---

**Created on**: 2026-03-29
**Version**: 1.0
