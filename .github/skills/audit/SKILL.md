---
name: audit
description: Aciona architect (modo review) para revisar branch, PR ou caminho src/ com CDD/ICP + 70 regras + segurança. Posta comentário diretamente em PRs. Uso: /audit | /audit pr <num> | /audit src/caminho | /audit <branch> [en|es|pt]
---

## Propósito

Executa revisão completa de código usando architect em modo review (CDD/ICP, 70 regras arquiteturais, segurança). Aceita 4 modos:

| Argumento | O que revisa |
|-----------|--------------|
| _(sem argumento)_ | Diff da branch atual vs main |
| `src/context/container/component` | Arquivos de vertical slice específico |
| `pr <número>` | Pull Request no GitHub |
| `<nome-branch>` | Diff de branch específica vs main |

## Instruções

### Passo 0 — Idioma dos Comentários

Verificar se o argumento contém código de idioma explícito no final:

| Sufixo | Idioma dos Comentários |
|--------|------------------------|
| `en` | Inglês |
| `es` | Espanhol |
| `pt` _(ou ausente)_ | Português _(padrão)_ |

Exemplos: `/audit pr 42 es` → comentários em espanhol. `/audit feat/login` → português.

Extrair código de idioma e removê-lo do argumento antes de continuar.

---

### Passo 1 — Detectar alvo

| Condição | Modo |
|----------|------|
| Vazio | **Branch Atual** — diff vs main |
| Começa com `src/` | **Path** — vertical slice específico |
| É número ou começa com `pr ` | **PR** — Pull Request no GitHub |
| Qualquer outra string | **Branch** — diff de branch nomeada vs main |

---

### Passo 2 — Coletar contexto por modo

#### Modo Branch (atual ou nomeada)

```bash
git diff main...HEAD --name-only
git diff main...HEAD
```

Verificar se há arquivos `.tsx` ou `.jsx` — isso ativa análise de patterns React.

#### Modo Path (`src/...`)

```bash
find <path> -type f \( -name "*.ts" -o -name "*.tsx" \) | sort
```

#### Modo PR (`pr <número>` ou número)

```bash
gh pr view <número> --json number,title,body,headRefName,changedFiles,labels
gh pr checks <número> 2>/dev/null || echo "(sem checks configurados)"
gh pr diff <número> --name-only
gh pr diff <número>
```

**Detectar tipo do PR** a partir do título ou labels:

| Prefixo no título / label | Tipo | Tolerância de severidade |
|---------------------------|------|--------------------------|
| `fix:`, `bugfix`, `hotfix` | 🐛 Fix | **Alta** — correção vem primeiro |
| `feat:`, `feature` | ✨ Feature | **Média** — qualidade importa mas não trava MVP |
| `refactor:`, `refact` | ♻️ Refatoração | **Baixa** — deve melhorar qualidade |
| `docs:`, `doc` | 📝 Documentação | **Muito alta** — rigor técnico não se aplica |
| `chore:`, `ci:`, `build:` | 🔧 Infraestrutura | **Alta** — impacto limitado |
| `style:`, `ui:` | 🎨 Visual/UI | **Alta** — trade-offs de experiência |
| _(sem prefixo detectado)_ | ❓ Desconhecido | **Média** |

---

### Passo 3 — Carregar skills de análise

Ler os seguintes arquivos antes de acionar architect:

```
.github/skills/cdd/SKILL.md               → metodologia ICP (CC_base + nesting + responsibilities + coupling)
.github/skills/software-quality/SKILL.md  → calibração de severidade via McCall (12 fatores de qualidade)
.github/skills/anti-patterns/SKILL.md     → catálogo de 26 anti-patterns para identificação em diff
```

---

### Passo 4 — Acionar `--agent architect`

Invocar com `--agent architect` passando o contexto coletado e as instruções abaixo.

---

> **architect**: Realize revisão completa do código abaixo.
>
> **Idioma:** Escrever todos os comentários em **[IDIOMA DETECTADO NO PASSO 0]**.
>
> **Contexto de negócio:**
> - Tipo de mudança: **[TIPO DETECTADO]** — tolerância de severidade **[ALTA/MÉDIA/BAIXA]**
> - Status do CI: **[RESULTADO DE gh pr checks OU "não disponível"]**
> - Arquivos com React (.tsx/.jsx): **[SIM/NÃO]**
>
> **Como calibrar severidade:**
> - Em **bug fix**, priorizar correção estar correta — violações de estilo não são bloqueantes
> - Em **feature**, equilibrar qualidade e entrega — não travar por detalhes
> - Em **refatoração**, ser mais rigoroso — objetivo declarado é melhorar qualidade
> - **Nunca usar 🔴 para limites de linhas (50 vs 51)** — reservar para bugs reais, segurança e problemas sérios de manutenibilidade
> - Reconhecer evolução: se código melhorou em relação ao estado anterior, dizer isso
>
> **Como analisar:**
> - Medir complexidade cognitiva via ICP (CC + nesting + responsibilities + coupling)
> - Verificar conformidade com regras arquiteturais em `.github/instructions/`
> - Se arquivos React: verificar deps de `useEffect`, prop drilling, cleanup de effects, tamanho de componentes
>
> **Tom e formato — CRÍTICO:**
>
> Você é um **colega de desenvolvimento**, não um auditor.
>
> **NUNCA:** usar headers markdown em comentários de PR; criar relatórios estruturados formais; mencionar nomes de metodologias (CDD, ICP, McCall, SOLID) ao desenvolvedor.
>
> **SEMPRE:** escrever como mensagem para colega — natural, direto, amigável; variar inícios: "Vi que...", "Uma coisa...", "Atenção aqui...", "Boa aí com...", "Pode funcionar mas..."; explicar POR QUE do problema; mostrar caminho para melhorar com exemplo de código; aplicar **Teste do Slack**: "eu enviaria isso para colega no Slack?" — se não, reescrever.
>
> **Nunca mencione arquivos de config internos, IDs de regras como paths ou nomes de skills.**
>
> Produza um **relatório final em linguagem natural** (sem headers), organizado por impacto — do mais crítico ao menos urgente — com veredito claro e encorajador ao final.

---

### Passo 5 — Relatar e ação pós-revisão

1. **Exibir relatório** em linguagem natural — começar pelo que está bom, terminar com veredito encorajador.

2. **Se modo PR**, perguntar ao usuário:

   > Quer postar comentário no PR?
   > - `sim` — postar como comentário geral
   > - `não` — manter apenas aqui

   Se `sim`, executar:

   ```bash
   gh pr review <número> --comment -b "<texto do relatório>"
   ```

**Importante:** Nunca postar revisão em PR sem confirmação explícita do usuário.
