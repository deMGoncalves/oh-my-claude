---
applyTo: "**"
---

# Princípio do Reuso Comum (CRP)

**ID**: STRUCTURAL-017
**Severity**: 🟡 Medium
**Category**: Structural

---

## What it is

As classes em um pacote devem ser reutilizadas em conjunto. Se você usa uma, você deve usar todas.

## Why it matters

O CRP ajuda a refinar a granularidade do pacote, garantindo que os clientes não sejam forçados a depender de classes que não usam, o que evita recompilações/redeploy desnecessários e reduz o acoplamento indesejado.

## Objective Criteria

- [ ] O pacote deve ser dividido se houver classes que não são utilizadas por pelo menos **50%** dos clientes que importam o pacote.
- [ ] Se uma classe é usada isoladamente, ela deve ser movida para um pacote de utilidade ou para fora do pacote coeso.
- [ ] Não deve haver mais de **3** classes públicas dentro de um pacote que não são referenciadas externamente.

## Allowed Exceptions

- **Métodos Privados de Suporte**: Classes auxiliares internas que são estritamente usadas para suportar as classes públicas do pacote.

## How to Detect

### Manual

Verificar o diretório de `imports` de um cliente e ver quantas classes do pacote importado ele usa ativamente.

### Automatic

Análise de dependências: Ferramentas que mapeiam a porcentagem de classes consumidas dentro de um pacote.

## Related to

- [015 - Release-Reuse Equivalence Principle (REP)](015_release-reuse-equivalence-principle.md): complements
- [013 - Interface Segregation Principle (ISP)](013_interface-segregation-principle.md): reinforces
- [016 - Common Closure Principle (CCP)](016_common-closure-principle.md): complements
- [056 - Prohibition of Zombie Code (Lava Flow)](056_prohibition-zombie-code-lava-flow.md): reinforces
- [067 - Prohibition of Boat-Anchor Dependency](067_prohibition-boat-anchor-dependency.md): reinforces

---

**Created on**: 2025-10-04
**Version**: 1.0
