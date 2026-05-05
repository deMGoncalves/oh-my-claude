---
applyTo: "**"
---

# Proibição de Código Inteligente (Clever Code)

**ID**: AP-04-062
**Severity**: 🟡 Medium
**Category**: Behavioral

---

## What it is

Clever Code ocorre quando um desenvolvedor escreve código excessivamente conciso, usando truques não-óbvios, operadores complexos ou padrões de código não convencionais para mostrar "habilidade" em vez de priorizar clareza. Código que faz o desenvolvedor se sentir inteligente ao escrever (e outros se sentirem confusos ao ler).

## Why it matters

- Dificuldade de manutenção: outros desenvolvedores não entendem o código sem gastar muito tempo
- Esconde bugs: código complexo tem mais casos extremos e é mais difícil raciocinar sobre
- Frustra time: cria cultura de "esperteza de código" sobre clareza de código
- Dificuldade de onboarding: novos desenvolvedores levam muito mais tempo para serem produtivos
- Comum em code reviews: "isso funciona mas não consigo entender"

## Objective Criteria

- [ ] Comentários de code review perguntando "o que isso faz?" ou "pode ser mais claro?"
- [ ] Uso de one-liners complexos: encadeamento de ternários, arrow functions com múltiplas operações
- [ ] Operadores de bit-shifting, manipulações bitwise ou outros recursos avançados da linguagem sem comentários explicativos
- [ ] Regex complexo ou parsing de string embutido no código principal
- [ ] Funções com nomes curtos não-explicativos (`fn()`, `go()`, `proc()`) fazendo lógica complexa

## Allowed Exceptions

- Cópia otimizada de algoritmos conhecidos (CRC32, MD5) onde propósito é claro via nome da função
- Code golfing em funções intencionalmente minúsculas onde contexto torna significado óbvio
- Caminhos críticos de performance que foram perfilados como hotspots onde comentários justificam otimização
- Domínio específico (cripto, gráficos, programação de sistemas) onde operações padrão são conhecidas

## How to Detect

### Manual
- Code review: regras explícitas para rejeitar código "esperto" sobre código "claro"
- Buscar one-liners com > 3 operações nas mesmas linhas
- Identificar código que desenvolvedor gasta 5 minutos lendo sem ser o autor
- Verificar comentários apontando "isso é uma otimização" sem medições de profiling

### Automatic
- Linters: ESLint (no-nested-ternary, max-depth, complexity), regras de simplicidade do SonarQube
- Auto-formatters: prettier, black forçam estilo mais legível
- Complexidade ciclomática: detectar funções com alta complexidade que podem ser escritas mais simplesmente

## Related to

- [022 - Simplicity and Clarity (KISS)](022_simplicity-and-clarity.md): reinforces
- [034 - Consistent Class and Method Names](034_consistent-class-method-names.md): reinforces
- [033 - Maximum Function Parameters](033_max-function-parameters.md): reinforces
- [001 - Single-Level Indentation Rule](001_single-indentation-level.md): reinforces
- [069 - Prohibition of Premature Optimization](069_prohibition-premature-optimization.md): reinforces

---

**Created on**: 2026-03-28
**Version**: 1.0
