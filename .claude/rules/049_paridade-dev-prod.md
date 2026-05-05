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

# Paridade entre Desenvolvimento e Produção (Dev/Prod Parity)

**ID**: INFRASTRUCTURE-049
**Severity**: 🔴 Critical
**Category**: Infrastructure

---

## What it is

Os ambientes de desenvolvimento, staging e produção devem ser o mais **similares possível**. Isso inclui minimizar gaps de tempo (deploy frequente), gaps de pessoal (quem desenvolve também faz deploy), e gaps de ferramentas (mesmas tecnologias em todos os ambientes).

## Why it matters

Divergências entre ambientes causam bugs que só aparecem em produção, tornando debugging difícil e deploys arriscados. A paridade permite que desenvolvedores confiem que o que funciona localmente funcionará em produção.

## Objective Criteria

- [ ] Os mesmos **serviços de apoio** (banco de dados, cache, fila) devem ser usados em dev e prod — é proibido usar SQLite em dev e PostgreSQL em prod.
- [ ] O tempo entre escrever código e fazer deploy em produção deve ser inferior a **1 dia** (idealmente horas).
- [ ] Containers ou configurações de ambiente devem ser **idênticos** entre dev e prod (ex: mesmo Dockerfile).

## Allowed Exceptions

- **Escala de Recursos**: Diferenças de escala (menos réplicas, menor CPU/memória) são aceitáveis desde que a arquitetura seja idêntica.
- **Dados de Teste**: Uso de dados sintéticos ou anonimizados em dev é obrigatório por razões de segurança.

## How to Detect

### Manual

Comparar stack tecnológica e versões de serviços entre ambientes. Verificar se bugs reportados em prod são reproduzíveis em dev.

### Automatic

Infrastructure as Code: Comparar manifests (Terraform, Docker Compose) entre ambientes para detectar divergências.

## Related to

- [042 - Environment-Based Configuration](042_environment-based-configuration.md): reinforces
- [043 - Backing Services as Resources](043_backing-services-as-resources.md): reinforces
- [044 - Build-Release-Run Separation](044_build-release-run-separation.md): reinforces
- [032 - Minimum Test Coverage Quality](032_minimum-test-coverage-quality.md): complements

---

**Created on**: 2025-01-10
**Version**: 1.0
