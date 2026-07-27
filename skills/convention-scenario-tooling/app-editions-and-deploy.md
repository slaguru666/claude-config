# Convention app editions — fork-vs-adapt, deploy, and the gotchas that cost hours

This is the shipping half. It captures what the Continuum 2026 project got *right*, and —
honestly — what it got *wrong*, verified by watching fresh agents solve the same requests
better than the project actually did.

## Before any of this: should the edition exist at all?

Post-convention truth: **all five editions went unused.** The GM found the content apps too
complex and the story material too convoluted; the tool he valued was the separate in-play
**help** tool, not content reference. So the first question is never "which architecture" — it
is **"will this actually get opened at the table?"** For scenario *content*, the honest default
is **no** — build lean prep docs and put effort into the live help tool instead. Only build a
content edition when the GM explicitly asks for one, and even then make it one concise surface.
The decision table below applies *once you've established the thing is genuinely wanted.*

## The core decision: adapt one source, or build a separate artifact?

A new "make me a version for device X" request is one of three things. Classify it before you build:

| The delta is… | Then… | Real example |
|---|---|---|
| **Presentation only** (colour, motion, density, layout, tap size) | **Adapt one source** — media query or a theme flag. Ship its own URL/container if the device needs one, but the *content and build stay single-source.* | laptop vs tablet → one responsive build, `@media (hover:hover)` for the laptop layer |
| **Build-time divergence the runtime can't express** | **Separate build is justified** — but still fed from the *one* content source. | e-paper needed a non-deferred `<head>` script to clamp `setInterval`/`rAF` against ghosting — a runtime theme toggle can't inject that early. |
| **Different content model or machinery** | **Separate artifact.** Don't drag the unwanted machinery in. | phone story reader (no dice/stats/props) vs interactive consoles → its own tiny app |

**The mistake to avoid: forking for a presentation-only delta.** The laptop layer correctly
stayed one build; if every device had become its own `build-X.mjs`, weekly content edits would
fan out to N hand-maintained bundles.

## The anti-pattern the project actually committed (fix it if you touch this again)

**A hand-copied content store that duplicates the scenario docs.** The phone app's
`pwa/phone/data/*.json` was *distilled by hand* from `scenarios/*.md`. It is a second copy of
narrative that already exists upstream — so **it silently goes stale the moment a scenario is
rewritten** (and scenarios changed almost weekly: Draft 14 errata, Day One v2.0, art/budget
fixes). Every other edition reads the shared con content and only goes stale on *presentation*
bugs; the phone reader can go stale on *content*, invisibly, because nothing links the JSON
back to the Markdown.

**The right shape:** name the extractable fields consistently in the scenario docs (logline,
GM's Truth, Player-Experience/through-line, per-act Goal/Summary/start/next — see
[scenario-authoring.md]) and **generate** the reader's data from them in the build step. One
source, many renders. If you add editions again, this is the highest-value refactor.

## Cross-session drift: the reason five editions exist

No single request was wrong. Each "can you also make one for X?" got a locally-reasonable
"yes." The *sum* was five separate builds + containers + Caddy routes + hub tiles, each a
standing staleness liability — and only ~1–2 were likely used at the table.

**Discipline (the one real rule here):** when the **Nth** variant request arrives, stop and
inventory the whole edition set *before* answering. Ask: does this fold into an existing
build as a theme, or is it genuinely a new content model? Answer the set, not the request.
Fresh agents do this correctly when the existing forks are visible to them — so *make them
visible*: the accretion happens when each request is handled in isolation across sessions.

## The deploy pattern (verified, reusable)

Production VPS `tevans@77.68.99.134` (the `ubuntu` SSH alias exists only on some machines —
from the Mac use `tevans@77.68.99.134` directly). Docker as `tevans`, no sudo. Repo mirrored
at `~/continuum-pwa/` (`pwa/`, `deploy*/`, `apps-hub/`). **Continuum2026 is private → the VPS
has no GitHub creds, so `rsync` the built `dist-*` + the `deploy-*` dir over SSH; never
`git clone` there.**

Per edition:
1. `node pwa/build-<edition>.mjs` → `pwa/dist-<edition>/`
2. `deploy-<edition>/` holds `Dockerfile` (context = repo root, `COPY pwa/dist-<edition> /srv`), `docker-compose.yml` (`container_name: <name>-app`, `networks: [proxy]` external), `site-Caddyfile`.
3. `rsync -az --delete pwa/dist-<edition>/ tevans@…:continuum-pwa/pwa/dist-<edition>/` and `rsync -az deploy-<edition>/ …`
4. `cd continuum-pwa/deploy-<edition> && docker compose up -d --build`
5. Add the Caddy route (see gotcha below), reload, verify.

Containers: `continuum-app` · `continuum2-app` · `con2026epaper-app` · `con26phone-app` · `apps-hub`.
`pwa/build-all.sh` rebuilds all four editions from current content.

## Gotchas that repeatedly cost real time

- **Caddyfile inode trap.** `/opt/graphiti/Caddyfile` is bind-mounted **read-only** into
  `graphiti-caddy-1`, pinned to the original inode. **Never edit with `mv` or `sed -i`** — they
  create a new inode and the container keeps reading the stale one. Edit **in place** (`>>`
  append), back up first (`cp Caddyfile Caddyfile.bak.$(date +%s)`), then reload via the admin
  API from stdin: `docker exec -i graphiti-caddy-1 caddy reload --config - --adapter caddyfile < /opt/graphiti/Caddyfile`.
  A route is `sub.timevans.uk { reverse_proxy <container>:80 }`. Each subdomain needs its own
  DNS A → 77.68.99.134 (no wildcard); Caddy auto-issues TLS once DNS resolves.
- **Service-worker cache staleness — the big time-sink.** After *any* rebuild, the old SW keeps
  serving the old `index.html`, so you debug code that isn't running. Before believing what you
  see: unregister the SW, clear caches, **full reload** (a hash-only nav does *not* reload the
  document). In the automation pane, also **front the tab** — a backgrounded tab throttles
  `requestAnimationFrame` and fakes "my scroll tracker is broken."
- **Memory-file path.** Project memory for this work lives under the FoundryVTT project key:
  `~/.claude/projects/-Users-timevans-Library-Application-Support-FoundryVTT/memory/project-continuum-app.md`,
  not the `-Users-timevans` key the index implies.
- **Writes to the VPS need the user's explicit go-ahead at the point of the write** — per-action,
  not blanket. Build and verify locally first, then ask before touching production.

## Design notes that made the apps read as human, not generated

- Editorial typography (serif prose stack; sans for UI labels), per-scenario accent colours.
- The `impeccable` design hook flagged AI-tells worth avoiding: **side-tab accent borders** on
  cards and a **flat type hierarchy**. Fixes: an editorial contents list (loglines as the hero,
  hairline rules, no boxy cards), a real display/body/label size ramp, accent *ticks* not borders.
- Offline-first: hand-written SW precache. Full non-PDF precache for the console app (art paths
  are built in JS, so an HTML-crawl misses them); a tiny 5-entry precache for the text-only phone
  reader (text is instant offline).
