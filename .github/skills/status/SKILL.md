---
name: status
description: Dashboard de progresso do fluxo. Lista features em changes/, tarefas completas, fase atual e contadores de tentativas por agente.
---

## Propósito

Exibe estado atual de todos os features em andamento, lendo `tasks.md` em `changes/`.

## Instruções

1. **Listar diretórios** em `changes/`:
   ```bash
   ls changes/ 2>/dev/null | sort || echo "(nenhum feature em andamento)"
   ```
   Se vazio, mostrar orientação para usar `/start`.

2. **Para cada feature**, ler `changes/XXX/tasks.md` e extrair:
   - Nome do feature (do diretório)
   - Fase atual (`**Fase Atual**` no cabeçalho)
   - Progresso: contagem de `- [x]` (completo) vs `- [ ]` (pendente)
   - `<!-- attempts-coder: N -->`
   - `<!-- attempts-tester: N -->`
   - `<!-- mode: Quick|Task|Feature -->`

3. **Exibir dashboard** no formato:

```
══════════════════════════════════════════════
  oh my claude — Status do Fluxo
══════════════════════════════════════════════

📋 FEATURES EM ANDAMENTO
──────────────────────────────────────────────

[001] nome-feature  [Feature]
  Fase:      🔬 Fase 1 — Pesquisa
  Progresso: ██░░░░░░░░  2/6 tarefas (33%)
  Agente:    architect

──────────────────────────────────────────────
📊 RESUMO
  Features ativos:   N
  Tarefas completas: X / Y
  Progresso total:   Z%
──────────────────────────────────────────────
```

4. **Indicadores de atenção**:
   - `attempts-coder >= 3` → `⚠️ Re-spec recomendado`
   - Todos `[x]` → `✅ Completo — use /ship para commit`
   - Sem features → orientar para `/start nome-feature`
