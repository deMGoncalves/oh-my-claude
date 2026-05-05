---
applyTo: "**"
---

# Equivalência de Lançamento e Reuso de Pacotes (REP)

**ID**: STRUCTURAL-015
**Severity**: 🟠 High
**Category**: Structural

---

## What it is

O módulo/pacote que se destina ao reuso deve ter o mesmo escopo de lançamento (release) que o seu consumidor. A granularidade do reuso é a granularidade do lançamento.

## Why it matters

Violações do REP levam a pacotes que são difíceis de versionar e consumir, forçando clientes a aceitar módulos que não usam, ou a esperar por releases desnecessárias para obter uma correção.

## Objective Criteria

- [ ] O pacote reutilizável deve ser minimamente coeso (SRP aplicado a nível de pacote).
- [ ] Todos os itens do pacote reutilizável devem ser lançados sob a mesma versão (sem *sub-versionamento*).
- [ ] A pasta/pacote deve ter um único objetivo de reuso (ex: *Logging*, *Validation*, *DomainPrimitives*).

## Allowed Exceptions

- **Monorepos com Workspaces**: Ambientes onde o gerenciamento de dependências é estritamente controlado para que a versão seja sempre sincronizada.

## How to Detect

### Manual

Verificar se o pacote contém classes que não são utilizadas em conjunto pelos clientes.

### Automatic

Análise de dependências: `dependency-analysis` para identificar classes sem uso.

## Related to

- [016 - Common Closure Principle (CCP)](016_common-closure-principle.md): complements
- [010 - Single Responsibility Principle (SRP)](010_single-responsibility-principle.md): reinforces
- [014 - Dependency Inversion Principle (DIP)](014_dependency-inversion-principle.md): reinforces
- [017 - Common Reuse Principle (CRP)](017_common-reuse-principle.md): complements
- [040 - Single Codebase](040_single-codebase.md): complements

---

**Created on**: 2025-10-04
**Version**: 1.0
