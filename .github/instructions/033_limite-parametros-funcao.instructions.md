---
applyTo: "**"
---

# Limite Máximo de Parâmetros por Função

**ID**: STRUCTURAL-033
**Severity**: 🟠 High
**Category**: Structural

---

## What it is

Define um limite máximo de **3 parâmetros** por função ou método para reduzir a complexidade da assinatura e forçar a coesão, promovendo o uso de *Parameter Objects* (DTOs).

## Why it matters

Funções com muitos parâmetros (*Long Parameter List*) aumentam a **complexidade cognitiva**, dificultam a testabilidade e frequentemente indicam uma violação do Princípio da Responsabilidade Única (SRP).

## Objective Criteria

- [ ] Funções e métodos não devem ter mais de **3** parâmetros.
- [ ] Para mais de 3 parâmetros, um objeto de parâmetro (DTO ou *Value Object*) deve ser criado para agrupar os dados.
- [ ] Construtores de classes podem exceder o limite se estiverem configurando um objeto via injeção de dependência.

## Allowed Exceptions

- **Funções de Bibliotecas Externas**: Funções que implementam uma assinatura exigida por um *framework* ou biblioteca de terceiros.

## How to Detect

### Manual

Identificar assinaturas de métodos com 4 ou mais parâmetros.

### Automatic

Biome/ESLint: `max-params: ["error", 3]`.

## Related to

- [003 - Primitive Domain Encapsulation](003_primitive-encapsulation.md): reinforces
- [010 - Single Responsibility Principle (SRP)](010_single-responsibility-principle.md): reinforces
- [037 - Prohibition of Flag Arguments](037_prohibition-flag-arguments.md): reinforces

---

**Created on**: 2025-10-08
**Version**: 1.0
