---
type: project
status: active
repo: slaguru666/loom (gitea.timevans.uk, private)
path: ~/loom
updated: 2026-09-13
---

# Loom

**What it is** — A local Alkemion-style adventure-design tool: boards, procedural
generators, scenario builders, a map generator and procedural art. Zero-dependency
Node ≥20 server plus a vanilla ES-module front end, no build step.

**Where it lives** — `~/loom` (branch `main`), remote `slaguru666/loom` on
gitea.timevans.uk, private, pushed 9 Sep 2026. Dev port **8771** via the `loom`
launch config. Deployed to **https://loom.oneoffgames.com** ([[oneoffgames-vps]]):
code `/opt/loom`, data `/var/lib/loom`, secrets in root-only `/etc/loom.env`,
hourly backup to `tevans/loom-data` on Gitea. Real adventures default to
`~/Documents/Loom` — deliberately not `~/Loom`, because macOS treats the two as the
same folder and the app would write into its own source.

**Current state** — Working and deployed. Seven maker packs (~7,200 rows), six
subjects, five scenario-builder recipes, seeded procedural SVG art in six styles,
passphrase-gated remote access. Known issues are listed in `docs/feedback/REPORT.md` —
**read that before adding features.** The Custodians material is now imported and live on
the deployed instance: the five CLEAN GROUND / Through Train scenarios, the art sheets, the
GM screen, and the Ringworld setting board generated from the bible by
`~/RingBRP/make-loom-board.mjs` (a generator, so the bible stays the single source — it adds
only card *type*, which Loom colours by and numbered headings cannot supply).

**Next steps** — driven by `docs/feedback/REPORT.md`.

**Key decisions**
- 2026-09-13 — **A seed is meaningless without the engine that read it.** `ENGINE`
  (`generators.mjs:52`, now 2) is written into provenance beside the seed and bumped
  whenever generation changes meaning; otherwise rewriting a pack row silently makes old
  output unreproducible. The Makers panel has to be given it explicitly — that view copies
  named fields onto its own result rows, so a new provenance field does not reach it
  → [[2026-09]]
- 2026-09-13 — **Documents are pushed into Loom, never copied into it.** `tools/import-docs.mjs`
  posts Markdown from wherever it is authored (the RingBRP system, ChaosiumCon26) to a running
  Loom; `--dry`, `--replace`, `--host`, `--campaign`, and `LOOM_COOKIE` for the passphrase gate,
  which the script never handles itself. A second import of the same document is refused rather
  than silently collecting `through-train-2`. It reports the counts the **server** returned, not
  the plan it computed — the two disagree whenever the server holds an older importer, and
  reporting the plan hides that completely → [[2026-09]]
- Each adventure is a folder of Markdown and JSON, so it syncs with Seafile or
  Nextcloud and opens in Obsidian.
- Remote access is "just me, from anywhere": a passphrase and HTTPS, no accounts,
  no multi-user.
- Art is procedural SVG plus prompts plus the [[midjourney-bridge]] — no image API.
- **One seed shares a world across a whole pack.** A player tester found this; a GM
  tester reported the opposite. The player was right.

**Gotchas — these cost whole sessions**
- `{{x@Table #$ctl}}` is a tag **filter, not a hint.** It *requires* the tag, so every
  untagged row becomes undrawable while the control's own facet was already doing the
  constraining. Written five times in four packs; nothing caught it because the
  generator still returns text, just from a fraction of the table.
- `facetsOf` builds a Map, so a row cannot assert two values of one key.
- An untagged row is eligible **everywhere** — the cause of nearly every content bug.
- **Measure empirically; never model eligibility from tags.** Modelling gave the
  wrong answer four separate times.
- A long-running Loom holds the importer it booted with — restart after changing
  `app/core/import.mjs` or imports silently use the old rules.
- Never plain `rsync -a` to the VPS as root; it pushes your local uid onto
  `/var/lib/loom`. Omit `--delete` so existing boards survive.
- ssh resolves `~` from the passwd database, not `$HOME`.
- Preview with `preview_start` "loom" — `npm start` from a Bash call dies with the shell.
- Sweeps must vary the seed **shape**, not just the seed.

Related: [[mapwright]], [[afterimage]], [[gitea-timevans]], [[oneoffgames-vps]]
