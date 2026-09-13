---
type: project
status: active
repo: tevans/loom (gitea.timevans.uk, private)
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
**read that before adding features.**

**Next steps** — driven by `docs/feedback/REPORT.md`.

**Key decisions**
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
