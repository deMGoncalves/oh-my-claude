# Proibição de Mudança Divergente

**ID**: AP-16-054
**Severity**: 🟠 High
**Category**: Structural

---

## What it is

Mudança Divergente (Divergent Change) ocorre quando uma única classe é modificada por múltiplas razões diferentes e não relacionadas. Cada novo tipo de mudança requer editar a mesma classe por uma razão completamente diferente da anterior. Oposto complementar de Shotgun Surgery: aqui, uma classe muda por N razões.

## Why it matters

- Violação do Princípio de Responsabilidade Única (SRP): classe com múltiplas responsabilidades
- Alto risco de regressão: alterar uma preocupação (ex: banco de dados) pode quebrar acidentalmente outra (ex: regra de negócio)
- Manutenção difícil: desenvolvedores não sabem quais partes da classe são seguras de editar
- Testes complexos: é difícil testar cada responsabilidade isoladamente quando estão misturadas
- Histórico de commits confuso: commits de features totalmente diferentes sempre tocam o mesmo arquivo

## Objective Criteria

- [ ] Classe possui seções separadas por comentários (`// lógica do banco`, `// regras de negócio`, `// formatação ui`)
- [ ] Histórico de commits mostra commits de features diferentes sempre modificando o mesmo arquivo
- [ ] Testes unitários precisam mockar múltiplas responsabilidades para testar uma única funcionalidade
- [ ] Múltiplas razões-para-mudar documentadas ou discutidas em code reviews
- [ ] Classe cresce continuamente porque cada nova feature adiciona +1 método para responsabilidade diferente

## Allowed Exceptions

- Classes pequenas (< 100 linhas) com responsabilidades estreitamente relacionadas
- DTOs (Data Transfer Objects) ou Value Objects que por definição agrupam dados
- Adapters que precisam implementar múltiplas interfaces do mesmo paradigma
- Código legado onde refatoração imediata traria risco inaceitável

## How to Detect

### Manual
- Ler comentários que delimitam seções claramente distintas na mesma classe
- Analisar histórico de commits: identificar commits de features diferentes editando o mesmo arquivo
- Verificar testes: se testar uma responsabilidade requer preparar/mockar outras, pode ser mudança divergente
- Buscar classes que respondem a múltiplos tipos de requisitos (banco de dados, ui, domínio, infraestrutura)

### Automatic
- Análise de commits: detectar arquivos com commits de múltiplas categorias/labels
- Análise de acoplamento: detectar classes mudando por múltiplas razões-para-mudar
- Métricas de coesão: baixa coesão funcional indica múltiplas responsabilidades

## Related to

- [010 - Single Responsibility Principle (SRP)](010_single-responsibility-principle.md): reinforces
- [058 - Prohibition of Shotgun Surgery](058_prohibition-shotgun-surgery.md): complements
- [007 - Maximum Lines per Class File](007_max-lines-per-class.md): reinforces
- [025 - Prohibition of The Blob Anti-Pattern](025_prohibition-the-blob.md): complements
- [004 - First-Class Collections](004_first-class-collections.md): reinforces
- [014 - Dependency Inversion Principle (DIP)](014_dependency-inversion-principle.md): complements

---

**Created on**: 2026-03-28
**Version**: 1.0
