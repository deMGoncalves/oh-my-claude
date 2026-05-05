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

# Escalabilidade via Modelo de Processos (Concurrency)

**ID**: INFRASTRUCTURE-047
**Severity**: 🟠 High
**Category**: Infrastructure

---

## What it is

A aplicação deve escalar horizontalmente através da execução de **múltiplos processos** independentes, não através de threads internas ou um único processo monolítico. Diferentes tipos de trabalho (web, worker, scheduler) devem ser separados em tipos de processos distintos.

## Why it matters

O modelo de processos permite escalabilidade elástica — adicionar mais processos web para lidar com tráfego, ou mais workers para processar filas. Cada tipo de processo pode ser escalado independentemente conforme a demanda, otimizando recursos.

## Objective Criteria

- [ ] A aplicação deve suportar execução de **múltiplas instâncias** do mesmo processo sem conflito.
- [ ] Diferentes cargas de trabalho (HTTP, background jobs, scheduled tasks) devem ser separadas em processos distintos.
- [ ] O processo não deve fazer *daemonize* ou escrever PID files — o gerenciamento de processos é responsabilidade do ambiente de execução.

## Allowed Exceptions

- **Workers Internos**: Uso de worker threads para operações CPU-bound dentro de uma requisição, desde que o estado não seja compartilhado entre requisições.

## How to Detect

### Manual

Verificar se a aplicação pode rodar N instâncias simultâneas com um load balancer na frente, sem conflitos.

### Automatic

Testes de carga: Escalar horizontalmente e verificar se throughput aumenta linearmente.

## Related to

- [045 - Stateless Processes](045_stateless-processes.md): complements
- [046 - Port Binding](046_port-binding.md): complements
- [048 - Process Disposability](048_process-disposability.md): reinforces
- [010 - Single Responsibility Principle (SRP)](010_single-responsibility-principle.md): reinforces

---

**Created on**: 2025-01-10
**Version**: 1.0
