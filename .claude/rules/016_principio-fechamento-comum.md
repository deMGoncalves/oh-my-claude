# Princípio do Fechamento Comum (CCP)

**ID**: STRUCTURAL-016
**Severity**: 🟠 High
**Category**: Structural

---

## What it is

As classes que mudam juntas pela mesma razão devem ser empacotadas juntas.

## Why it matters

O CCP reforça o SRP no nível de pacote, garantindo que as modificações de software sejam localizadas. Reduz a necessidade de alterar muitos pacotes em uma única alteração de requisito, facilitando a implantação e manutenção.

## Objective Criteria

- [ ] O pacote deve ser revisado se a alteração de um requisito causar modificações em mais de **3** arquivos de classes/módulos não relacionados.
- [ ] Classes relacionadas a uma única entidade de domínio (ex: `Pedido`, `PedidoService`, `PedidoFactory`) devem estar no mesmo pacote.
- [ ] Classes que mudam juntas devem ser localizadas em um mesmo diretório para facilitar a coesão.

## Allowed Exceptions

- **Classes de Infraestrutura Compartilhada**: Classes que são utilizadas em muitos pacotes e vivem em um pacote de utilidades de baixo nível.

## How to Detect

### Manual

Analisar o histórico de commits: verificar se um único *feature request* afetou classes espalhadas por vários pacotes.

### Automatic

Análise de métricas de código: ferramentas que rastreiam arquivos alterados por funcionalidade.

## Related to

- [010 - Single Responsibility Principle (SRP)](010_single-responsibility-principle.md): reinforces
- [015 - Release-Reuse Equivalence Principle (REP)](015_release-reuse-equivalence-principle.md): complements
- [007 - Maximum Lines per Class File](007_max-lines-per-class.md): reinforces
- [017 - Common Reuse Principle (CRP)](017_common-reuse-principle.md): complements
- [058 - Prohibition of Shotgun Surgery](058_prohibition-shotgun-surgery.md): reinforces
- [018 - Acyclic Dependencies Principle (ADP)](018_acyclic-dependencies-principle.md): complements

---

**Created on**: 2025-10-04
**Version**: 1.0
