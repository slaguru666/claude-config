---
type: project
status: complete
repo: slaguru666/blueprint-news
path: ~/blueprint-news
updated: 2026-09-13
---

# Blueprint News

**What it is** — An engine-agnostic SLA Industries BPN (Blue Print News)
mission-briefing generator: a framework-free ES-module component plus a standalone
web app built on it. A rebuild of the earlier Foundry-bound experiments with every
engine call stripped out.

**Where it lives**
- `~/blueprint-news/` → public `slaguru666/blueprint-news` (default branch `master`)
- Foundry module `sla-blueprint-news` at `~/FoundryVTT/Data/modules/sla-blueprint-news/`
  → `slaguru666/sla-blueprint-news` (v0.1.0)
- Zero Engine variant `sla-blueprint-news-zero` → `slaguru666/sla-blueprint-news-zero` (v0.5.0)

**Current state** — All three shipped. Seeded procedural SVG art (flat stencil /
propaganda style, never photorealistic). Per-band scene motifs and halftone contact
portraits. The Zero Engine variant additionally spawns real Zero Engine NPC actors —
threat group plus cast, with attributes, HP, armour and embedded weapons.

**Next steps**
- Load-test both Foundry modules in a running world — neither has been

**Key decisions**
- **Two separate surfaces per briefing**: Player Brief (the official dispatch) and
  GM Dossier (twist, withheld fact, true threat read, levers, dice state).
- NPC/monster generation is a **separate future module**. Each briefing exposes
  `bpn.npcSeam` as the hand-off point rather than growing that capability here.
- Foundry render uses `artMode:"img"` because Foundry strips inline SVG.

**Gotchas**
- GitHub MCP is not authenticated for this repo — use the `gh` CLI.
- The Zero variant is de-collided under its own global so it coexists with the base
  module.
- Aesthetic, palette and fonts come from the `sla-industries-brp` system.

Related: [[mapwright]], [[rpg-skill]]
