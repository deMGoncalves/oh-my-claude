# Security Policy

## Supported versions

| Version | Supported |
|---------|-----------|
| 1.x     | ✅ Yes    |
| < 1.0   | ❌ No     |

## Reporting a vulnerability

**Do not open a public issue to report security vulnerabilities.**

If you found a security issue in `oh my claude`, please:

1. **Send an email** to: [security@deMGoncalves.dev](mailto:security@deMGoncalves.dev)
2. **Or use** [GitHub Security Advisories](https://github.com/melisource/fury_oh-my-claude/security/advisories/new) (private)

### What to include in the report

- Description of the problem
- Steps to reproduce
- Potential impact
- Fix suggestion (if you have one)

### Process

1. You will receive confirmation within **48 hours**
2. The issue will be investigated and classified
3. A fix will be developed and tested
4. The vulnerability will be disclosed after patch is published

## Scope

This project is a **Claude Code CLI workflow** with:

- **Shell hooks** (`lint.sh`, `loop.sh`, `prompt.sh`) — local command execution
- **Configured MCPs** (`.mcp.json`) — connections to external services
- **Agents and skills** — prompts injected into Claude context

### Areas of concern

- Command injection in hooks
- Token/secret exposure in `.mcp.json` or in agents
- Arbitrary execution via `PreToolUse`/`PostToolUse` hooks

**Remember:** Never commit real tokens (Figma, GitHub) in `.mcp.json`. Use environment variables.
