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

**Currently enabled plugins** (in `~/.claude/settings.json` → `enabledPlugins`), as of 2026-07-16:
- From `claude-plugins-official` (`anthropics/claude-plugins-official`, auto-installs on every machine):
  superpowers, claude-md-management, aws-agents, feature-dev, huggingface-skills, amazon-location-service
  (carta-investors and github were previously listed here but are no longer enabled)
- From non-official marketplaces (each registered in `extraKnownMarketplaces`):
  `codex@openai-codex` (`openai/codex-plugin-cc`), `warp@claude-code-warp` (`warpdotdev/claude-code-warp`),
  `ui-ux-pro-max@ui-ux-pro-max-skill` (`nextlevelbuilder/ui-ux-pro-max-skill`),
  `impeccable@impeccable` (`pbakaus/impeccable`)

**Why:** Plugins are declared in `settings.json` (`enabledPlugins` + `extraKnownMarketplaces`), which the
[[user-github]] `claude-config` repo already tracks. The installed plugin *cache* under `~/.claude/plugins/`
is NOT synced and should not be — each server re-fetches plugins from its marketplace based on the declaration.

**How to apply:** After installing/removing any plugin, run `~/Git/claude-config/sync.sh` to push the updated
`settings.json` to GitHub. On another server, `git pull && ./install.sh`, then start Claude Code — it auto-installs
the enabled plugins from `claude-plugins-official`. UNVERIFIED as of 2026-07-16: whether startup also auto-fetches
*non-official* marketplaces from `extraKnownMarketplaces`. If a synced non-official plugin is missing on MINI-S,
run the two-step CLI install below there, then note the answer here. CLI dependency: the `codex@openai-codex` plugin shells out to the Codex CLI (`@openai/codex`, binary `codex`).
`install.sh` installs it via `npm install -g @openai/codex` when missing, so it propagates to every server that
runs the installer (requires npm on the target machine).

**Gotcha — hand-editing `extraKnownMarketplaces` does NOT fetch the marketplace.** Adding a marketplace +
`enabledPlugins` entry by hand only *declares* it. `/reload-plugins` will NOT pick it up: that command reloads
already-known marketplaces, so the plugin/skill counts come back unchanged and `~/.claude/plugins/known_marketplaces.json`
still omits the new entry.

**Installing a non-official plugin takes TWO steps, and Claude can do both itself via the CLI** (no need to ask the
user to run slash commands — `claude plugin --help` mirrors `/plugin`):
```
claude plugin marketplace add <owner>/<repo>      # clones + registers the marketplace
claude plugin install <plugin>@<marketplace>      # actually installs it
```
Step 1 alone leaves `installed_plugins.json` untouched — registering a marketplace does NOT install the plugins
already declared in `enabledPlugins`. Neither step rewrites `settings.json`, so a prior hand-edit + sync stays valid.

**Verify by reading files, never by trusting a success banner** — that mistake cost a round trip on 2026-07-16.
Check `~/.claude/plugins/known_marketplaces.json` (marketplace registered) and `installed_plugins.json` (plugin +
version + installPath present). Absence of an error is not evidence of an install.

Rule: any plugin from a *non-official* marketplace
must have that marketplace added to `extraKnownMarketplaces` in `settings.json`, or it won't install on other
servers. Both non-official marketplaces in use (`openai-codex` → `openai/codex-plugin-cc`, `claude-code-warp` →
`warpdotdev/claude-code-warp`) are now registered there.
