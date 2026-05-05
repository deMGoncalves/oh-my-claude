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

# Processos Stateless (Processes)

**ID**: INFRASTRUCTURE-045
**Severity**: 🔴 Critical
**Category**: Infrastructure

---

## What it is

Os processos da aplicação devem ser **stateless** (sem estado) e **share-nothing**. Qualquer dado que precise persistir deve ser armazenado em um serviço de apoio com estado (banco de dados, cache distribuído, object storage).

## Why it matters

Processos stateless podem ser escalados horizontalmente sem complexidade, reiniciados a qualquer momento sem perda de dados, e distribuídos entre múltiplos servidores. Estado em memória ou filesystem local impede escalabilidade e causa perda de dados.

## Objective Criteria

- [ ] É proibido armazenar estado de sessão em memória local — sessões devem usar stores externos (Redis, banco de dados).
- [ ] É proibido assumir que arquivos escritos no filesystem local estarão disponíveis em requisições futuras.
- [ ] O processo deve ser capaz de reiniciar a qualquer momento sem perda de dados do usuário (*crash-only design*).

## Allowed Exceptions

- **Cache em Memória Efêmero**: Cache local de curta duração para otimização, desde que a aplicação funcione corretamente sem ele.
- **Arquivos Temporários**: Uso de `/tmp` para operações de curta duração dentro de uma única requisição.

## How to Detect

### Manual

Verificar se a aplicação falha ou perde dados quando um processo é reiniciado durante uma operação.

### Automatic

Testes de caos: Reiniciar processos aleatoriamente e verificar se a aplicação mantém consistência.

## Related to

- [029 - Object Immutability (freeze)](029_object-immutability-freeze.md): complements
- [036 - Side-Effect Function Restrictions](036_side-effect-restrictions.md): reinforces
- [043 - Backing Services as Resources](043_backing-services-as-resources.md): reinforces
- [047 - Concurrency via Processes](047_concurrency-via-processes.md): complements
- [048 - Process Disposability](048_process-disposability.md): reinforces
- [070 - Prohibition of Shared Mutable State](070_prohibition-shared-mutable-state.md): reinforces

---

**Created on**: 2025-01-10
**Version**: 1.0
