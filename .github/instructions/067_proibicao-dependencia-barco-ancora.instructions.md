---
applyTo: "**"
---

# Proibição de Dependência Barco-Âncora

**ID**: AP-01-067
**Severity**: 🟡 Medium
**Category**: Structural

---

## What it is

Boat Anchor ocorre quando uma dependência, biblioteca ou componente é importado para a base de código, instalado no `package.json` ou `requirements.txt`, mas nunca é usado ou usado apenas superficialmente. Como uma âncora de barco que interfere no movimento, essas dependências não usadas adicionam complexidade e custo de manutenção sem trazer valor. Variante de Lava Flow para dependências.

## Why it matters

- Inchaço de dependências: mais arquivos, mais downloads, mais tempo de build/CI/CD
- Vulnerabilidades de segurança: dependências não usadas não são monitoradas mas podem ter CVEs
- Dificuldade de onboarding: desenvolvedores se perguntam "para que serve X?" e perdem tempo pesquisando
- Confusão tecnológica: parece ser usado mas não é; falsa impressão de capacidades
- Licenças complexas: dependências não usadas podem introduzir problemas de licenciamento sem razão

## Objective Criteria

- [ ] Dependência listada em `package.json`, `requirements.txt`, `Pipfile`, `go.mod`, mas nunca importada
- [ ] Biblioteca importada mas nunca chamada (`import X` sem uso de `X.method()`)
- [ ] Dependência morta (não mantida) mantida "just in case" sem timeline de uso futuro
- [ ] Framework/biblioteca instalado mas apenas 1-2 features usadas quando alternativa simples existe

## Allowed Exceptions

- DevDependencies usadas apenas em build-tooling (linters, formatters não referenciados em código prod)
- Dependências opcionais onde uso é desconhecido em runtime até execução (plugins)
- Dependência futura com roadmap bem definido (ex: feature requerendo X no Q3) se documentado em comments/tickets

## How to Detect

### Manual
- Comparar `package.json`/`requirements.txt` com `grep -r "^import\|^from"` ou `grep -r "^require\|^use"` — diff são boat anchors
- Buscar bibliotecas onde docs/wiki mencionam "usamos X" mas grep code base mostra zero uso
- Verificar testes: se biblioteca não aparece em testes apenas em código de produção não importado, é boat anchor

### Automatic
- Ferramentas: npm-check, depcheck, pipreqs, go mod tidy
- CI/CD: scripts que detectam dependências não usadas e falham build
- Ferramentas de análise de dependências: detectar imports vs uso em toda a base de código

## Related to

- [056 - Prohibition of Zombie Code (Lava Flow)](056_prohibition-zombie-code-lava-flow.md): complements
- [041 - Explicit Dependency Declaration](041_explicit-dependency-declaration.md): reinforces
- [039 - Boy Scout Rule (Continuous Refactoring)](039_boy-scout-rule-continuous-refactoring.md): reinforces
- [043 - Configurações de Ambiente](043_backing-services-as-resources.md): complements
- [022 - Simplicity and Clarity (KISS)](022_simplicity-and-clarity.md): reinforces

---

**Created on**: 2026-03-28
**Version**: 1.0
