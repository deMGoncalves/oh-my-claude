# Proibição de Funcionalidade Especulativa (Princípio YAGNI)

**ID**: BEHAVIORAL-023
**Severity**: 🟡 Medium
**Category**: Behavioral

---

## What it is

Exige que o código seja implementado apenas quando uma funcionalidade é **necessária** (e não *talvez necessária* no futuro), evitando a inclusão de código ou abstrações desnecessárias.

*(Previne o anti-pattern Speculative Generality: hooks, parâmetros, classes abstratas e configurações criadas para casos de uso hipotéticos sem uso atual.)*

## Why it matters

A funcionalidade especulativa aumenta a complexidade e o código morto, desperdiçando tempo de desenvolvimento. Aumenta a superfície de ataque e reduz a agilidade na resposta a mudanças reais.

## Objective Criteria

- [ ] Classes ou métodos *vazios* que visam ser *placeholders* para funcionalidades futuras são proibidos.
- [ ] É proibida a adição de parâmetros ou opções de configuração que não são usados imediatamente pelo menos por **um** cliente.
- [ ] O código não deve conter mais de **5%** de linhas marcadas como desabilitadas ou com comentários indicando "TODO: futura implementação".

## Allowed Exceptions

- **Requisitos de Interface**: Métodos de interface exigidos por um contrato externo (ex: `Disposable` ou `Closable`) que são trivialmente implementados.

## How to Detect

### Manual

Busca por métodos vazios, parâmetros não utilizados, ou código que nunca é chamado (código morto).

### Automatic

SonarQube/ESLint: `no-unused-vars`, `no-empty-function`.

## Related to

- [007 - Maximum Lines per Class File](007_max-lines-per-class.md): reinforces
- [022 - Simplicity and Clarity (KISS)](022_simplicity-and-clarity.md): complements
- [069 - Prohibition of Premature Optimization](069_prohibition-premature-optimization.md): complements

---

**Created on**: 2025-10-08
**Version**: 1.0
