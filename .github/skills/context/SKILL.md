---
name: context
description: Injeta contexto de episódios anteriores na sessão atual. Workaround para ausência de memória episódica nativa no Copilot CLI. Lista episódios disponíveis e carrega os mais relevantes para o trabalho atual.
---

## Propósito

O GitHub Copilot CLI não possui memória episódica nativa entre sessões. Esta skill carrega episódios de sessões anteriores de `memory/episodes/` e os injeta como contexto.

## Instruções

1. **Listar episódios disponíveis:**
   ```bash
   ls memory/episodes/ 2>/dev/null | sort -r | head -10 || echo "(nenhum episódio)"
   ```

2. **Ler os 3 episódios mais recentes** de `memory/episodes/`:
   - Cada arquivo tem formato `YYYY-MM-DD_feature.md`
   - Leia para entender padrões, decisões e contexto das features anteriores

3. **Se há trabalho em andamento** (arquivos em `changes/`):
   - Buscar episódio relacionado à feature atual por similaridade de nome
   - Priorizar esse episódio sobre os mais recentes

4. **Exibir resumo do contexto carregado:**
   ```
   📚 Contexto de episódios carregados:
   - [data] [nome-feature]: [1 linha de resumo]
   - [data] [nome-feature]: [1 linha de resumo]
   - [data] [nome-feature]: [1 linha de resumo]

   ✅ Contexto pronto. Você pode prosseguir com o trabalho.
   ```

5. **Opcional — ver padrões candidatos:**
   ```bash
   cat memory/patterns/candidates.md 2>/dev/null || echo "(nenhum candidato)"
   ```

## Uso recomendado

Executar `/context` no início de cada sessão para reestabelecer contexto de trabalhos anteriores.
