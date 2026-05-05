---
applyTo: "**"
---

---
paths:
  - "**/*.yml"
  - "**/*.yaml"
  - "**/*.json"
  - "**/Dockerfile*"
  - "**/docker-compose*"
  - "**/.env*"
  - "**/package.json"
  - "**/tsconfig.json"
---

# Processos Administrativos como One-Off (Admin Processes)

**ID**: INFRASTRUCTURE-051
**Severity**: 🟠 High
**Category**: Infrastructure

---

## What it is

Tarefas administrativas ou de manutenção (migrações de banco, scripts de correção, console REPL) devem ser executadas como **processos one-off** no mesmo ambiente e com o mesmo código da aplicação principal, não como scripts separados ou processos persistentes.

## Why it matters

Processos administrativos executados fora do ambiente da aplicação podem usar versões diferentes do código ou dependências, causando inconsistências. Executar no mesmo contexto garante que migrations e scripts usem exatamente o mesmo código em produção.

## Objective Criteria

- [ ] Scripts de migração de banco devem ser executados como processos one-off usando o mesmo runtime e dependências da aplicação.
- [ ] Tarefas administrativas devem estar **versionadas no repositório** junto com o código da aplicação.
- [ ] É proibido executar scripts administrativos via SSH direto no servidor — devem usar o mesmo mecanismo de deploy.

## Allowed Exceptions

- **Ferramentas de Infraestrutura**: Scripts de provisionamento de infraestrutura (Terraform, Ansible) que operam em nível diferente da aplicação.
- **Debugging de Emergência**: Acesso direto ao ambiente em situações críticas de produção, com auditoria.

## How to Detect

### Manual

Verificar se scripts de migração ou manutenção são executados via processo separado ou via SSH manual.

### Automatic

CI/CD: Pipeline que executa migrations como step do deploy, usando mesmo container/ambiente da aplicação.

## Related to

- [040 - Single Codebase](040_single-codebase.md): reinforces
- [041 - Explicit Dependency Declaration](041_explicit-dependency-declaration.md): reinforces
- [044 - Build-Release-Run Separation](044_build-release-run-separation.md): complements
- [049 - Dev/Prod Parity](049_dev-prod-parity.md): reinforces

---

**Created on**: 2025-01-10
**Version**: 1.0
