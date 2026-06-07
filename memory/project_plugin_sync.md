---
name: project-plugin-sync
description: "Claude Code plugins must stay synced across all servers via the claude-config repo (settings.json enabledPlugins)"
metadata: 
  node_type: memory
  type: project
  originSessionId: e24d82e5-1bd0-48dc-99e6-9a4a434f0d2d
---

All of the user's Claude Code installations (multiple servers) must run the same set of plugins.
The user explicitly wants newly installed plugins propagated to every machine.

**Currently enabled plugins** (in `~/.claude/settings.json` → `enabledPlugins`):
- From `claude-plugins-official` (`anthropics/claude-plugins-official`, auto-installs on every machine):
  carta-investors, superpowers, github, claude-md-management, aws-agents, feature-dev, huggingface-skills
- Pre-existing: `codex@openai-codex` (marketplace `openai/codex-plugin-cc`), `warp@claude-code-warp`
  (marketplace `warpdotdev/claude-code-warp`). Both marketplaces are in `extraKnownMarketplaces`.

**Why:** Plugins are declared in `settings.json` (`enabledPlugins` + `extraKnownMarketplaces`), which the
[[user-github]] `claude-config` repo already tracks. The installed plugin *cache* under `~/.claude/plugins/`
is NOT synced and should not be — each server re-fetches plugins from its marketplace based on the declaration.

**How to apply:** After installing/removing any plugin, run `~/Git/claude-config/sync.sh` to push the updated
`settings.json` to GitHub. On another server, `git pull && ./install.sh`, then start Claude Code — it auto-installs
the enabled plugins from `claude-plugins-official`. Rule: any plugin from a *non-official* marketplace
must have that marketplace added to `extraKnownMarketplaces` in `settings.json`, or it won't install on other
servers. Both non-official marketplaces in use (`openai-codex` → `openai/codex-plugin-cc`, `claude-code-warp` →
`warpdotdev/claude-code-warp`) are now registered there.
