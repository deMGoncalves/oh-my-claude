---
applyTo: "**"
---

# Proibição de Shotgun Surgery

**ID**: AP-15-058
**Severity**: 🟠 High
**Category**: Structural

---

## What it is

Shotgun Surgery ocorre quando uma única mudança requer alterar múltiplas classes ou módulos diferentes. Oposto complementar de Mudança Divergente: aqui, cada novo requisito exige fazer mudanças em múltiplos locais do código (como disparar uma espingarda, acertando vários pontos). Indica baixa coesão e alto acoplamento.

## Why it matters

- Mudanças custosas: cada novo requisito ou correção requer tocar em N lugares
- Alta probabilidade de regressão: é fácil esquecer um dos N locais que precisam mudar
- Dificuldade de teste: testar mudanças espalhadas requer criar mocks para múltiplos módulos
- Indicação de código replicado: lógica que deveria estar centralizada está duplicada
- Frágil: ao mudar um requisito, quebra algo nos outros N módulos anteriormente afetados

## Objective Criteria

- [ ] Mudança de comportamento requer alterar 3+ classes/módulos
- [ ] Mesma lógica de cálculo ou validação existe em múltiplos locais
- [ ] Adicionar novo campo/feature requer modificar N arquivos em camadas diferentes
- [ ] Correção de bug precisa ser aplicada em múltiplos arquivos com mesmo padrão de correção
- [ ] Code review mostra commits modificando arquivos completamente diferentes sem relação clara

## Allowed Exceptions

- Arquiteturas explícitas onde camadas são intencionalmente separadas (controller, service, repository)
- Sistemas de plugins/modulares onde opiniões são extensíveis por design
- Código legado onde refatoração imediata traria risco inaceitável
- Fronteiras de microserviços por design onde múltiplos serviços tratam mesma preocupação de domínio

## How to Detect

### Manual
- Analisar histórico de commits: commits de features que sempre tocam N arquivos diferentes
- Buscar comportamentos duplicados: mesma lógica em controllers, services, repositories
- Verificar adição de nova feature: requereria alterar configuração, schema, múltiplos handlers, testes em múltiplos arquivos?
- Code review: desenvolvedores dizem "preciso mudar X, Y, Z e W" para uma única feature

### Automatic
- Análise de commits: detectar commits que sempre tocam múltiplos arquivos diferentes para mesma feature
- Análise de similaridade de código: detectar código duplicado ou muito similar em múltiplos locais
- Análise de coesão: baixa coesão entre módulos indica shotgun surgery

## Related to

- [021 - Prohibition of Logic Duplication (DRY)](021_prohibition-logic-duplication.md): reinforces
- [054 - Prohibition of Divergent Change](054_prohibition-divergent-change.md): complements
- [010 - Single Responsibility Principle (SRP)](010_single-responsibility-principle.md): reinforces
- [018 - Acyclic Dependencies Principle (ADP)](018_acyclic-dependencies-principle.md): complements
- [016 - Common Closure Principle (CCP)](016_common-closure-principle.md): reinforces
- [017 - Common Reuse Principle (CRP)](017_common-reuse-principle.md): reinforces
- [039 - Boy Scout Rule (Continuous Refactoring)](039_boy-scout-rule-continuous-refactoring.md): reinforces

---

**Created on**: 2026-03-28
**Version**: 1.0
