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

# Exposição de Serviços via Port Binding

**ID**: INFRASTRUCTURE-046
**Severity**: 🟠 High
**Category**: Infrastructure

---

## What it is

A aplicação deve ser **completamente autocontida** e expor seus serviços através de *port binding*. Ela não deve depender de um servidor web externo (Apache, Nginx) injetado em runtime para ser executável — o servidor HTTP deve ser embutido na aplicação.

## Why it matters

Port binding garante que a aplicação seja portável e possa ser executada em qualquer ambiente sem configuração de servidor externo. A aplicação se torna um serviço que pode ser consumido por outras aplicações via URL, criando uma arquitetura de microserviços natural.

## Objective Criteria

- [ ] A aplicação deve iniciar seu próprio servidor HTTP/HTTPS e fazer *bind* em uma porta especificada por variável de ambiente.
- [ ] É proibido depender de configuração de servidor web externo (VirtualHost, .htaccess) para funcionar corretamente.
- [ ] A porta de execução deve ser configurável via `PORT` ou variável equivalente, não hardcoded.

## Allowed Exceptions

- **Reverse Proxy**: Uso de Nginx/HAProxy na frente da aplicação para TLS termination, load balancing, ou roteamento — desde que a aplicação funcione sem ele.
- **Aplicações Frontend SPA**: Aplicações estáticas que são servidas por CDN ou servidor de arquivos estáticos.

## How to Detect

### Manual

Verificar se a aplicação pode ser iniciada e acessada apenas com `npm start` ou `bun run start`, sem configuração adicional de servidor.

### Automatic

CI/CD: Testes que iniciam a aplicação em container limpo e verificam se responde em porta configurada.

## Related to

- [042 - Environment-Based Configuration](042_environment-based-configuration.md): reinforces
- [043 - Backing Services as Resources](043_backing-services-as-resources.md): complements
- [047 - Concurrency via Processes](047_concurrency-via-processes.md): complements
- [048 - Process Disposability](048_process-disposability.md): complements

---

**Created on**: 2025-01-10
**Version**: 1.0
