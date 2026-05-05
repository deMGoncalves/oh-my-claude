---
applyTo: "**"
---

# Proibição de Nomes Abreviados e Acrônimos Ambíguos

**ID**: STRUCTURAL-006
**Severity**: 🟡 Medium
**Category**: Structural

---

## What it is

Exige que nomes de variáveis, métodos, classes e parâmetros sejam completos, autoexplicativos e não utilizem abreviações ou acrônimos que não sejam amplamente reconhecidos no domínio do problema.

## Why it matters

A clareza do código depende diretamente da clareza dos nomes. Abreviações reduzem a legibilidade, tornam o código menos pesquisável e forçam o desenvolvedor a decodificar o significado, aumentando o custo cognitivo.

## Objective Criteria

- [ ] Nomes de classes, métodos e variáveis devem ter, no mínimo, 3 caracteres (exceto exceções).
- [ ] Acrônimos (ex: `Mngr` para `Manager`, `Calc` para `Calculate`) são proibidos, exceto exceções.
- [ ] Nomes devem representar o significado sem a necessidade de olhar a documentação.

## Allowed Exceptions

- **Convenções de Loop**: Variáveis de iteração únicas e de curta duração (ex: `i`, `j`).
- **Acrônimos Ubíquos**: Acrônimos comuns na indústria (ex: `ID`, `URL`, `API`, `HTTP`).

## How to Detect

### Manual

Busca por nomes de variáveis que sejam incompreensíveis para um leitor novo sem contexto.

### Automatic

ESLint: `naming-convention` com limites mínimos de caracteres.

## Related to

- [005 - Method Chaining Restriction](005_one-call-per-line.md): complements
- [003 - Primitive Domain Encapsulation](003_primitive-encapsulation.md): reinforces
- [024 - Prohibition of Magic Constants](024_prohibition-magic-constants.md): complements
- [026 - Comment Quality: Why, Not What](026_comment-quality-why-not-what.md): reinforces
- [034 - Consistent Class and Method Names](034_consistent-class-method-names.md): reinforces
- [035 - Prohibition of Misleading Names](035_prohibition-misleading-names.md): complements
- [022 - Simplicity and Clarity (KISS)](022_simplicity-and-clarity.md): complements

---

**Created on**: 2025-10-04
**Version**: 1.0
