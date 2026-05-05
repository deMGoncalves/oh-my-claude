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

# Declaração Explícita de Dependências (Dependencies)

**ID**: INFRASTRUCTURE-041
**Severity**: 🔴 Critical
**Category**: Infrastructure

---

## What it is

Uma aplicação deve declarar **todas** as suas dependências de forma explícita e completa através de um manifesto de dependências (ex: `package.json`, `requirements.txt`). A aplicação nunca deve depender da existência implícita de pacotes no sistema.

## Why it matters

Dependências implícitas quebram a portabilidade e a reprodutibilidade do ambiente. Um novo desenvolvedor ou um novo servidor não conseguirá executar a aplicação sem conhecimento prévio das dependências ocultas, violando o princípio de *setup* mínimo.

## Objective Criteria

- [ ] **100%** das dependências de runtime e build devem estar declaradas no manifesto (`package.json`, `bun.lockb`).
- [ ] É proibido o uso de dependências globais do sistema (ex: bibliotecas instaladas via `npm install -g` ou `apt-get`).
- [ ] O *lockfile* de dependências deve ser versionado e mantido atualizado para garantir builds determinísticos.

## Allowed Exceptions

- **Runtime Base**: Dependências fundamentais do runtime (ex: Node.js, Bun, Python) que são declaradas como requisito de ambiente.

## How to Detect

### Manual

Clonar o repositório em uma máquina limpa e executar `npm install && npm start` — se falhar por dependência faltante, há violação.

### Automatic

CI/CD: Builds em containers efêmeros (Docker) que falham se houver dependências não declaradas.

## Related to

- [014 - Dependency Inversion Principle (DIP)](014_dependency-inversion-principle.md): complements
- [018 - Acyclic Dependencies Principle (ADP)](018_acyclic-dependencies-principle.md): reinforces
- [042 - Environment-Based Configuration](042_environment-based-configuration.md): complements
- [044 - Build-Release-Run Separation](044_build-release-run-separation.md): reinforces

---

**Created on**: 2025-01-10
**Version**: 1.0
