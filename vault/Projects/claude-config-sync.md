---
type: project
status: active
repo: slaguru666/claude-config (private)
path: ~/Git/claude-config
updated: 2026-09-13
---

# Claude config sync

**What it is** — The mechanism that keeps every Claude Code installation identical
across Tim's machines: plugins, skills and settings, backed by one private repo.

**Where it lives** — `~/Git/claude-config` → `slaguru666/claude-config`.
`install.sh` sets a machine up; `sync.sh` pushes live state back.

**Current state** — Working. **Since 2026-09-13 it also carries the memory vault** as
`vault/`, synced from `~/Vault/slavault/Ai/Claude/` — that is how MINI-S, which has no
Obsidian vault, reads the memory, and it is the vault's version history. Plugins are declared in `~/.claude/settings.json`
(`enabledPlugins` + `extraKnownMarketplaces`), which the repo tracks. Enabled from
the official marketplace: superpowers, claude-md-management, aws-agents, feature-dev,
huggingface-skills, amazon-location-service. From non-official marketplaces:
`codex@openai-codex`, `warp@claude-code-warp`, `ui-ux-pro-max`, `impeccable`.

**Next steps**
- Confirm whether startup auto-fetches **non-official** marketplaces on MINI-S. If a
  synced non-official plugin is missing there, run the two-step CLI install and
  record the answer.

**Key decisions**
- The plugin **cache** under `~/.claude/plugins/` is deliberately not synced — each
  machine re-fetches from its marketplace based on the declaration.
- The [[rpg-skill]] rides along in this repo.

**Gotchas**
- **Hand-editing `extraKnownMarketplaces` does not fetch the marketplace.** It only
  declares it, and `/reload-plugins` will not pick it up.
- Installing a non-official plugin takes **two** CLI steps — `claude plugin
  marketplace add <owner>/<repo>` then `claude plugin install <plugin>@<marketplace>`
  — and Claude can run both itself.
- **Verify by reading `known_marketplaces.json` and `installed_plugins.json`, never
  by trusting a success banner.** That mistake cost a round trip.
- **Sync ordering:** `git pull && ./install.sh` before working on a machine,
  `./sync.sh` after. `sync.sh` copies with deletes, so the wrong order clobbers
  another machine's memory and skill files.
- **An auto-sync runs on the Mac** and commits as "auto sync" without being asked, so
  config changes propagate on their own — and unrelated edits get swept into the same
  commit. Noticed 2026-09-13.
- `sync.sh` skips anything this machine doesn't have (vault, per-project memory dirs)
  rather than deleting the repo copy. Keep that property when editing it.

Related: [[rpg-skill]], [[mini-s]], [[codex-cli]]
