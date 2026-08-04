---
name: claude-config-sync-gotchas
description: Third machine (MacBook Air) in the claude-config fleet; settings.json overwrites rather than merges; GitHub MCP token is zsh-invisible on Macs
metadata: 
  node_type: memory
  type: project
  originSessionId: c4d6262b-e105-4e05-87bf-f2f891e7df82
  modified: 2026-08-04T20:44:19.499Z
---

The `claude-config` repo (`slaguru666/claude-config`) syncs Claude config across a fleet that
is **three** machines, not the two listed in the global CLAUDE.md: `timevans-MINI-S` (Linux),
a Mac Mini, and **`Tims-MacBook-Air.local`** — plus a `tim-ThinkPad-X1-Nano` that appears in
commit `30d3c95`. Check `hostname` before assuming which box you are on.

Three traps, all confirmed on 2026-08-04:

1. **`settings.json` is copied wholesale, never merged.** `install.sh` does a plain `cp` of the
   repo copy over `~/.claude/settings.json`. On the MacBook Air the live file was *ahead* of the
   repo and a straight install would have silently dropped 62 allow rules and 13 deny rules
   (`Bash(rm -rf )`, `Bash(sudo )`, `Read(**/.env)`, `Read(**/*.pem)`). Always diff live vs repo
   *and* vs incoming `origin/main` before running `install.sh`; hand-merge the union. The repo's
   own history does this repeatedly (`30d3c95`, `ad3c645`).

2. **GitHub MCP used to never install on the Macs — fixed 2026-08-04.** The old `install.sh`
   only registered it when `GITHUB_PERSONAL_ACCESS_TOKEN` was set, and commit `f5a7a70` put
   that token in `.bashrc` while the Macs run zsh, so it was invisible and the step silently
   skipped every time. The npm package it installed (`@modelcontextprotocol/server-github`)
   is also deprecated — "Package no longer supported", last published 2025.4.8. **Do not add
   a PAT to fix this.** `install.sh` now registers GitHub's official remote server over HTTP
   at `https://api.githubcopilot.com/mcp/`, which uses OAuth and needs no PAT; authorise once
   per machine with `/mcp` in an *interactive* `claude` session. Until authorised,
   `claude mcp list` reports it as "Failed to connect", not "Needs authentication" — that is
   the normal unauthenticated state, not a fault. (`gh` CLI is separately authenticated as
   `slaguru666` and remains a fine fallback.)

3. **`install.sh` overwrites live memory with the repo copy.** Same `cp`-wins hazard as
   `settings.json`: any memory file written since the last `sync.sh` is reverted by the next
   `install.sh`. Observed on 2026-08-04 — `MEMORY.md` lost two pointer lines that way. New
   *files* survive (cp does not delete extras), but edits to files the repo also has are lost.
   Run `sync.sh` before `install.sh` on a machine that has written memory recently.

4. **Skills in `~/.claude/skills/` are a mix of real dirs and symlinks.** firecrawl/composio
   skills symlink into `~/.agents/skills/`; only `rpg` is a real directory. `sync.sh` now passes
   `--no-links` so it does not commit symlinks that dangle on every other machine. Related
   earlier breakage: `ba6afb6`, where `--delete` wiped `skills/rpg` from a machine lacking it.

**Why:** each of these fails silently — no error, just quietly lost config or a capability that
is documented but absent.

**How to apply:** before `bash install.sh` on any machine, diff `settings.json` three ways
(live / repo HEAD / `origin/main`) and merge as a union rather than letting the copy win.

Also note `install.sh` hardcodes the Obsidian vault to `/home/timevans/...`, a Linux path, so
that step can never fire on either Mac. Unfixed as of 2026-08-04.
