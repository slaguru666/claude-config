---
name: claude-config-sync-gotchas
description: Third machine (MacBook Air) in the claude-config fleet; settings.json overwrites rather than merges; GitHub MCP token is zsh-invisible on Macs
metadata: 
  node_type: memory
  type: project
  originSessionId: c4d6262b-e105-4e05-87bf-f2f891e7df82
  modified: 2026-08-04T20:53:52.376Z
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

2. **GitHub MCP: the remote server works, but Claude Code's own OAuth flow cannot.**
   Two separate faults, both fixed 2026-08-04. First, the old `install.sh` only registered the
   server when `GITHUB_PERSONAL_ACCESS_TOKEN` was set, and commit `f5a7a70` put that token in
   `.bashrc` while the Macs run zsh — invisible, so the step silently skipped every time. The
   npm package it used (`@modelcontextprotocol/server-github`) is deprecated anyway ("Package
   no longer supported", last published 2025.4.8).

   Second — and this is the non-obvious one — **plain `claude mcp add --transport http` against
   `https://api.githubcopilot.com/mcp/` cannot authenticate.** `/mcp` fails with
   *"Incompatible auth server: does not support dynamic client registration"*. GitHub's
   authorization server metadata (`issuer: https://github.com/login/oauth`, fetched from
   `https://github.com/.well-known/oauth-authorization-server/login/oauth`) publishes **no
   `registration_endpoint`**, so RFC 7591 DCR is unavailable and Claude Code cannot self-register.

   `install.sh` therefore supports two working routes, OAuth app taking precedence:
   `GITHUB_MCP_CLIENT_ID` + `MCP_CLIENT_SECRET` (pre-registered GitHub OAuth App, uses
   `--client-id`/`--client-secret`), else `GITHUB_MCP_TOKEN` (or the legacy
   `GITHUB_PERSONAL_ACCESS_TOKEN`) passed as `--header "Authorization: Bearer <token>"`.
   The PAT lands in plaintext in `~/.claude.json`. With neither set the step skips loudly.
   (`gh` CLI is separately authenticated as `slaguru666` and remains a fine fallback.)

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
