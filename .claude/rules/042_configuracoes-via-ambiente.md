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

# Configurações via Variáveis de Ambiente (Config)

**ID**: INFRASTRUCTURE-042
**Severity**: 🔴 Critical
**Category**: Infrastructure

---

## What it is

Todas as configurações que variam entre ambientes (*deploy*) devem ser armazenadas em **variáveis de ambiente**, não em arquivos de configuração versionados ou hardcoded no código. Isso inclui credenciais, URLs de serviços, e feature flags.

## Why it matters

Configurações hardcoded ou em arquivos versionados criam risco de vazamento de credenciais, impedem deploys flexíveis e violam a separação entre código e configuração. Variáveis de ambiente permitem que o mesmo código rode em qualquer ambiente.

## Objective Criteria

- [ ] Credenciais (API keys, senhas, tokens) devem ser acessadas **exclusivamente** via `process.env` ou equivalente.
- [ ] É proibido versionar arquivos `.env` com valores reais de produção ou staging.
- [ ] O código deve funcionar com **zero** arquivos de configuração específicos de ambiente no repositório.

## Allowed Exceptions

- **Configurações de Desenvolvimento**: Arquivo `.env.example` com valores de exemplo para documentação.
- **Configurações Estruturais**: Arquivos de configuração de build (`tsconfig.json`, `biome.json`) que não variam entre deploys.

## How to Detect

### Manual

Busca por strings de conexão, URLs de API, ou credenciais hardcoded no código-fonte.

### Automatic

ESLint: Regras customizadas para detectar strings que parecem credenciais. Git-secrets ou Gitleaks para varredura de segredos.

## Related to

- [030 - Prohibition of Unsafe Functions](030_prohibition-unsafe-functions.md): reinforces
- [024 - Prohibition of Magic Constants](024_prohibition-magic-constants.md): reinforces
- [041 - Explicit Dependency Declaration](041_explicit-dependency-declaration.md): complements
- [043 - Backing Services as Resources](043_backing-services-as-resources.md): complements
- [049 - Dev/Prod Parity](049_dev-prod-parity.md): reinforces

---

**Created on**: 2025-01-10
**Version**: 1.0
