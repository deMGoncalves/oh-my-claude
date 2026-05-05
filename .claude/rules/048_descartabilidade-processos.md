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

# Descartabilidade de Processos (Disposability)

**ID**: INFRASTRUCTURE-048
**Severity**: 🔴 Critical
**Category**: Infrastructure

---

## What it is

Os processos da aplicação devem ser **descartáveis** — podem ser iniciados ou parados a qualquer momento. Isso requer startup rápido, shutdown graceful, e robustez contra terminação súbita (SIGTERM/SIGKILL).

## Why it matters

Descartabilidade permite deploys rápidos, escalabilidade elástica, e recuperação rápida de falhas. Processos que demoram para iniciar ou não tratam shutdown corretamente causam downtime, perda de dados, e degradação de serviço.

## Objective Criteria

- [ ] O tempo de **startup** do processo deve ser inferior a **10 segundos** para estar pronto para receber requisições.
- [ ] O processo deve tratar **SIGTERM** e finalizar requisições em andamento graciosamente antes de encerrar.
- [ ] Jobs de background devem ser **idempotentes** e usar padrões de retry, pois podem ser interrompidos a qualquer momento.

## Allowed Exceptions

- **Processos de Warm-up**: Processos que precisam carregar modelos ML ou caches grandes podem ter startup mais lento, desde que health checks reflitam o estado real.

## How to Detect

### Manual

Medir tempo de startup e enviar SIGTERM durante processamento para verificar se finaliza graciosamente.

### Automatic

Kubernetes: Configurar `terminationGracePeriodSeconds` e `readinessProbe` para validar comportamento.

## Related to

- [045 - Stateless Processes](045_stateless-processes.md): reinforces
- [046 - Port Binding](046_port-binding.md): complements
- [047 - Concurrency via Processes](047_concurrency-via-processes.md): reinforces
- [028 - Async Exception Handling](028_async-exception-handling.md): reinforces

---

**Created on**: 2025-01-10
**Version**: 1.0
