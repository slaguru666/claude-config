---
name: loom-app
description: "Loom — local Alkemion-Studio-style adventure-design app for the user's games at ~/loom (board of linked elements, editor, generators, map generator, Makers for 7 game systems, 5 scenario builders, procedural art, share links, remote access); deployed to loom.oneoffgames.com"
metadata: 
  node_type: memory
  type: project
  originSessionId: 81a1afbb-fc23-4ed9-b787-a664647d8b4e
  modified: 2026-09-09T20:10:00.000Z
---

Loom lives at `~/loom` (git, branch `main`). **It now has a remote: `slaguru666/loom` on gitea.timevans.uk, private, pushed 9 Sep 2026.** Older notes said there was no remote and history could be rewritten freely — that is no longer true. `.devdata/` is gitignored, so no adventure data or secrets are published. Zero-dependency Node ≥20 server (`npm start`, port 8771) + vanilla ES-module front end, no build step, `npm test` (node --test). Dev server config is `~/loom/.claude/launch.json` as `loom`, which sets `LOOM_DATA=$PWD/.devdata`; real adventures default to `~/Documents/Loom` — deliberately **not** `~/Loom`, because macOS treats `Loom` and `loom` as the same folder and the app would write into its own source.

Each adventure is a folder: `module.json`, `nodes/<Title>.md` (YAML frontmatter), `tables/*.json`, `assets/`, so it syncs with Seafile/Nextcloud and opens in Obsidian. Client routes: the board is `/module.html?id=<id>`, **not** `/m/<id>`.

**Remote access** (`server/auth.mjs`). **Deployed to https://loom.oneoffgames.com** on the Contabo VPS ([[infra-oneoffgames-vps]]): code `/opt/loom` (rsync from the Mac, `--delete`, excluding `.devdata/` and `.DS_Store`), data `/var/lib/loom`, `loom.service` as a `loom` system user on 127.0.0.1:8771 behind nginx + certbot. Secrets in root-only `/etc/loom.env` (600) via `EnvironmentFile`. Backed up hourly by `loom-backup.timer` → `git@gitea.timevans.uk:tevans/loom-data.git` (SSH alias `gitea-loomdata`, port 2222); server is the working copy, Gitea is history, one direction only. Two gotchas that cost a debugging round: **ssh resolves `~` from the passwd database, not `$HOME`** (the `loom` account's home had to move to `/var/lib/loom-home`), and **Gitea scopes a deploy key to one repo and refuses duplicate key content**, so a second repo needs a freshly generated key. Static serving is confined to `<repo>/app`, so syncing `.git` to the box exposes nothing.

**Getting a board onto the LIVE Loom.** The passphrase gate has no unauthenticated route — not even on loopback — so `/api/import` is unreachable without a session cookie, and entering the passphrase is not something to do on the user's behalf. The way in is the storage layer: build the module locally with `markdownToModule` + `createStorage(stageDir).write(mod)`, then
`rsync -rz --no-perms --no-owner --no-group --omit-dir-times stage/ foundry:/var/lib/loom/` and
`chown -R loom:loom` the new folders. **Never plain `-a` there** — as root it pushes your local uid onto `/var/lib/loom` itself. Omit `--delete` so existing boards survive. Verify with `sudo -u loom node` against `/opt/loom/server/storage.mjs`, which proves the server's own code reads them.

**A long-running Loom holds the importer it booted with** (Node caches modules), so after changing `app/core/import.mjs` the dev server must be restarted or imports silently use the old rules — this cost a round of wrong boards. `tools/import-docs.mjs` now reports the counts the server returned and warns when they differ from the local build.

## The generator engine — the non-obvious part

`app/core/generators.mjs`. A row tag `key:value` is a *facet*: a fact the row asserts. Within one result the engine refuses a row whose facet contradicts one already drawn. A control seeds its value as a facet automatically (`facet: c.facet !== false`).

Four facts that are easy to get wrong and cost most of a session:

- **`{{x@Table #$ctl}}` is a tag FILTER, not a hint.** It REQUIRES the tag, so every untagged row in that table becomes undrawable — while the control's own facet was already doing the constraining. This exact bug was written five times in four packs and nothing caught it, because the generator still returns text, just from a fraction of the table. `test/makers.test.mjs` now guards it. Two exceptions where the filter IS load-bearing and must stay: a control declared `facet: false`, and a table tagged with **bare** values (`'low'`) rather than facets (`'tech:low'`) — the BRP pack does the latter throughout.
- **`facetsOf` builds a Map, so a row cannot assert two values of one key.** `mind:crewed` plus `mind:beast` silently keeps only the last. A row that suits both must stay untagged, be written twice, or use a second key. This shapes every coherence fix.
- **An untagged row is eligible everywhere**, which is the cause of essentially every content bug found: a firearm history on a road flare, an open-water line on a canal ferry, a negotiating solution to a cargo fire.
- **A seed only means something under an engine version.** `ENGINE` in `generators.mjs` rides on every result and is written into element provenance beside the seed (`· seed \`x\` · engine 2`). Bump it ONLY when a change would make an existing seed replay a different line; a fix to reroll, hold or seed-reporting is not that. Prove it either way with a snapshot diff of a few thousand outputs before and after — the `ENGINE = 2` change itself was byte-identical across 10,002 lines. The panel copies named fields onto its own result rows, so a new field on the result must be added in `makersview.mjs` too or it never reaches the note.
- **When nothing agrees the engine falls back and warns `no-agreement`** rather than failing — so over-constraining is detectable, and every sweep should count warnings.

**Measure empirically; do not model eligibility from tags.** Modelling gave the wrong answer four separate times (bare-tag packs read as 100% unreachable; a full place name compared against prose that names only the room; a regex that caught the prose after a damage code; `at sea` matching inside "th*at sea*ts eight"). Roll the generator and count what actually comes out.

Signatures worth remembering: `G.generate(gen, tables, { params, seed, avoid, facets })` — not `(seed, tables, name, opts)`. `toElements(plan)` returns `{nodes, edges}`, not an array.

## Makers

`app/core/makers/` — seven packs (brp, fantasy, cthulhu, shadowdark, traveller, deltagreen, scifihorror), ~7,200 rows. Six subjects ship: person, threat, payoff, ship, vehicle, weapon; **`place` is registered but only some packs make one** — `subjectsOf` derives what a pack offers from the generators it has, so a pack never advertises what it cannot make. A ship lands as a `location`, vehicle/weapon/payoff as `item`, threat as an `npc` carrying a tag. Elements arrive `visibility: 'gm'` and tagged with subject, pack and a batch id.

**One seed shares a world across a whole pack.** Roll every Traveller generator on the same seed and the contact, patron, trouble, payoff and ship all land on the same world; sci-fi horror does it with its station. A player tester found this and a GM tester, reviewing the same packs, reported the opposite — that every maker is an island. The player was right.

Two originality tests: no two packs share a row word for word, **and** no cross-pack pair scores ≥0.70 on the overlap of words longer than three characters. The second exists because the first is a test you can pass by changing a word — an earlier dedup round produced 51 near-identical pairs, seven with identical word sets.

## Scenario builders

`app/core/builders/` — `kit.mjs` is the spine: truth (F1–F5) → dated clock with observable signs → clues derived backwards → cast → endings, plus `check(plan)` and `toElements()`. **Five recipes, five different spines** (the header comment explains why it is not one builder with a genre dropdown): `gothic` a place, `twenties` a chain of people and paper, `space` a resource curve imposed on you, `shadowdark` light and depth against greed, `deltagreen` the cost of acting under cover. **Recipes are capped at three controls** by `builders.test.mjs`.

`check()` codes that matter: **`no-clue-route`** (a fact carried only by people and prizes) and **`one-clue-route`** — counting the villain and the endgame prize as carriers is what let unrunnable scenarios pass. `draw()`/`drawMany()` pass the settled facts as **both** params and `facets`; passing them as params alone left every fact silently unenforced.

## Art and maps

`app/core/artgen/`, `artprompt.mjs`, `app/ui/artview.mjs`: seeded procedural SVG in six styles, a prompt for any third-party service, and the user's own Midjourney bridge behind `LOOM_MJ` (off by default). A prompt strips GM asides, dice and bare `[[wikilink]]` targets. `app/core/mapgen*` is a port of the user's Mapwright Foundry module — it names rooms and gives their size and neighbours but says nothing about contents, which is what the `place` subject is for.

## Working method that works

Persona subagents (a GM and a player, given ONE question each) drive the app and report; **then verify every claim yourself before acting.** Agents report faults that do not reproduce and miss ones that matter — but in this project they were also right when I was wrong, twice. Codex (`codex exec --skip-git-repo-check "<prompt>" < /dev/null` — it blocks on stdin otherwise) found real engine bugs and correctly narrowed a test I had written too broadly; it also called a documented, deliberate design choice a bug, so weigh its findings against the comments. Reports in `docs/feedback/`.

Sweeps must vary the seed SHAPE, not just the seed: gothic passed cleanly under `gothic-0-…` while a third of `x0`…`x7` failed.

**When running several agents at once, never `git add -A`** — it sweeps their in-progress work into your commit under the wrong message.

Design canvas (Claude Design artifact): https://claude.ai/code/artifact/96718cad-6f3f-4379-b68a-563cefcbde85

**Why:** the user asked for a clone of https://studio.alkemion.com for the games they run, chose "full clone" + "local app + file sync", and asked for autonomous build → simulated test → fix loops. For art they chose procedural SVG + their Midjourney bridge + prompts only (no image API); for remote access, "just me, from anywhere" — auth and HTTPS, no accounts, no multi-user. The packs cover the systems in their Foundry install, discovered by reading it rather than guessing.

**How to apply:** when the user mentions Loom, adventure boards, or Alkemion, open `~/loom`; read `docs/feedback/REPORT.md` for what is known-broken before adding features. Preview with `preview_start` "loom" (never `npm start` from a Bash call — the server dies with the shell). Related: [[afterimage-scenario]] (imported as a test adventure), [[rpg-skill]], [[mapwright-module]], [[midjourney_bridge]], [[infra-gitea-timevans]].
