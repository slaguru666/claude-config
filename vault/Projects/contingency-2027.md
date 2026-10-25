---
type: project
status: active
repo: slaguru666/contingency2027
path: ~/Library/Mobile Documents/com~apple~CloudDocs/RPGS/Conventions/Contingency 2027
updated: 2026-10-25
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
| 1 | Wed am | The Perpetual Order | CoC **Gaslight** 1895 |
| 2 | Wed pm | [[afterimage]] | Blade Runner |
| 3 | Wed eve | The Six O'Clock Sitting | CoC **Gaslight** 1894 |
| 4 | Thu am | Black Summer: Last Flight Out | TWDU (modified) |
| 5 | Thu pm | Continuous Service | **ALIEN RPG** Cinematic |
| 6 | Thu eve | The London Particular | CoC **Gaslight** 1896 |
| 8 | Fri pm | Viva Voce | CoC 7e **1920s** (Miskatonic) |
| 9 | Fri eve | The Curious Case of Mr Parker's Diary | **Vaesen** |
| 11 | Sat pm | Paper Children | Blade Runner |
| 12 | Sat eve | Closing Weekend | CoC 7e — **modern** (1986) |
| 13 | Sun am | The Favour | Dee Sanction |
| 14 | Sun pm | Provenance | **Outgunned** (1938) |

**The slate was rebuilt on 2026-10-25** and the original spec no longer
describes it. Tim cut **all three DEAD AIR games**, **The New Light** and the
Atlantic City Outgunned heist, moved three survivors to new slots, and added
four new games: an ALIEN hauler, a Miskatonic viva, a revived Vaesen outline
and a 1938 Spain Outgunned game. **Nine systems now, five of them appearing
exactly once.**

The CoC count fell from eight to five: **3 Gaslight · 1 1920s · 1 modern.
No Pulp, no arc.** `archive/` holds eleven cut games; nothing is deleted.

All twelve are outlined. **Eleven scenarios still to write** — AFTERIMAGE is the
only finished one.

**Next steps**
- Write the four new outlines up to scenario v1 — they are the only games with
  no written text at all behind the outline
- Build the Blade Runner four once — they serve Slots 2 and 11 and must not diverge
- Answer the two questions that block drafting: how many creatures in CONTINUOUS
  SERVICE, and how far VIVA VOCE's Extract Three goes
- Replace the placeholder slot times once Warhorn publishes
- Decide whether the Searles rooms seat six (one game does — Slot 12)

**Key decisions**
- **Player counts, 2026-10-25: Blade Runner 4, everything else 4–6.** The two
  Blade Runner games share one set of four pregens, so four is structural there.
  The range is not free: **ten games must now ship six sheets and still play at
  four**, and the "do the Searles rooms seat six?" question that applied to one
  game now applies to ten. Three games had the old count written into their
  fiction (Black Summer's three boarding chits for five, The Perpetual Order's
  padlock "between the four of you", Closing Weekend's eight counsellors) and
  were rewritten to scale rather than renumbered. Black Summer's chits stay at
  three whatever the table size, so its squeeze varies with who turns up —
  flagged in the outline, not yet playtested.
- **The adverts do not give away the plot** (Tim, 2026-10-25). Six were handing
  over the discovery: the crates' contents, Afterimage's corporate lie, the
  fog-register pattern, Paper Children's whole business, that a Closing Weekend
  PC is the killer, and that someone is alive aboard the *Keelson*. Each now
  states the situation and the question and stops. **The rule is premise yes,
  twist no** — Provenance keeps "they are within their rights" because that is
  the situation; what it withholds is that the 1811 removal was the rescue.
  **One open tension:** cutting Closing Weekend's mask line is right as spoiler
  policy, but if the mask rule is told to the table up front (Decision 4) a
  player arguably needs it before booking. That is consent, not spoiler.
- **DEAD AIR came off the slate on 2026-10-25**, after three outlines and a full
  trilogy bible. It was the slate's only economy of scale — one production with
  three outputs across three consecutive nights. Removing it **made preparation
  harder while leaving the game count at twelve**: nine systems, five appearing
  once. The bible survives in `archive/` and its *Handling the Nazi material*
  constraints were carried into PROVENANCE, which is the only game that still
  needs them.
- **Shared casts are the load strategy.** Paper Children reuses AFTERIMAGE's four
  pregens, sheets, art and console module untouched. Changing a shared sheet means
  re-auditing both games.
- **The three Gaslight games (1, 3, 6) share a period but deliberately not a
  shape** — Slot 1 is mobile and city-wide, the other two are each a single
  location. Build the handout furniture once.
- **Thursday is no longer three horror games.** The old grind — zombies 9am,
  slasher, Berlin 1946 — was broken by the 2026-10-25 reshuffle: Thursday now
  runs Black Summer, CONTINUOUS SERVICE and The London Particular, and CLOSING
  WEEKEND moved to Saturday night where its comic first ninety minutes no longer
  have to carry a whole day's relief. **This was a side effect of the reshuffle,
  not the reason for it**, but it fixed a known problem.
- **Thirty-six 30-second trailers exist** — twelve games × **16:9, 9:16 and 1:1** —
  built from `tools/trailers/`: a generator, one JSON spec per game, and
  `backdrops.py` holding one procedural plate per game (fog, rain, séance lamp,
  searchlight, VHS, caustics, oscilloscope, microfiche, ruled paper, dust shaft,
  woodcut, tide light — `filament` and `spectrum` are now unused). Seeded noise only, no stock or generated imagery. 50–80s
  to render each. MP4s are **gitignored** (1.1 GB); the specs reproduce them.
  Run `--check` on a spec and `--still <t>` to look at a frame before encoding.
  If a slot time or player count changes, the booking card is baked into each
  spec and all thirty-six need re-rendering. The Warhorn blurbs each link a
  trailer. **All thirty-six were rebuilt on 2026-10-25** for the new slate.
  **There is a real page** at
  `https://web.oneoffgames.com/trailers/contingency-2027/` on the One Off Games
  VPS — that URL is printed on the flyer and answered **403** until 2026-10-25,
  because the folder had the files but no index. Generated by
  `tools/build_trailer_site.py` from the specs + one-pager (`--check` fails if
  stale), published by `tools/deploy_trailer_site.sh`. Videos are
  `preload="none"` behind generated poster frames, so a visit is 13 requests and
  440 KB rather than 252 MB. It uses the convention's look, not the site's
  green-terminal house style — 720p web encodes from `tools/web_encodes.sh`, 243 MB. Deliberately
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
