---
applyTo: "**"
---

# Proibição de Funções Inseguras (eval, new Function, Secrets)

**ID**: BEHAVIORAL-030
**Severity**: 🔴 Critical
**Category**: Behavioral

---

## What it is

Proíbe o uso de funções que executam código arbitrário a partir de strings (ex: `eval()`) ou que criam vulnerabilidades de segurança graves, como o *hardcoding* de segredos.

## Why it matters

Funções como `eval()` são vetores de ataque para **Execução Remota de Código (RCE)** e injeção de código. O *hardcoding* de segredos viola a política de segurança, tornando o *deployment* inseguro.

## Objective Criteria

- [ ] O uso das funções `eval()` e `new Function()` (sem a finalidade de compilação isolada) é proibido.
- [ ] Chaves de API ou segredos devem ser injetados exclusivamente via `process.env` ou ferramenta de gerenciamento de segredos.
- [ ] É proibida a concatenação de *strings* de entrada de usuário em consultas diretas ao sistema de arquivos ou a comandos de *shell*.

## Allowed Exceptions

- **Tooling/Build Steps**: Uso controlado de *eval* ou *new Function* em *build scripts* para otimizar *bundling*.

## How to Detect

### Manual

Busca por `eval`, `new Function`, ou chaves de API *hardcoded*.

### Automatic

ESLint: `no-eval`, `no-implied-eval`.

## Related to

- [024 - Prohibition of Magic Constants](024_prohibition-magic-constants.md): complements
- [042 - Environment-Based Configuration](042_environment-based-configuration.md): reinforces

---

**Created on**: 2025-10-08
**Version**: 1.0
