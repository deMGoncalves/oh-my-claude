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

# Base de Código Única (Codebase)

**ID**: INFRASTRUCTURE-040
**Severity**: 🔴 Critical
**Category**: Infrastructure

---

## What it is

Uma aplicação deve ter exatamente uma base de código rastreada em controle de versão, com múltiplos *deploys* originados dessa mesma base. A relação entre codebase e aplicação é sempre 1:1.

## Why it matters

Múltiplas bases de código para a mesma aplicação indicam um sistema distribuído, não uma aplicação. Código compartilhado deve ser extraído em bibliotecas e gerenciado via dependências. A violação dificulta rastreabilidade, versionamento e manutenção.

## Objective Criteria

- [ ] A aplicação deve ter **um único repositório** de código-fonte, com branches para diferentes estágios (dev, staging, prod).
- [ ] Código compartilhado entre aplicações deve ser extraído para **bibliotecas independentes** com versionamento próprio.
- [ ] É proibido copiar código entre repositórios de aplicações diferentes (*copy-paste deployment*).

## Allowed Exceptions

- **Monorepos Organizacionais**: Múltiplas aplicações em um único repositório, desde que cada aplicação tenha seu próprio diretório raiz e pipeline de deploy independente.

## How to Detect

### Manual

Verificar se existem múltiplos repositórios com código duplicado ou se a mesma funcionalidade é mantida em locais diferentes.

### Automatic

Git: Análise de histórico de commits e branches para identificar divergências não intencionais.

## Related to

- [021 - Prohibition of Logic Duplication (DRY)](021_prohibition-logic-duplication.md): reinforces
- [015 - Release-Reuse Equivalence Principle (REP)](015_release-reuse-equivalence-principle.md): reinforces
- [044 - Build-Release-Run Separation](044_build-release-run-separation.md): complements

---

**Created on**: 2025-01-10
**Version**: 1.0
