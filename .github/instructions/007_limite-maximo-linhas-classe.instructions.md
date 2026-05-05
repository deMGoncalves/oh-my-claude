---
applyTo: "**"
---

# Limite Máximo de Linhas por Arquivo de Classe

**ID**: STRUCTURAL-007
**Severity**: 🔴 Critical
**Category**: Structural

---

## What it is

Impõe um limite máximo no número de linhas de código em um arquivo de classe (entidade, *service*, controlador), forçando a extração de responsabilidades para outras classes.

*(Previne o anti-pattern Large Class: uma classe com muitos atributos e métodos, indicando responsabilidades excessivas.)*

## Why it matters

A violação do limite de linhas é um forte indicador de que a classe está violando o Princípio da Responsabilidade Única (SRP), resultando em classes com baixa coesão, alto acoplamento e dificuldade extrema na manutenção e testes.

## Objective Criteria

- [ ] Arquivos de classe (incluindo declarações, métodos e propriedades) devem ter, no máximo, 50 linhas de código (excluindo linhas em branco e comentários).
- [ ] Classes que atingem 40 linhas devem ser imediatamente candidatas à refatoração.
- [ ] Métodos individuais devem ter, no máximo, 15 linhas de código.

## Allowed Exceptions

- **Classes de Configuração/Inicialização**: Classes que apenas declaram constantes ou mapeamentos (ex: *Mappers*, *Configuration*).
- **Classes de Teste**: *Suites* de teste onde cada método de teste é pequeno, mas o arquivo cresce devido ao número de cenários.

## How to Detect

### Manual

Contagem visual ou uso de ferramentas de análise de métricas de arquivo.

### Automatic

SonarQube/ESLint: `max-lines-per-file: 50` e `max-lines-per-method: 5`.

## Related to

- [001 - Single-Level Indentation Rule](001_single-indentation-level.md): reinforces
- [004 - First-Class Collections](004_first-class-collections.md): reinforces
- [010 - Single Responsibility Principle (SRP)](010_single-responsibility-principle.md): reinforces
- [021 - Prohibition of Logic Duplication (DRY)](021_prohibition-logic-duplication.md): reinforces
- [023 - Prohibition of Speculative Functionality (YAGNI)](023_prohibition-speculative-functionality.md): reinforces
- [025 - Prohibition of The Blob Anti-Pattern](025_prohibition-the-blob.md): reinforces
- [016 - Common Closure Principle (CCP)](016_common-closure-principle.md): reinforces
- [022 - Simplicity and Clarity (KISS)](022_simplicity-and-clarity.md): complements
- [055 - Maximum Lines per Method](055_max-lines-per-method.md): complements
- [054 - Prohibition of Divergent Change](054_prohibition-divergent-change.md): complements

---

**Created on**: 2025-10-04
**Version**: 1.0
