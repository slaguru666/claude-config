---
name: loom-app
description: "Loom — local Alkemion-Studio-style adventure-design app for the user's games at ~/loom (board of linked elements, editor, tables, maps, share links, exports); built + 4 rounds of simulated GM/player testing Sept 2026"
metadata: 
  node_type: memory
  type: project
  originSessionId: 81a1afbb-fc23-4ed9-b787-a664647d8b4e
  modified: 2026-09-07T23:48:46.871Z
---

Loom lives at `~/loom` (git, local only — not pushed anywhere as of 2026-09-08). Zero-dependency Node ≥20 server (`npm start`, port 8771) + vanilla ES-module front end, `npm test` (node --test, 27 tests). Dev server config in `~/.claude/launch.json` as `loom` with `LOOM_DATA=~/loom/.devdata`; real data defaults to `~/Loom` (one folder per module: `module.json`, `nodes/<Title>.md` with YAML frontmatter, `tables/*.json`, `assets/`) so it can be synced with Seafile/Nextcloud and opened in Obsidian.

Key design choices: modules are Markdown files on disk, no accounts, no DB; saves carry a folder fingerprint and a 409 triggers a field-level 3-way merge (`app/ui/store.mjs`); share links `/s/<token>` are read-only, strip GM-only elements and `%% GM %%` passages; GM routes only on loopback unless `LOOM_HOST` + `LOOM_GM_KEY`.

Testing method used: persona subagents (GMs Morgan/Priya/Rowan/Dev, players Sam/Kit) drove the app via the Claude Browser tools, wrote reports to `docs/feedback/round-N-*.md`, fixes logged in `round-N-fixes.md`, final summary in `docs/feedback/REPORT.md`. Scores rose 6/6/4/6 (R1) → 8.5/8/8.5/9 (R4); the post-R4 fixes are covered by 27 tests, not a fifth tester round.

**Why:** the user asked for a clone of https://studio.alkemion.com for the games they run, chose "full clone" + "local app + file sync", and asked for autonomous build → simulated test → fix loops.

**How to apply:** when the user mentions Loom, adventure boards, or Alkemion, open `~/loom`; check `docs/feedback/REPORT.md` for the known remaining issues before adding features. Preview server: stop then `preview_start` "loom" after server changes. Related: [[afterimage-scenario]] (AFTERIMAGE was imported as a test module), [[rpg-skill]].
