---
type: project
status: active
repo: slaguru666/RingBRP + slaguru666/ringbrp-design
path: ~/FoundryVTT/Data/systems/ringbrp + ~/RingBRP
updated: 2026-10-12
---

# The Custodians (RingBRP)

**What it is** — A Ringworld BRP Foundry system, started 7 August 2026, now named
**THE CUSTODIANS**. Two repositories, and the distinction matters.

**Where it lives**
- `~/FoundryVTT/Data/systems/ringbrp/` → `slaguru666/RingBRP` — the playable system.
  Scenarios live *inside it* at `docs/scenarios/`, which is why searching Gitea for a
  scenario repo finds nothing. `docs/GM_SCREEN.md` is the table-facing sheet.
- `~/RingBRP/` → `slaguru666/ringbrp-design` (public since 9 Sep 2026) — the design
  corpus: the bible, six rules specs, 26 review briefs. `.gitignore` holds the scans back.

**Current state** — playable and guarded. **28 build guards** under `bun run check`, each a
claim about the game re-measured on every build. **`docs/REVIEW_LOG.md` (at R-318) holds the
reasoning behind all of them** and is the thing to read before re-deciding anything here.
Scenarios: `LAST_ADMISSION`, `OPEN_DAY`, `THROUGH_TRAIN`, **CLEAN GROUND** (v0.25, eleven
desk passes, artwork placed, Contingency 2027 slot 9), whose published figures are held in both directions —
`check-packs` holds the baseline against the harness, `check-cited` the prose against the
baseline, and **`check-figures` reads the figures rather than the markers**, so a measured
number with nothing holding it stops the build. That guard is now one reader with three
authorities — shapes on a named phrasing, columns on the table header, bold in prose only —
after `check-unmarked` was folded into it.

**STANDING ORDER is at v3.2 (7 Oct 2026)** — the slow (half-speed ageing below), an unarmed
1974 Board of Inspection, a committee that only accepts its own clause 5 evidence, and
**Mr Smith living in Warden Michael Smith since 1974 without knowing it.** Act Three is a
measured encounter (`so_smith_awake`) over a 40-minute clock with 168 children opening the
blast lock. **The engine is the twins:** 122 of the 168 children are 61 pairs born 2010–2013,
and they are what bends time there — the clocks have said so since 2010. 59 plates and 14 maps
wired; desk passes are all that is left. Prompts and blocked words in
`docs/scenarios/STANDING_ORDER_ART.md`.

**THE LONG RETURN — a three-case time-travel sequence off STANDING ORDER.** Outline in
`docs/LONG_RETURN_PLAN.md` (deliberately in `docs/` root, not `docs/scenarios/`, or the corpus
guard classifies it). **Case 1, `docs/scenarios/RETURN_WORKING.md`, is written at v1.0** —
4 November 1974, the day the door shut, ridden in on Ada and Tom Verity. Cases 2 (DEAD
RECKONING, Region 8, 1996) and 3 (CLOSING TIME, now) are outline only. **No Foundry pack for
RETURN WORKING and no 1974 cast actors**; the Markdown is the deliverable so far.

**Panic is a rolled action (11 Oct 2026)** — the track existed since early on and was
**inert**: `gainPanic` had one caller, the sheet's + button, hardcoding `wrongThing`.
Now a point lands without a roll and then the agent rolls **Hold, POW×5**, through
`skillRoll` where the band penalty already sits — so the escalation needed no new
arithmetic. `PANIC_CONSEQUENCES` in `rules.mjs` is one rung per band (−10% next roll /
no defence / grip lowered / no attack / break), each enforced at an existing chokepoint,
with per-round state in `system.combat.panicPending` cleared by the reset that already
clears defences. **Four triggers fire themselves (12 Oct 2026, R-315/R-316)** — `majorWound` every time a
wound is rolled, `aBody`, `someoneYouKnew` and `touchedByIt` once per scene, keyed by the
same token scheme as the reliefs. The remaining three stay on the + button, which asks
which happened, because the lights going out is not a state the engine can observe.
**`system.wrongToTouch` is declared on the creature, never inferred** — all four proxies
are wrong, and it is a question about **contact**, not about what the creature is (R-317):
only the 93 specs that can reach out answer it, the other 55 are silent, and five harmless
touches are pinned in `tools/harmless-touch-baseline.json`.
The **relief table is wired too**: the − button asks which route, `reach` decides who is
steadied, limits are keyed by scene/combat/case **token** rather than cleared by a
lifecycle, and the attempt spends the limit rather than the result. A GM-only
**Correction** entry takes a point off without spending anything.
**The three skill reliefs now actually roll (12 Oct 2026, R-318)** — they read the rating
from `item.system.rating`, a field **no skill item has**, so Religion, Psychology and Occult
rolled against 0 from the day the table shipped: 1% to help against 5% to backfire onto
everyone they reached. The field is `system.value`. **Training is by posting, not per agent**,
and `check-behaviour` now holds it: `registry` and the `professor` trade have occult in core
(Bhattacharya 63, Lindqvist 58), `interview` and `doctor` psychology in support (Renshaw,
Nkemdirim 40). **Religion was the weak one and is fixed (R-319)** — it was reachable only as
`pathology`'s support rating of 35, so the **Night Warden** now has it in core and Pollard
rolls 53. Six core skills there, like `lead` and `talker`, nothing demoted. The rulebook
prints who trains what, **derived from `ROLES`/`TRADES`** so it cannot drift. And **a point from a backfired attempt
to help cannot take anybody to breaking point**, it stops one short — the only remaining
path to a whole party breaking in the same moment, which THROUGH TRAIN already ruled out.
The cap is on the backfire only; what happens *to* an agent still breaks them.

**WALKING PACE — a standalone 1986 case, v1.3 (12 Oct 2026).** `docs/scenarios/WALKING_PACE.md`,
not part of THE LONG RETURN. One clearance officer, one 1971 instruction nobody countermanded, an
estate built in 1979 on the hospital he is still clearing. **He walks the 1971 corridors, not the
streets**, so WP-H01 and WP-H02 overlay and the safe houses are the old courtyards. Climax is a
ninety-second reading, not a fight. **Two declared breaks from the corpus:** explicit 1986
video-nasty register, and the first case here that **cannot be run without its pictures** — six
approach plates are a mechanic. **Three desk passes, nineteen fixes, pack 22 built.** Two
harnesses: `wp-ninety.mjs` (the climax, measured) and `wp-wardten.mjs` (a **negative** result —
dice cannot tell party splits apart, so three doors are gated in the fiction). Art is a third
press, a 1986 VHS sleeve, in `WALKING_PACE_ART.md`; **pull rate zero** because no plate shows an
injury, a body or a weapon — 33 plates now, the six-card approach deck among them.

**The two overlay sheets are built (12 Oct 2026)** — `tools/walkingpace-plans.mjs` draws
WP-H01, WP-H02 and an acetate version of H02 **from one geometry**: everything is positioned in
corridor coordinates, `s` along the 1971 spine and `t` across it, so the two sheets cannot drift
out of register. `--check` holds eleven rules and caught three faults a reading of the drawing
had passed, the worst a dogleg that took two houses a player-facing clue says it misses. Drawing
it also closed a hole in the text: with eleven dates printed on a handout, the document owed an
answer to why eight wards took seven years and the last three take three nights, and rule 3 now
gives one. Ward ten is **Pardoe Crescent**, the one street that follows the old corridor; the two
safe houses are nos 2 and 4, on the west airing court. **All the art is in** — 33 plates and
5 portraits over six batches, pull rate still zero. **The print pack is built too** —
`WALKING_PACE_HANDOUTS.html`, three A4 sheets, and `check-handouts` holds every word of it
against the scenario while `walkingpace-plans --check` holds WP-H04's addresses against the
ward the map draws. **Left to do: a human run and a slot.**

**ONE MORE ABOARD — a 1912 ocean-liner case, v1 (12 Oct 2026).**
`docs/scenarios/ONE_MORE_ABOARD.md`, **2h30 and no break**, built to Tim's brief: action
packed, and a danger that must not get off the ship while the players do not know who it is.
RMS *Hesperic*, 14 April 1912. **The session clock is the ship's clock, one minute to one
minute** — through at 11:50pm, founders at 2:20am, 150 minutes exactly. **The crossing is
Ashcroft rather than a place**, so the door walks about with a man and the thing's target is
his half of a cut school tie. Identification is a count (2,206 against 2,205 tickets, then a
cancelled stub), three tells that are each a lie, and a positional confirm the table earns by
marking a deck plan — **the suspect is the most helpful man aboard**, and a frightened trimmer
trips two tells as a decoy. **Killing is not containment**: it transfers to whoever last
touched the host. **The perfect ending is six anchors intact and in hand at 2:20, priced at
six refusals**, each a real person who needs the object in an agent's hand. Cast declared:
Holloway, Ashcroft, Renshaw, Ferriby, Sharrock, Okonkwo — **no Medicine and no Sleight of
Hand**, deliberately, with three routes into the purser's office so no beat needs either.
**Left to do: the deck plan (OMA-H01), which is the one prop it cannot run without and wants
the WALKING PACE treatment — one geometry, generated, with a checker; the fight-harness figure
for the creature; a bestiary entry; four handouts; nine plates; and a run.**

**ONE MORE ABOARD's sheets are built (12 Oct 2026)** — `tools/onemoreaboard-plans.mjs` draws
**OMA-H01** (the deck plan the players mark) and **OMA-H01b** (the section, GM side) from one
frame. **The flood is a single model** — sixteen compartments, six open to the sea, bulkheads
carried to stated decks, water by breach, over the top, and spill — and every "this is gone by
now" is derived from it. `--check` holds thirteen rules; `--flood` prints the table. The model
contradicted the scenario and won: **Act Four's route below opens at 1:30 and shuts at 1:48**,
eighteen minutes, not the thirty-five the prose claimed, and Act Five's arithmetic is better for
it. Rule 9 is the mechanic — Treherne in sight at all twelve sightings, the other five out of
sight twice or more — and Treherne's track is **derived** from the agents' rather than kept as a
second copy. Wired into `bun run check`. **Left: four handouts, nine plates, a desk pass, a run.**

**ONE MORE ABOARD's handouts are built (12 Oct 2026)** — `ONE_MORE_ABOARD_HANDOUTS.html`,
four A4 props: **OMA-H02** the crossing order (Bureau, present day), **OMA-H03** the purser's
muster, **OMA-H04** the cancelled counterfoil, **OMA-H05** the shortlist of six. The words are
in the scenario's Handouts section and `check-handouts` holds all four word-for-word. **That
guard is now one function serving both WALKING PACE and ONE MORE ABOARD** rather than two
near-copies, and its green line is built from what it held rather than a hard-coded sentence.
**OMA-H05's six names are held against OMA-H01's sighting table** by the plan generator's rule
14. **Left: nine art plates, a desk pass, a run.**

**ONE MORE ABOARD's art is in (12 Oct 2026)** — nine plates in `art/scenes/oma_01`–`oma_09`,
prompts and record in `ONE_MORE_ABOARD_ART.md`. **The press is a London illustrated weekly,
1912**, the conceit being that these were drawn by an artist who was not there, from a telegram.
**No plate shows a body or anybody in the water** — what the weeklies did, where the horror
belongs, and the only version of the order that could be placed. Zero pulls. Two registers kept
on purpose: engraving for the scenes, tinted lithograph for the two portraits. `oma_01` is the
cover stem `make-pdf` resolves by. **The case is now short only a bestiary entry + pack build,
a desk pass and a run.**

**NPCs, threats and monsters (23 Sep 2026)** — generated NPCs now draw their **posting's
kit**: `drawKitFor()` in `postings.mjs` decides, `generateNPC` issues, and each weapon grants
the skill it names. Armour is an item, not a number. **The forge** (`forge.mjs` at the root,
`tools/forge.mjs` CLI, and a third Actors-sidebar button) derives a creature from role, size,
tier and species and explains every number. **The forge panel is not yet verified in a running
Foundry** — the derivation is, the Foundry glue is not.

**Next steps** — **desk-pass RETURN WORKING**, whose two hours on the moor after the door
shuts is either the best scene in the sequence or twenty dead minutes, and whose five remaining
outline questions (Region 8 tower or island, how much engine the players get, case 3's frame)
are still open. Then **open a world and click the three generator buttons**; that is the only
untested surface. Then **CLEAN GROUND needs a run with human beings** — pass 11 closed the
last desk-reachable branch and all four originals have been played. Then splitting
`ringbrp.mjs`. **CLEAN GROUND's artwork is generated and placed** — 6 NPC portraits at
512×512 and 11 scene plates at 1024×682, prompts and failure notes in
`docs/scenarios/CLEAN_GROUND_ART.md`. One known defect kept on purpose: `cg_04_crossing` has
livestock on a hillside the text says is empty, and seven re-rolls produced nothing better.

Open, and **not** mine to decide: `breach_suit` and `riot_shield` declare no `covers`, so
they armour every location including the head — 12 of 32 armours are the same. And 35
creatures hold a weapon they have no skill for, held at `check-armed`'s ratchet because
giving each one a rating moves `check-lethality`'s numbers.

**Key decisions**
- 2026-10-12 — **A route printed in the rulebook that almost nobody can take is not a rule,
  it is decoration.** Religion existed as a panic relief, was core to a posting the roster does
  not hold, and otherwise a support rating of 35 on one agent. The fix was a posting that was
  already written for it — the Night Warden, whose kit has carried a *ward* since the day it
  was written. Look for the posting the fiction already chose before inventing a reason. R-319.
- 2026-10-12 — **A null result is a claim, and a confident correction of a true statement
  costs more than the original slip.** I "corrected" R-318 to say no roster posting trains the
  panic relief skills, having read `expandFromRegister`'s `skills` **array** as an object keyed
  by family. The probe said 0 of 16 — including the agent whose posting is called *Registry
  Officer* — and I ran it twice and believed it, because a coincidence in the live world
  (Lindqvist's stale 59-skill import genuinely has no occult item) looked like corroboration.
  The guard that followed asserts a **positive** hit per relief, so a reader that cannot see a
  training declaration fails instead of reporting zero. R-318.
- 2026-10-12 — **A balance question about a rule nobody can roll is not a balance question.**
  The Occult fumble looked too harsh; measuring it first found the roll reading a field that
  does not exist, so every skill relief had been at band 1 since it shipped. Measure before
  tuning, and when the measurement answers a different question than the one asked, answer
  that one. R-318.
- 2026-10-12 — **A cap on the bad outcome has to be conditional on the outcome.** Stopping a
  backfire one short of breaking point reads identically to stopping *every* relief one short,
  and the second quietly hands a free point back on a plain failure at the cap. It passed four
  tests. The guard belongs on the branch, not on the number. R-318.
- 2026-10-12 — **Ask the question the rule needs, and let absence be an answer.** `anomalous`
  claimed something about a creature's nature in order to serve one rule about contact, and a
  broad claim pressed into narrow service went wrong at both ends — 50 declarations that changed
  nothing, and a boolean true 143 times in 148. `wrongToTouch` is asked only of creatures that
  can reach out; the rest declare nothing and the default is then honest. R-317.
- 2026-10-12 — **A guard's success line is a claim and needs holding too.** Printing the figures
  honestly found two real defects in the guard that printed them (129 cross-checks against 93
  declarations, then 92 against 93). This project holds every figure in its prose against the
  code; the numbers a guard prints about itself did not get the same treatment. R-317.
- 2026-10-12 — **A guard's green line must be built from what it checked.** `check-handouts`
  announced CLEAN GROUND and WALKING PACE in a hard-coded sentence; a third pack would have
  been held correctly and reported nowhere. Summaries that cannot go stale, or they are
  decoration.
- 2026-10-12 — **When a model built to serve the prose contradicts the prose, change the
  prose.** The flood model gave ONE MORE ABOARD's Act Four eighteen minutes below decks where
  the text claimed thirty-five. The model was right and the act is better for it; the closing
  route is what makes the last choice forced rather than sentimental. That is what building a
  model is for.
- 2026-10-12 — **A short case is not a long case cut down; it is an execution clock.** ONE MORE
  ABOARD has no investigation act — the party arrives knowing the problem and the whole session
  is one location, one direction of travel and a visible clock. Picking a real two-and-a-half
  hours of history set the runtime for free.
- 2026-10-12 — **Price the good ending in refusals rather than rolls.** Six anchors intact is
  countable on the table, and every temptation to lose one is a person who needs it. No roll
  defends an anchor.
- 2026-10-12 — **Write the assertion from the shape of the failure, not the shape of the
  fix.** Three guards in one session were aimed at a hazard next to the real one; the worst
  existed to catch a mechanical data sweep and could not, because it asked whether the
  whole corpus was uniform when the hazard was one file. R-316.
- 2026-10-12 — **Declare the fact; never infer it from a proxy that happens to correlate.**
  Four candidates for "is this creature one of the things" all read as obviously correct
  and all were wrong, including the role-string prefix (23 different words, among them
  LIVESTOCK and ACT TWO). `system.anomalous` is declared, and the prefix demoted to the
  second opinion that has to agree. R-316.
- 2026-10-12 — **A feature that has a definition may not hold a second opinion about it.**
  The panic wound trigger gated on `actor.hasPlayerOwner` — obviously correct, and it
  fired for nobody, because `partyActors()` reads the active case file first and the live
  world's six agents are unowned. `died()` panicked the party correctly from the same
  file. Both were "right"; they disagreed about who the party is. R-315.
- 2026-10-12 — **A fixture you write to satisfy your own assertion agrees with your
  misunderstanding.** One panic rung shipped two implementations that did nothing, both
  passing live tests that ran the real code against objects the game cannot produce. What
  found it was copying a real pregen in a real world. Full chain in R-313; the
  transferable half is in `feedback-fixtures-encode-your-error`.
- 2026-10-12 — **Run the engine, do not grep it.** `tools/foundry-double.mjs` imports the
  system into node with a scripted dice queue; of six behavioural mutations, four are
  invisible to the regex guards. But a double cannot prove template rendering or that
  Foundry accepts a new `system.*` path — only a live world can, and an unknown path is
  dropped silently.
- 2026-10-11 — **A rule can be complete, documented, playtested and still never run.** Panic
  had six bands, seven triggers, five relief routes, a widget, a card, five tests and a GM-screen
  table, and one caller. The part that *was* wired — the band penalty in the roll stack — worked
  perfectly, which is why no one checked the rest. **Count the callers of anything that looks
  finished.** Fix: the escalating thing (the penalty) is reused as the difficulty of the new
  roll, so there is one number and no second table to drift.
- 2026-10-11 — **Scope a guard to the function that must act, and strip comments first.** Two new
  tests passed with the enforcement deleted: one matched the flag name left behind in a flavour
  string, one matched the comment explaining the clear it was checking for. Tightening the first
  immediately found a real hole — the top rung only printed. A guard that matches the word
  rather than the work is this project's recurring defect, now recorded against itself (R-311).
- 2026-10-07 — **A closed time loop answers rather than refuses.** RETURN WORKING was written
  on the hard loop (Tim's Option A): nothing on 4 November 1974 can be changed. The design fix
  for passivity is that every interference *lands* as something the table has already read in
  2026 — the occurrence book's first page, "tape 2 of 2, re-cut", a margin note in a hand the
  Department never identified. **A GM never says "you can't".** And the loop protects 1974, not
  the agents: inside the lock at 16:00 is fifty-two years, and a trapped agent becomes clause
  5(b)'s one admissible deposition at 87.
- 2026-10-07 — **No fight is a design position, and it has to be written down as one.** The
  house rule is that a fight gets measured before the paragraph about it is written, so a case
  with no encounter must say why (the villain cannot be hurt without softening the loop; the
  only other people on site are civilians in a queue; the clock is lethal without a die) and
  what would have to be measured if one were ever added.
- 2026-09-23 — **Put the moral problem on the far side of the players' success.** STANDING
  ORDER v2.0 holds the song back until after the table has persuaded a thousand people to
  surface, so the dilemma is a consequence they built rather than a puzzle handed to them.
  The price is discipline in Act Two: nothing there may leak the reveal. Its bureaucratic
  wall publishes its own rules (clause 5's three exhibits) so refusal reads as a solvable
  problem, not GM stonewalling.
- 2026-09-23 — **The posting says what it carries; the tier says how much.** A weapon names
  the skill that fires it, so the pairing table is the weapon and nothing can be issued that
  its holder cannot use. The same rule now puts body-plan declarations on the natural attacks:
  anatomy records that a creature has a head, not that the head has horns.
- 2026-09-23 — **One derivation in a module both sides import is most of a guarantee, not all
  of it.** The forge CLI and the Foundry panel call the same function from *different*
  catalogues, and a fallback that took the first usable entry made them disagree — the list
  arrives in declaration order from `content.mjs` and id order from the pack. A derivation may
  not depend on its caller's iteration order.
- 2026-09-23 — **A guard whose success line claims more than it checks.** `check-forge` read
  the hit-location table and never used it while printing "armed with something its body can
  use"; deleting the forge's body filter left all 450 rows green. Mutation-test every new
  guard — three plants, one caught, one real hole, one genuine no-op.
- 2026-09-09 — **`rules.mjs` is the ONLY rule authority**, imported by runtime and pack
  builder alike, so packs cannot be built under one rule and played under another. Read it
  before quoting any rule; the `design/` specs are review history, **not** current rules.
  Superseded there: HP is `ceil((CON+SIZ)/2)`, Major Wound `ceil(HP/2)`, hit locations are
  in, the agent chooses Reflex vs Deliberate, home worlds are gone.
- 2026-09-13 — **A reader that cannot see a marker is worse than no reader**, because whoever
  wrote it believes the thing is declared. Every marker reader tolerates case and spacing and
  carries a looser counter that names what the strict one could not parse.
- 2026-09-13 — **`docs/scenarios/` holds scenarios, playtest records and art sheets**, and
  only the first kind has live rolls. Classified by the document's own H1, never its
  filename; an unclassified document is fatal rather than silently dropped.
- 2026-09-13 — **Derived figures resolve against the rule, sampled figures against a
  baseline.** A pure function of `rules.mjs` is enumerated every build and never stored: a
  stored copy is a cache that goes stale, and it arrives with an `--update` able to silence a
  real disagreement between document and game.
- 2026-09-13 — **Measure at a cap nothing reaches, and refuse to record a truncated sweep.**
  `runFight` reports who is standing, not that it ran out of rounds, so every published fight
  figure had run at a 40-round default; one table understated a wipe by fourteen points with
  29% of runs unfinished.
- 2026-09-13 — **A structural check cannot see a rendering defect: render the artifact and
  look at it.** The handout pack's print rule zeroed `.sheet` padding, and `.slug` is
  absolutely positioned at `top:6mm`, so in print — and only in print — the GM filing slug
  landed on the first line of three of the four sheets. On screen it was perfect, and
  `check-handouts` was correct throughout: it holds structure (shared classes, columns, the
  41 mi line, the 11pt floor), and a collision between an absolute element and the flow is
  not structure. Print the pack before a convention, not after.
- 2026-09-13 — **Midjourney: naming a thing to exclude it puts it in, and a long `--no` list
  stalls the job outright.** "No birds, no sheep" produced livestock; "the grey is dust and not
  snow" produced snow. Separately, four prompts with ten or more `--no` terms never returned a
  grid while the same prompt with four came back in two minutes — indistinguishable from a
  banned word, so it will be misdiagnosed every time. Keep `--no` short, steer in the prompt.
- 2026-09-13 — **A verified figure lends its credibility to the sentence it stands in.**
  Re-deriving a peer's 4.90% exactly and inheriting their unchecked premise with it shipped a
  false claim. The arithmetic was never the part that could be wrong. The cheap check is
  *what does this figure need to be true in order to matter?* — sharper still, the scenario
  had no roll for it at all, so it was a right number with no question attached and the
  premise arrived to give it one.
- 2026-09-13 — **A guard that calls the good material broken is worse than one that misses a
  defect.** Scanning table cells without blanking citation comments reported ~130 correctly
  cited rows as unheld (`packs line.hollow6.hurt` contains a 6). A blind spot costs one wrong
  number; a false-positive storm teaches the reader to stop reading the output.
- 2026-09-13 — **Two rules each right can be a hole between them.** `check-cited` refuses a
  citation against a sample maximum because it moves a third on a re-seed; the document printed
  that same figure bare. Refusing the citation while printing the number left the least stable
  figure in the suite as the only one nothing held. Guards need to be read against each other,
  not only against the thing they guard.
- 2026-09-13 — **A guard checks what is marked; the defect lives in what is not.** A stale
  "median 24 rounds" survived every pass because it carried no citation marker, and
  `check-cited` can only resolve markers that exist. Fifth reader caught unable to see its
  own format, after cast declarations, beat tags, citation markers and `POWER:`.
- 2026-09-13 — **Bold means two different things and the guard has to know which.** In prose
  this corpus bolds what it publishes; inside a table it bolds the rows it wants read. Nine
  measurement columns mix bold with plain, every cell correctly cited. So `check-figures`
  reads bold in prose only and lets the column header rule inside tables — one guard, three
  readers, each silent where another is authoritative (R-307, the fold of `check-unmarked`).
- **Rewards accelerate, they never gate.** Two versions failed with something on the critical
  path behind a probability gate (once at P=1.7%).

**Gotchas**
- Guards run under **bun**: `npm test` → `bun run check`. Bare `bun test` runs bun's own
  runner and finds nothing.
- Foundry LevelDB packs: parent `items`/`pages`/`results` arrays must hold **ID strings, not
  objects**. Objects yield a pack that loads with zero embedded documents and no error.
- `check-scenarios` sweeps `tools/scenario-*` into the scenario corpus, so a tool with that
  prefix has its prose read as a scenario's. Cost one rename already (`declared-cast.mjs`).
- Derive HP from the weapon damage ladder, not the reverse — halving HP collapses the 1984
  damage values into one-hit kills.

Working-practice lessons this project taught live in the memory files, not here:
`feedback-assert-where-not-just-what` (a unique match protects the text you edit, never where
new text lands; and the cold read that found what seven passes of dice did not) and
`feedback-concurrent-agents` (never repeat a peer's figure back to them).

Related: [[rpg-skill]], [[gitea-timevans]], [[codex-cli]]
