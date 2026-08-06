---
name: codex-ops-kit-installer-bugs
description: "codex-ops-kit's install script destroyed Codex's own config state and misfiled root keys under a table; both fixed 2026-08-04, plus the profile format migration"
metadata: 
  node_type: memory
  type: project
  originSessionId: c4d6262b-e105-4e05-87bf-f2f891e7df82
  modified: 2026-08-04T22:08:23.936Z
---

`~/codex-ops-kit/scripts/install_codex_kit.sh` merges a managed block into
`~/.codex/config.toml`. On 2026-08-04 it had **three** faults, all fixed. Re-read this before
touching that script — the failure mode is silent data loss.

1. **It deleted everything after the managed block.** The merge did
   `before = text.split(managed_start, 1)[0]` and wrote `before + block`, discarding all content
   below the block. That is exactly where Codex writes its own `[plugins.*]`, `[projects.*]`,
   `[marketplaces.*]` and `[mcp_servers.*]` state. A single reinstall took the live config from
   142 lines / 32 sections to 37 / 2. Fixed: keep `head`, `interior` and `tail`.

2. **The block's interior had swallowed real state.** Over past runs the `managed_end` marker
   drifted to line 88, so plugins/projects/marketplaces/`mcp_servers.graphiti` sat *inside* the
   block. Dropping the interior wholesale therefore also deleted them. Fixed: the interior is
   **filtered** (strip only keys/sections the kit owns), never discarded — which makes the layout
   self-heal on the next run.

3. **Root keys were being filed under a table.** The block was appended at the end, so its bare
   keys (`model`, `profile`, `web_search`, …) landed below `[sandbox_workspace_write]` and TOML
   bound them to *that table*. `profile = "balanced"` was therefore never a root selector at all.
   Fixed: write `preserved_root`, then the block, then `preserved_tables`, so bare keys always
   precede the first `[table]`.

**Profile format migration (the reason this surfaced).** Codex ≥ 0.146 refuses
`--profile <name>` while `config.toml` holds a legacy `profile = "..."` selector or
`[profiles.<name>]` tables. Profiles now live in `~/.codex/<name>.config.toml`. The kit gained
`templates/global/profiles/{economy,balanced,deep}.config.toml`, the installer copies them, and
`profile`/`profiles.*` stay in the merge's managed lists **purely so old installs get cleaned
up**. Live values preserved: economy `gpt-5.4-mini`/low, balanced `gpt-5.5`/medium, deep
`gpt-5.4`/high — note **deep's model is weaker than balanced's**, which looks like stale config
worth revisiting.

**Also:** `config.toml` has three writers — Codex itself, **Clairvoyance** ("do not edit the
[clairvoyance] section manually"), and this kit. That is why duplicate `model` keys appeared.
Root model is now `gpt-5.6-sol`, set once.

**Two separate faults blocked Codex entirely that day:** the profile format above, *and* CLI
0.142.3 being too old for its configured model (`400: The 'gpt-5.6-sol' model requires a newer
version of Codex`). `npm install -g @openai/codex` → 0.146.0 fixed the second.

**Why:** CLAUDE.md says to edit kit templates rather than live files, which is right — but the
installer applying them was itself destructive, so "just re-run install.sh" was unsafe advice.

**How to apply:** always diff `~/.codex/config.toml` section counts before and after running the
installer. Its own backups land in `~/.codex/backups/<stamp>/`. Related:
[[claude-config-sync-gotchas]].
