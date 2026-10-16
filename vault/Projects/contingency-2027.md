---
type: project
status: active
repo: slaguru666/contingency2027
path: ~/Library/Mobile Documents/com~apple~CloudDocs/RPGS/Conventions/Contingency 2027
updated: 2026-10-14
---

# Contingency 2027

**What it is** — Contingency, **Wed 27 – Sun 31 January 2027**, Searles Leisure
Resort, Hunstanton. Wyrd Sisters Games Club, members-only, Warhorn booking.
**Twelve games across the house 15-slot grid** (morning / afternoon / evening,
three per day). Friday morning, Saturday morning and Sunday evening are clear.

**Where it lives** — `slaguru666/contingency2027`, mirrored under
`RPGS/Conventions/Contingency 2027`.

**Current state — the slate**

| # | Slot | Game | System |
|---|---|---|---|
| 1 | Wed am | The London Particular | CoC **Gaslight** 1896 |
| 2 | Wed pm | [[afterimage]] | Blade Runner |
| 3 | Wed eve | The Six O'Clock Sitting | CoC **Gaslight** 1894 |
| 4 | Thu am | Black Summer | TWDU (modified) |
| 5 | Thu pm | Closing Weekend | CoC 7e — **modern** (1986) |
| 6 | Thu eve | Dead Air I — Ash & Concrete | CoC 1946 |
| 8 | Fri pm | The New Light | CoC **Gaslight** 1895 |
| 9 | Fri eve | Dead Air II — The Quiet City | CoC 1962 |
| 11 | Sat pm | Paper Children | Blade Runner |
| 12 | Sat eve | Dead Air III — Full Volume | CoC modern |
| 13 | Sun am | The Favour | Dee Sanction |
| 14 | Sun pm | The Perpetual Order | CoC **Gaslight** 1895 |

**The spec Tim set:** two Blade Runner, one Dee Sanction on Sunday morning, one
Walking Dead, the rest Call of Cthulhu — a three-evening arc plus **Pulp or
Gaslight only** in every other CoC slot. That settled at one Pulp and four
Gaslight, and then **the Pulp went too**: Slot 5 is now modern-rules CoC set in
1986. Final shape of the eight CoC: **3 arc · 4 Gaslight · 1 modern. No Pulp.**

All twelve are outlined. **Eleven scenarios still to write** — AFTERIMAGE is the
only finished one. `archive/` holds six games cut along the way (Vanity,
Vaesen, The Protestant Wind, The Last Fix, The Sky Ride, and the
[[custodians-ringbrp]] CLEAN
GROUND pointer); nothing deleted.

**Next steps**
- Write DEAD AIR I first — earliest new game on the table, and the trilogy is one
  production with three outputs
- Build the Blade Runner four once — they serve Slots 2 and 11 and must not diverge
- Decide whether THE FAVOUR survives a 9am Sunday or swaps with Slot 14; its Act
  Two is an archive act and the archived *Protestant Wind* has the brisk structure
  to raid
- Replace the placeholder slot times once Warhorn publishes
- Decide whether the Searles rooms seat six (three games do)

**Key decisions**
- **DEAD AIR is one production with three outputs**, not three scenarios. Runs
  three consecutive **nights** at 6 players. Reframed around a room the Ahnenerbe
  built under the Führerbunker; the bible carries a binding *Handling the Nazi
  material* section.
- **Shared casts are the load strategy.** Paper Children reuses AFTERIMAGE's four
  pregens, sheets, art and console module untouched. Changing a shared sheet means
  re-auditing both games.
- **Non-arc CoC is four Gaslight (1, 3, 8, 14) plus one modern game (5).** The
  Pulp slot was kept on Thursday for two revisions because Thursday is the day
  that needs a relief valve; then Tim replaced it outright with an 1986 slasher.
  **The consequence is live and unfixed: Thursday is now three horror games**
  (zombies 9am → slasher → Berlin 1946), so CLOSING WEEKEND has to carry the
  day's break on register alone — its first ninety minutes are written to be
  funny, and if it is run straight the day is a grind.
  The four Gaslight share a period (build the handout furniture
  once) but deliberately **not** a shape: Slot 1 is mobile and city-wide, the
  other three are each a single location.
- **Thirty-six 30-second trailers exist** — twelve games × **16:9, 9:16 and 1:1** —
  built from `tools/trailers/`: a generator, one JSON spec per game, and
  `backdrops.py` holding one procedural plate per game (fog, rain, séance lamp,
  searchlight, VHS, caustics, 212 lamps, oscilloscope, microfiche, spectrum,
  woodcut, tide light). Seeded noise only, no stock or generated imagery. 50–80s
  to render each. MP4s are **gitignored** (1.1 GB); the specs reproduce them.
  Run `--check` on a spec and `--still <t>` to look at a frame before encoding.
  If a slot time or player count changes, the booking card is baked into each
  spec and all thirty-six need re-rendering. The Warhorn blurbs each link a
  trailer. **They are live** at
  `https://web.oneoffgames.com/trailers/contingency-2027/` on the One Off Games
  VPS — 720p web encodes from `tools/web_encodes.sh`, 243 MB. Deliberately
  **outside `/conventions/`**, which is password protected; see
  [[infra-oneoffgames-vps]].

- **Two games are deliberately art-free** — The Six O'Clock Sitting and The
  Perpetual Order, both Gaslight, both one location. The slate's ballast; keep
  them cheap.
- AFTERIMAGE is ported, not rewritten.
- Witch Finder **Garratt** (two t's) is canon from *The Princes Bride*
  ([[continuum-2026]]); The Favour runs forward from that game's crossroads
  Tangent scene.

Related: [[continuum-2026]], [[afterimage]], [[rpg-skill]], [[custodians-ringbrp]]
