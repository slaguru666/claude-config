---
name: contingency-2027
description: "Contingency 2027 convention (27–31 Jan 2027, Hunstanton) — repo slaguru666/contingency2027; twelve games on the 15-slot grid, all outlined, eleven still to write. Slate rebuilt 2026-10-25: nine systems, no DEAD AIR arc."
metadata:
  type: project
---

Contingency 2027 runs **Wed 27 – Sun 31 January 2027** at Searles Leisure Resort,
Hunstanton (Wyrd Sisters Games Club, members-only, Warhorn booking). Tim GMs
**twelve games on the house 15-slot grid** — morning/afternoon/evening, three per
day. Friday morning, Saturday morning and Sunday evening are deliberately clear,
and they are what make twelve survivable.

Repo: `slaguru666/contingency2027`. Mirror:
`~/Library/Mobile Documents/com~apple~CloudDocs/RPGS/Conventions/Contingency 2027`.
Full detail in the vault note `Projects/contingency-2027.md` — see
[[claude-memory-vault]].

**The slate was rebuilt on 2026-10-25 and any earlier description of it is
wrong.** Out went all three DEAD AIR games, The New Light, and an Atlantic City
1988 Outgunned heist. In came CONTINUOUS SERVICE (ALIEN), VIVA VOCE (CoC 1927,
Miskatonic), MR PARKER'S DIARY (Vaesen — Tim's own parked outline, revived rather
than a second Vaesen invented) and PROVENANCE (Outgunned, Aragón 1938). Three
survivors moved slots. Current order: Perpetual Order, Afterimage, Six O'Clock
Sitting, Black Summer, Continuous Service, London Particular, Viva Voce, Mr
Parker's Diary, Paper Children, Closing Weekend, The Favour, Provenance.

**The rebuild cost the slate its only economy of scale.** DEAD AIR was one
production with three outputs across three consecutive nights. Without it there
are **nine systems, five appearing exactly once** — the game count stayed at
twelve while the preparation got harder. Say this plainly if the slate changes
again. The CoC count fell from eight to five: 3 Gaslight, 1 1920s, 1 modern; no
Pulp, no arc.

**Player counts (Tim, 2026-10-25): Blade Runner 4, every other game 4–6.** The
two Blade Runner games share one set of four pregens, so four is structural
there. The range is not free — ten games must ship six sheets and still play at
four, and the Searles seating question now applies to ten games instead of one.
**Watch for counts written into the fiction, not the metadata:** three games had
the old number in their premise (Black Summer's three chits "between the five of
you", The Perpetual Order's padlock, Closing Weekend's eight counsellors).
Grepping "N players" finds none of those; grepping **"of you"** finds them all.

**The adverts must not give away the plot (Tim, 2026-10-25).** The working rule
is **premise yes, twist no**: state the situation the players walk into and the
question it raises, then stop. Applies to the flyer, the trailer specs, the
one-pager/README and the Warhorn blurbs — change all four together and verify
they agree per game. One standing tension: Closing Weekend's advert no longer
says a PC is the killer, so if that rule is told to the table up front a player
needs it before booking — that is consent, not spoiler.

**The load strategy is shared casts and cheap builds.** Paper Children reuses
AFTERIMAGE's four pregens, sheets and art untouched (changing one sheet means
re-auditing both games); The Six O'Clock Sitting and The Perpetual Order are
one-location Gaslight games needing no art; the three Gaslight games share a
period, so their handout furniture gets built once. Only AFTERIMAGE is finished;
**eleven scenarios remain**.

**Thirty-six trailers** (twelve games × 16:9, 9:16, 1:1) are live at
`https://web.oneoffgames.com/trailers/contingency-2027/` — deliberately outside
`/conventions/`, which is `auth_basic` protected; see [[infra-oneoffgames-vps]].
Built from `tools/trailers/` (generator + one JSON spec per game + one procedural
plate each in `backdrops.py`); MP4s are gitignored, the specs reproduce them.
**The booking card is baked into every frame**, so any slot or player-count change
means re-rendering all thirty-six, re-running `tools/web_encodes.sh` and rsyncing.
That drill was run for real on 2026-10-25 and works. rsync lands files as
`root:root` — chown back to `webftp:www-data` 644 afterwards.

`archive/` holds eleven games cut as the slate changed, plus the DEAD AIR trilogy
bible, whose *Handling the Nazi material* constraints were carried into PROVENANCE.
Nothing is deleted; retired trailers on the VPS were moved to
`retired-2026-10-25/`, not removed. See also [[rpg-skill]].
