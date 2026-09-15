---
type: project
status: active
repo: slaguru666/Continuum2026
path: ~/Library/Mobile Documents/com~apple~CloudDocs/RPGS/Conventions/Continuum 2026
updated: 2026-09-15
---

# Continuum 2026

**What it is** — Continuum, Cranfield (continuumconvention.co.uk), **24–26 July
2026**. Tim GMs a slate of slots, each 4 hours booked / 3 hours run.

**Where it lives** — Private repo `slaguru666/Continuum2026` holds every scenario,
GM console and art asset. Local copy mirrors it under `RPGS/Conventions/Continuum 2026/`.
Shared-folder convention: `scenarios/<day>-slot<N>-<system>-<name>.md`,
`gm-utility/<name>/`, art under `scenarios/art/<name>/`.

**Current state — the slate**

| Slot | Game | System |
|---|---|---|
| Fri S1 | Day One | BRP |
| Fri S2, 20:00–00:00 | [[afterimage]] | Blade Runner |
| Sat S4 | The Vain Crown | VANITY |
| Sat S5 | By the Light of the Silvery Moon | CoC Gaslight |
| Sun S6 | Get to the Chopper — Another Fine Mess | Pulp Cthulhu |
| Sun S7, 14:00–18:00 | The Princes Bride | The Dee Sanction |

All six are ported into [[the-director]] with real times.

**Web delivery** — four PWA variants built by `pwa/build-all.sh`, each its own Caddy
container on the VPS (`77.68.99.134`, `tevans`, `/home/tevans/continuum-pwa`). Content is
**baked into the image at build time** — no volume mounts — so `docker compose up -d --build`
is what publishes. Every variant now has its own `deploy*/README.md`.

| Variant | Host | Container | Dist in git? |
|---|---|---|---|
| v1 tablet | continuum.timevans.uk | continuum-app | gitignored |
| v2 responsive | continuum2 / c26 .timevans.uk | continuum2-app | yes, bar the print PDFs |
| e-paper | con2026epaper.timevans.uk | con2026epaper-app | untracked |
| phone | con26phone.timevans.uk | con26phone-app | **yes, in full** |

`apps.timevans.uk` is the separate apps-hub, **not** v1 — `deploy/deploy.sh` said otherwise
until `aa89894`. `vanityrpg.timevans.uk` is the unrelated dice app.

**Next steps**
- Print packs and read-throughs per scenario.

**Key decisions**
- Scenario source-of-truth for timelines is the `gm-utility/*console` files, not the
  scenario Markdown — the Director's data was transcribed from the consoles.
- **The slate is six games** (Silvery Moon, Sat S5, was the one in doubt) — confirmed
  against the repo, and all six are mirrored to iCloud.
- `pwa/dist-v2/print/*.pdf` is **gitignored** — it duplicates `print/` byte for byte
  (218MB). A fresh clone must run `node pwa/build-v2.mjs` before building the image,
  or the container ships with no print PDFs and no error. Documented in the v2 README.
- **Tracked build output: `dist-v2` and `dist-phone` only.** `dist` and `dist-epaper`
  are 542MB each (they carry the print pack) and stay out; `dist-phone` is 64KB of
  self-contained HTML, so it is in.

**The Princes Bride — canon, reconciled** (the January drafts contradicted each other)
- Mary Fletcher made the planted poppet; the real fae charm came from the late
  Agatha Thorne; Garratt is a persuadable pragmatist; McShay's rejected proposal was
  to Eleanor Patterson; the Prince is **Sigismund** (not Henry — PC name collision);
  the village is **Faversholme**, Yorkshire, October **1586**.
- Pregens are always "Meg", "Nell", "Lynton" at the table — never Margaret/Eleanor/Thomas.
- **Use the real Dee Sanction rules**: one Ability die (d4–d12), 3+ succeeds, 1–2
  Falters, Expertise steps the die up, Fortune is one re-roll, the Unravelling track
  steps down on uncanny Falters. The old `gm-quick-reference.html` describes a
  different game entirely — ignore it.
- Set-pieces: the Trial at dawn on an open **Verdict Die**; the Bargain at the stones
  is won by courtesies, not by a roll. Console: THE SANCTION DESK.

Related: [[contingency-2027]], [[rpg-skill]], [[the-director]]
