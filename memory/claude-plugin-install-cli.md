---
name: claude-plugin-install-cli
description: Install Claude Code plugins non-interactively with the claude CLI instead of hand-editing settings.json.
metadata:
  type: feedback
---

Add and enable plugins with the CLI, not by editing `~/.claude/settings.json` by hand:

```
claude plugin marketplace add <owner>/<repo>
claude plugin install <plugin>@<marketplace-name> --scope user -y
```

**Why:** the CLI writes all three places that must stay in sync — `settings.json` (`enabledPlugins` + `extraKnownMarketplaces`), `plugins/known_marketplaces.json`, and `plugins/installed_plugins.json` (with the resolved version and git SHA) — and clones the plugin into `plugins/cache/`. Hand-editing settings.json sets the flag but leaves the plugin uninstalled and the manifests stale.

**How to apply:** the `<marketplace-name>` is the `name` field inside the repo's `.claude-plugin/marketplace.json`, which often differs from the repo name (e.g. `anthropics/claude-plugins-community` → `claude-community`). Read it, or take it from the `Successfully added marketplace: <name>` line. `-y` is required when stdout is not a TTY.

Related: [[quickdesign-plugin]]
