## Tipo de contribuição

<!-- Marque com [x] o que se aplica -->

- [ ] 🆕 Nova rule
- [ ] 🧠 Nova skill
- [ ] ⚡ Novo command
- [ ] 🤖 Melhoria de agent
- [ ] 🐛 Correção de bug
- [ ] 📝 Documentação
- [ ] 🔧 Outro: _____

---

## Descrição

<!-- O que este PR faz? Qual problema resolve ou melhoria traz? -->

---

## Para rules/skills/commands — Checklist

### Se for uma **rule**:
- [ ] ID único definido (próximo disponível: `071`)
- [ ] Categoria correta (OC/SOLID/PP/CC/TF/AP)
- [ ] Severidade justificada (🔴/🟠/🟡)
- [ ] Critérios objetivos e mensuráveis
- [ ] Seção `## Como Detectar` com Manual e Automático
- [ ] Cross-references bidirecionais adicionadas nas rules relacionadas
- [ ] Adicionado ao `CHANGELOG.md` em `[Unreleased]`

### Se for uma **skill**:
- [ ] Frontmatter completo (`name`, `description`, `model`, `metadata.author`)
- [ ] Description com triggers específicos (≤ 250 chars)
- [ ] Seção `## Exemplos` com ❌/✅
- [ ] Seção `## Fundamentação` com links para rules relacionadas
- [ ] Adicionado ao `CHANGELOG.md` em `[Unreleased]`

### Se for um **command**:
- [ ] Testado localmente com Claude Code CLI
- [ ] `allowed-tools` com permissões mínimas
- [ ] Adicionado à tabela de commands no `README.md` e `CLAUDE.md`
- [ ] Adicionado ao `CHANGELOG.md` em `[Unreleased]`

---

## Como testar

<!-- Descreva como revisar e testar esta contribuição -->

---

## Contexto adicional

<!-- Screenshots, referências, discussões relacionadas -->
