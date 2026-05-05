# Qualidade no Tratamento de Erros: Use Exceções de Domínio

**ID**: BEHAVIORAL-027
**Severity**: 🟠 High
**Category**: Behavioral

---

## What it is

Exige que a lógica de negócio use **exceções (erros)** para relatar problemas, em vez de códigos de retorno ou valores nulos. Exceções devem ser específicas do domínio (ex: `UsuarioNaoEncontradoError`).

## Why it matters

Códigos de erro ou valores nulos (ex: `return null`) forçam o cliente a verificar o retorno em cada chamada, espalhando lógica de erro. Exceções garantem que o erro não seja ignorado e fornecem *stack trace*.

## Objective Criteria

- [ ] Métodos de negócio (Services, Use Cases) devem retornar tipos válidos ou lançar exceção, **proibindo** `return null` ou `return undefined`.
- [ ] É proibido o uso de `catch` vazio ou que apenas loga o erro e continua o fluxo (deve relançar ou tratar).
- [ ] Exceções lançadas devem ser customizadas para o domínio (ex: estender uma classe `BaseDomainError`).

## Allowed Exceptions

- **Funções de Parse/Utilidade**: Funções de baixo nível que podem retornar `null` ou `undefined` para indicar falha na leitura ou conversão.

## How to Detect

### Manual

Busca por `return null`, `return -1`, ou `catch (e) {}` no código de negócio.

### Automatic

ESLint: `no-return-null`, `no-empty-catch`.

## Related to

- [002 - Prohibition of ELSE Clause](002_prohibition-else-clause.md): complements
- [022 - Simplicity and Clarity (KISS)](022_simplicity-and-clarity.md): reinforces
- [028 - Async Exception Handling](028_async-exception-handling.md): reinforces
- [036 - Side-Effect Function Restrictions](036_side-effect-restrictions.md): reinforces
- [050 - Logs as Event Streams](050_logs-as-event-streams.md): complements

---

**Created on**: 2025-10-08
**Version**: 1.0
