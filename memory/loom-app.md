---
name: loom-app
description: "Loom — local Alkemion-Studio-style adventure-design app for the user's games at ~/loom (board of linked elements, editor, generators, map generator, Makers, scenario builders, procedural art, share links, remote access); built + 5 rounds of simulated GM/player testing + a builders/art round, Sept 2026"
metadata: 
  node_type: memory
  type: project
  originSessionId: 81a1afbb-fc23-4ed9-b787-a664647d8b4e
  modified: 2026-09-08T14:12:19.887Z
---

Loom lives at `~/loom` (git, local only — not pushed anywhere as of 2026-09-08). Zero-dependency Node ≥20 server (`npm start`, port 8771) + vanilla ES-module front end, no build step, `npm test` (node --test, 199 tests). Dev server config is `~/loom/.claude/launch.json` as `loom`, which sets `LOOM_DATA=$PWD/.devdata`; real adventures default to `~/Documents/Loom` — deliberately **not** `~/Loom`, because macOS treats `Loom` and `loom` as the same folder and the app would write into its own source.

Each adventure is a folder: `module.json`, `nodes/<Title>.md` (YAML frontmatter), `tables/*.json`, `assets/`, so it syncs with Seafile/Nextcloud and opens in Obsidian.

**Remote access** (`server/auth.mjs`, replaces the old `LOOM_GM_KEY` — that flag no longer exists). **Deployed 2026-09-08 to https://loom.oneoffgames.com** on the Contabo VPS ([[infra-oneoffgames-vps]]): code `/opt/loom` (rsync from the Mac, `--delete`, excluding `.devdata/`), data `/var/lib/loom`, `loom.service` running as a `loom` system user bound to 127.0.0.1:8771 behind nginx + certbot. Secrets live in root-only `/etc/loom.env` (600) via `EnvironmentFile` — never in the repo. Verified in production: `Secure` appears on the session cookie over HTTPS and is absent on plain HTTP, so `LOOM_TRUST_PROXY=1` and the last-value `X-Forwarded-Proto` rule are doing what they were written to do. Data is backed up hourly by `loom-backup.timer` → `/usr/local/bin/loom-backup`, which commits `/var/lib/loom` and pushes to **`git@gitea.timevans.uk:tevans/loom-data.git`** (SSH alias `gitea-loomdata`, port 2222). The server is the working copy and Gitea is history — one direction only, so a restore is a deliberate checkout. Two gotchas that cost a round of debugging: **ssh resolves `~` from the passwd database, not `$HOME`**, so the `loom` account's home had to be moved to `/var/lib/loom-home` (the key must never sit inside the backed-up tree); and **Gitea scopes a deploy key to one repo and refuses duplicate key content**, so a second repo needs a freshly generated key, not the same one. `LOOM_PASSPHRASE` + `LOOM_HOST`; the passphrase is POSTed from a login page, never a URL, and the browser keeps a signed dated session. **A passphrase that is set is demanded whatever the bind address** — the bind cannot decide, because the documented deployment is a reverse proxy in front of a loopback socket and reading the bind meant every proxied visitor was the GM. `LOOM_SECRET` (≥16 chars) survives restarts; `LOOM_TRUST_PROXY=1` believes the *last* `X-Forwarded-Proto` value. Share links still need no login.

**Generators** (`app/core/generators.mjs`) are the non-obvious part. A row tag written `key:value` is a *facet* — a fact the row asserts — and within one result the engine refuses to draw a row whose facet contradicts one already drawn. Slot syntax: `{{who@Table ~agreesWith !differsFrom #tag|modifier}}`. `opts.facets` seeds facts from outside so a plain table can be filtered by what a scenario already settled. Agreement ADDS to settled facets rather than replacing them, and `rerollSlot` restores `result.settled` — both were bugs that silently broke the chosen setting in ~25% and ~50% of rolls.

**Scenario builders** (`app/core/builders/`): `kit.mjs` is the spine — truth (F1–F5) → dated clock with observable signs → clues derived backwards as evidence of a beat → cast → endings, plus `check(plan)` enforcing invariants and `toElements()` laying out six bands. Three recipes: `gothic.mjs`, `twenties.mjs` (1920s CoC), `space.mjs`. `check()` codes that matter: **`no-clue-route`** (a fact only on people and prizes) and **`one-clue-route`** — counting the villain and the endgame prize as carriers is what let unrunnable scenarios pass.

**Art** (`app/core/artgen/`, `app/core/artprompt.mjs`, `app/ui/artview.mjs`): three routes in one panel — seeded procedural SVG in six styles (deterministic, offline, no opacity, palette-disciplined so contrast is real), a prompt for any third-party service, and the user's own Midjourney bridge behind `LOOM_MJ` (off by default; `/Users/timevans/bin/mj-gen`). A prompt strips GM asides, dice, and **bare `[[wikilink]]` targets** — a target is another element's title and may name something players have never heard of.

**Map generator** (`app/core/mapgen*`) is a port of the user's own Mapwright Foundry module (`slaguru666/mapwright`).

Known gap, deliberately unfixed: a starter pack added before facets existed keeps its untagged rows, and re-adding the pack skips every table name you already have. Rename the old tables and re-add to fix.

Testing method that works: persona subagents drive the app (browser tools, the HTTP API, and core modules imported directly into node) and report; **then verify every claim yourself before acting** — agents report faults that do not reproduce, and miss ones visible only in the running app. Give each tester ONE question (round-5 shape) rather than one shared journey. Codex (`codex exec --skip-git-repo-check "<prompt>" < /dev/null` — it blocks on stdin otherwise) found the auth bypass and both generator bugs. Reports in `docs/feedback/`.

Sweeps must vary the seed SHAPE, not just the seed: gothic passed cleanly under `gothic-0-…` while a third of `x0`…`x7` failed.

Design canvas (Claude Design artifact): https://claude.ai/code/artifact/96718cad-6f3f-4379-b68a-563cefcbde85

**Why:** the user asked for a clone of https://studio.alkemion.com for the games they run, chose "full clone" + "local app + file sync", and asked for autonomous build → simulated test → fix loops. For art they chose procedural SVG + their Midjourney bridge + prompts only (no image API); for remote access, "just me, from anywhere" — auth and HTTPS, no accounts, no multi-user.

**How to apply:** when the user mentions Loom, adventure boards, or Alkemion, open `~/loom`; read `docs/feedback/REPORT.md` for what is known-broken before adding features. Preview with `preview_start` "loom" (never `npm start` from a Bash call — the server dies with the shell). Related: [[afterimage-scenario]] (imported as a test adventure), [[rpg-skill]], [[mapwright-module]], [[midjourney_bridge]].
