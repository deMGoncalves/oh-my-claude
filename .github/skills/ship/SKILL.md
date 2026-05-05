---
name: ship
description: Prepara mudanças, cria commit Conventional Commits e envia para repositório remoto. Usar após completar Feature, Task ou Quick fix.
---

## Propósito

Commita e envia mudanças atuais para repositório remoto.

## Instruções

1. Executar `git status` — confirmar arquivos a commitar

2. Executar `git diff --stat` — entender escopo das mudanças

3. Elaborar mensagem de commit seguindo Conventional Commits:

   | Prefixo | Quando usar |
   |---------|-------------|
   | `feat:` | Nova funcionalidade |
   | `fix:` | Correção de bug |
   | `refactor:` | Refatoração sem mudança de comportamento |
   | `docs:` | Mudanças de documentação |
   | `chore:` | Manutenção, configs, scripts |
   | `test:` | Adicionar ou corrigir testes |

4. Preparar arquivos com `git add` específico (evitar `git add -A` com arquivos sensíveis)

5. Criar commit:
   ```bash
   git commit -m "tipo: descrição concisa no imperativo"
   ```

6. Enviar: `git push`

7. Confirmar: `git status`

**Não commitar:** `.env` com valores reais, secrets, credenciais hardcoded.
