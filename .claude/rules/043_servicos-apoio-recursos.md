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

# Serviços de Apoio como Recursos Anexáveis (Backing Services)

**ID**: INFRASTRUCTURE-043
**Severity**: 🔴 Critical
**Category**: Infrastructure

---

## What it is

Serviços de apoio (bancos de dados, filas, caches, serviços de email, APIs externas) devem ser tratados como **recursos anexáveis**, acessados via URL ou localizador de recurso armazenado em configuração. A aplicação não deve distinguir entre serviços locais e de terceiros.

## Why it matters

Tratar serviços como recursos anexáveis permite trocar um banco de dados local por um gerenciado (ex: RDS), ou um serviço de email por outro, sem alteração de código. Isso aumenta a resiliência e flexibilidade de deploy.

## Objective Criteria

- [ ] Todos os serviços externos devem ser acessados via **URL ou string de conexão** configurável por variável de ambiente.
- [ ] O código não deve conter lógica condicional que diferencie serviços locais de remotos (ex: `if (isLocal) useLocalDB()`).
- [ ] A troca de um serviço de apoio deve exigir **apenas** alteração de configuração, não de código.

## Allowed Exceptions

- **Mocks de Teste**: Substituição de serviços por mocks em ambiente de teste unitário, controlada via injeção de dependência.

## How to Detect

### Manual

Verificar se a troca de um serviço (ex: MySQL para PostgreSQL, ou Redis local para ElastiCache) exige alteração de código.

### Automatic

Análise de código: Busca por URLs ou hosts hardcoded, ou por condicionais baseados em ambiente.

## Related to

- [014 - Dependency Inversion Principle (DIP)](014_dependency-inversion-principle.md): reinforces
- [042 - Environment-Based Configuration](042_environment-based-configuration.md): complements
- [049 - Dev/Prod Parity](049_dev-prod-parity.md): reinforces
- [011 - Open/Closed Principle (OCP)](011_open-closed-principle.md): reinforces

---

**Created on**: 2025-01-10
**Version**: 1.0
