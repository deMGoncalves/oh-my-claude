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

# Logs como Fluxo de Eventos (Logs)

**ID**: INFRASTRUCTURE-050
**Severity**: 🔴 Critical
**Category**: Infrastructure

---

## What it is

A aplicação deve tratar logs como um **fluxo contínuo de eventos** ordenados por tempo, escritos em `stdout`. A aplicação nunca deve se preocupar com roteamento, armazenamento, ou rotação de logs — isso é responsabilidade do ambiente de execução.

## Why it matters

Logs em arquivos locais são perdidos quando containers são destruídos, difíceis de agregar em sistemas distribuídos, e criam dependência de filesystem. Stdout permite que o ambiente de execução capture, agregue, e roteie logs para qualquer destino.

## Objective Criteria

- [ ] Todos os logs devem ser escritos em **stdout** (ou stderr para erros), nunca em arquivos locais.
- [ ] É proibido o uso de bibliotecas de logging que escrevem diretamente em arquivos ou fazem rotação de logs.
- [ ] Logs devem ser estruturados (JSON) para facilitar parsing e análise automatizada.

## Allowed Exceptions

- **Ambiente de Desenvolvimento Local**: Formatação colorida e legível para console em dev, desde que stdout seja mantido.
- **Logs de Debug Temporários**: `console.log` para debugging local, removidos antes do commit.

## How to Detect

### Manual

Verificar configuração de bibliotecas de logging para identificar escritas em arquivo ou configuração de rotação.

### Automatic

Análise de código: Busca por `FileAppender`, `RotatingFileHandler`, ou caminhos de arquivo em logging.

## Related to

- [027 - Domain Error Handling Quality](027_domain-error-handling-quality.md): complements
- [045 - Stateless Processes](045_stateless-processes.md): reinforces
- [048 - Process Disposability](048_process-disposability.md): complements
- [026 - Comment Quality: Why, Not What](026_comment-quality-why-not-what.md): complements

---

**Created on**: 2025-01-10
**Version**: 1.0
