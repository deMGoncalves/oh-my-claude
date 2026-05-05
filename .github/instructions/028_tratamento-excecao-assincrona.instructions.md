---
applyTo: "**"
---

# Tratamento Completo de Exceção Assíncrona (Promises)

**ID**: BEHAVIORAL-028
**Severity**: 🔴 Critical
**Category**: Behavioral

---

## What it is

Exige que todas as Promises retornadas sejam explicitamente tratadas (consumidas) com **`await`**, **`.catch()`**, ou um padrão de resultado, para prevenir *Uncaught Promise Rejections* (erros não capturados).

## Why it matters

Em ambientes como Node.js, exceções não tratadas em Promises são fatais e derrubam o processo principal. Garante que a **estabilidade** do sistema não seja comprometida por chamadas assíncronas "flutuantes" ou erros ignorados.

## Objective Criteria

- [ ] Todas as chamadas de função que retornam `Promise` devem ser seguidas por `await` ou `Promise.then().catch()`.
- [ ] É proibido o uso de `async` em um método sem que haja pelo menos um `await` ou uma chamada assíncrona dentro de seu corpo.
- [ ] O código não deve lançar Promises sem capturar o erro em um contexto tratável.

## Allowed Exceptions

- **Event Emitters/Listeners**: Código que se integra a *Event Loops* internos ou padrões Observer, onde o tratamento do erro é delegado ao *listener* central.

## How to Detect

### Manual

Busca por chamadas de função que retornam Promises sem `await` ou `.catch()` imediatamente após.

### Automatic

ESLint: `no-floating-promises`, `require-await`.

## Related to

- [027 - Domain Error Handling Quality](027_domain-error-handling-quality.md): reinforces
- [014 - Dependency Inversion Principle (DIP)](014_dependency-inversion-principle.md): complements
- [048 - Process Disposability](048_process-disposability.md): complements

---

**Created on**: 2025-10-08
**Version**: 1.0
