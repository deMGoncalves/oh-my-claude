---
name: sync
description: Atualiza branch atual com últimas mudanças do repositório remoto. Funciona em qualquer branch — main ou feature.
---

## Propósito

Sincroniza branch local com remoto, gerenciando branches de feature e main adequadamente.

## Instruções

1. Verificar branch atual:
   ```bash
   git branch --show-current
   git status --short
   ```

2. `git fetch origin` — buscar mudanças sem aplicar

3. **Se em main/master:** `git pull origin main`

4. **Se em branch de feature:**
   ```bash
   git checkout main
   git pull origin main
   git checkout [branch-original]
   git merge main
   ```

5. Confirmar com `git status`

**Importante:** Adaptar `main` ou `master` conforme convenção do repositório.
