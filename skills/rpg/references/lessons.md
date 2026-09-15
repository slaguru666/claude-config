# Lessons Log

Living file. Append transferable lessons here (dated, one-line context) at the
end of any RPG work session; sync via `~/Git/claude-config/sync.sh`. Scenario-
specific facts belong in Graphiti, not here — this file is only for lessons
that will change how the *next* scenario is written.

**Promotion rule:** when a lesson gets written into a reference file or the
template, delete it from this log (git history keeps it) — otherwise this file
grows into a duplicate of the skill. Several 2026-07 entries below are already
encoded in the references; they stay as worked examples until the next pruning
pass.

## 2026-07 — AFTERIMAGE desk playtests (Blade Runner, Continuum 2026)

- **Answer the obvious professional move.** Players will always try the
  competent thing (field-scan the suspect, phone ahead to a contact, run a
  city-wide facial search). If the scenario's premise hinges on such a move,
  write its result explicitly — ideally as a sanctioned alternate route that
  rejoins the trail, never a stonewall. Improvised rulings here are the
  biggest holes playtests find.
- **A player's key relationship is a loaded gun.** If a pregen's relationship
  NPC guards a scenario target, decide in the text what happens when the
  player leverages the relationship early. Done right it *improves* the scene
  (the warned target is already spooked → better chase start).
- **Formalise staging for twin/duplicate reveals.** When two groups hold
  halves of a revelation, the NPC recites aloud while the GM hands the
  matching card at the same moment. Never let a player's skim carry the scene.
- **Idle pairs get jobs.** During any split set-piece, hand the sidelined
  players the obstacle/bystander material to run. Formalise it in the
  set-piece text.
- **Deploy pressure lines early.** The written "NPC checks a watch" beat goes
  in at the *first* sign of circular debate, not at the scheduled time.
- **List the compromise endings.** Playtests and real tables invent partial
  trades (wipe half the drive, surrender the copy). If a compromise is good,
  it goes in the choices table — players will find it again.
- **"On schedule with zero slack" is a fail.** Strangers run slower than any
  desk test. Keep pre-written cuts per act and take them early.
- **No-roll scenes need a sign.** If a beat is designed so no die roll
  resolves it (a confession that stays ambiguous), say so in the text —
  "no roll resolves this" — so the GM doesn't improvise one under pressure.

## 2026-07 — Day One consistency audit (BRP, real-London setting)

- **Real-city scenarios need a dedicated geography pass.** Check every compass
  direction, "across the river", landmark sightline, and named route against
  the actual map before calling a scenario ready — desk playtests won't catch
  these, but any local player will (Day One had a hospital on the wrong bank,
  a pier route through a tunnel that's past the destination, and a gatehouse
  on the wrong end of the bridge).
- **Grep the cast list for surname collisions between PCs and NPCs** — an
  audit's cheapest catch (Kira Osei-Mensah vs Fatima Osei), and it reliably
  confuses a convention table.
- **In-fiction timestamps deserve arithmetic checks.** If the text says "two
  hours before the alert", subtract the actual clock times; drafts drift as
  timelines get re-plotted.

## 2026-07 — Pregen roster rebuilds

- **Audit inherited rosters against the current scenario, not just the
  rules.** A mechanically-legal PC can still be skill-dead all night (a pilot
  in a scenario with no vehicles). Rebuild the lane, keep the flavour, flag
  the change for review.
- **Signature items with a tiny mechanic** (once/session stress heal on
  interaction) reliably produce unprompted table moments; pure-flavour items
  go unused and nobody minds — both outcomes are fine, so always include one.

## 2026-07 — Day One art production (mj-gen batch)

- **Midjourney silently blocks banned words even in negation.** "no visible
  gore" kills the job — the grid simply never arrives and the bridge times
  out. Write the positive form instead ("understated, nothing graphic").
- **Scene prompts drift photorealistic; style-lock them.** For the house ink
  style, lead with "hand-drawn pen and ink illustration, NOT a photograph"
  and append `--no photography, photorealism` — one dusk-boat prompt came
  back as a photo without it.
- **Maps are drawn, not generated.** MJ cannot do accurate labelled
  geography; a hand-styled SVG (rough displacement filter, handwriting font,
  cream paper) passes visually as sketch art and stays correct. Expect two
  or three label-collision passes in a browser before it's clean.

## 2026-07 — The Vain Crown build (house-system debut package)

- **A rulebook's pregens are not con pregens.** VANITY's five shipped without
  Vices — the system's own core engine. When packaging an included adventure
  for a slot, audit the pregens against the system's *incentive* mechanics,
  not just their stat legality.
- **Debut systems need a dice primer baked into the Intro** — one staged
  practice roll per player that doubles as the arrival scene, so teaching
  costs zero extra minutes and the first Stumble happens somewhere safe.
- **Give the villain a countdown table.** "Where is he now" per session-clock
  row makes lost time (a failed pathfinding roll) mean something concrete and
  lets fast tables genuinely change the finale's staging.
- **Silence from a generation pipeline is a diagnosis, not a delay.** When a
  batch goes quiet, check the actual channel/API for what the service said
  before waiting again — and keep a fallback asset source (the system's own
  existing art) so the package ships regardless.

## 2026-07 — Princes Bride rebuild (Dee Sanction, Continuum 2026)

- **Inherited multi-draft projects need a canon-reconciliation clause.** When
  source materials disagree (two different charm-givers, two Eleanors, a
  villain who is a fraud in one draft and a pragmatist in another), pick one
  canon, write it as a numbered Design-Intent item ("Canon reconciled: ..."),
  and list every superseded fact — otherwise the GM re-derives the
  contradictions at the table.
- **Verify the system against primary sources, not inherited quick-refs.** A
  project's own GM reference had an entirely different game's dice mechanic
  (PbtA 2d6 for a step-die Falter system). The character sheets + publisher's
  site are ground truth; the quick-ref is a hypothesis.
- **Run the set-piece on the system's own resolution mechanic.** The trial as
  an open Verdict Die (the game's step-up/step-down, made visible on the
  table) needed zero new rules and made evidence-presentation mechanical.
  Find the system's native verb before inventing subsystems.
- **Keep good inherited sheets; add an insert layer.** When existing pregens
  are printed and well-made but generic, don't rebuild — print per-agent
  mission inserts (private seam + dice crib + table-name conventions) that
  slip inside the sheets. Cheaper, and the sheets stay canon.

## 2026-07 — Silvery Moon rebuild (inherited-draft salvage)

- **Verify a period scenario's real-world facts, then decide: correct or
  canonize.** Silvery Moon's eclipse was astronomically impossible (new moon
  that night — checked against the real 1892 record). Correcting it would
  have cost the climax; canonizing the wrongness AS the horror (the moon that
  should not be there, proven by an almanac handout and an astronomer pregen)
  turned the draft's worst error into its best clue. Always check which move
  the fiction wants before reaching for the eraser.
- **Mine the draft's own margins for pregens.** The strongest pregen is often
  already in the text as a named-but-unused NPC (Dr. Lyle was the draft's own
  "recent collaborator"). Lift them before inventing.
- **When two source layers contradict (prose vs app data), reconcile so both
  are true** — Braddock "too afraid to act" AND "cult member" became a
  coerced member, which was stronger than either. Contradictions are usually
  two halves of a better fact.

## 2026-07 — The Con Desk (multi-slot convention tooling)

- **A convention weekend needs ONE entry point.** When several scenarios each
  have their own GM console, build a hub with the con's real schedule baked
  in: live-clock "up next / live now" badges, one-tap launches, and per-slot
  pack-the-bag checklists. Every console gets a ⌂ link home. The hub's
  relative links mean the whole repo folder must travel to the tablet
  together — say so in the README.
- **A contrarian pass earns its keep on the moves the GM prays nobody makes.**
  "Cross the river NOW" and "we go back for the van" were both one-line hooks
  until dice forced them; both became the best unwritten scenes. If a hook
  can be driven to, it needs a written destination and its cost said aloud.

## 2026-07 — Vain Crown big-table heroes (fixed-class-list systems)

- **When the system has a closed class list, big-table pregens are variant
  builds, not new classes.** Differentiate inside the class: a different
  fighting style (sword-and-board Bram vs two-handed Hedda), a different
  lane emphasis (stealth-killer Pinch vs thrown-blade showman Marlo), a
  different creed/spell loadout (sustain Wren vs control grave-warden
  Tobin). Show the audit math so the variants are provably legal.
- **Point the new Vices at the existing roster.** "A Rival — [existing PC]"
  only fires at player counts where both are dealt, which big-table extras
  guarantee. Doctrinal Pride vs the other cleric's creed, and a Glory-Hound
  pairing, gave every added seat built-in table chemistry for free.
- **Scale the set-piece with the roster on the card.** The deal-order note
  (6th/7th/8th) plus boss Grit per extra hero and mook multiplier lives ON
  the GM cut-out corner of the last hero card page, not buried in the doc.

## 2027-01 prep (2026-07) — continuity searches for returning NPCs

- **Grep the role, not just the name.** A returning NPC brief said "Witchfinder
  Garrett". Case-insensitive greps for `garrett` and `garret` both found
  nothing across every convention folder — the character is **Garratt**, from
  *The Princes Bride*. One wrong consonant nearly produced a scenario that
  contradicted its own prequel. Search the *role* (`witch finder`, `witchfinder`,
  `inquisitor`) and read the prior scenario's **NPC roster table** before
  concluding a character is new. Report "not found" as provisional, never as
  fact.
- **The prequel's early-finish Tangent is the sequel's premise, already
  written.** Every house scenario carries a bonus scene for tables that crack it
  early. Those scenes are hooks with the cost already priced — *The Princes
  Bride*'s crossroads offer (a ledger's blank column, a list of three villages,
  and "teach me what the meadowsweet meant") gave the sequel its inciting
  incident, its antagonist's arc, and its hardest ending, for free. **Check the
  Tangent first when writing any follow-up.**
- **A sequel that reuses the prequel's pregens should be built on their
  documented seams, not on the plot.** The prequel's Sanction-rhyme table
  already paired the forger with the evidence-making witch finder; building the
  new case so that pairing is its best scene costs nothing and is the whole
  payoff for returning players. Keep the house rule intact — every seam still
  needs a written alternate route so new players lose nothing but the echo.

## 2026-08 — OPEN DAY (The Custodians prologue, house system)

- **Write the recruitment prologue out of the pregens' own biography lines.** The
  ten "(before)" sheets each ended with a *How they found her/him* line. Two of
  them — a building that "stopped being on the street it was on" and a caller
  talked down "for eleven minutes" — were already the same incident, and the
  other eight fitted over it without a single edit to the plot. Build the
  prologue at the intersection of the existing seams and the scenario cannot
  contradict a sheet, because the sheets came first. **Read the whole roster's
  private lines before inventing an inciting incident.**
- **Reconcile the seams in both directions, and prefer changing the sheet.** One
  line said *night* and the scenario is an afternoon: one word on the pregen was
  the cheap fix, and both became true. Where a seam needed an event the scenario
  did not have (a casualty for the one who carries people out, an injury for the
  doctor), the honest move is to add the event, not to bend the seam.
- **A scenario where nothing is hostile needs that stated as a GM instruction, in
  the first page, three times.** The default GM reflex under pressure is to make
  something menacing. "Every figure is busy, polite or preoccupied" is a rule,
  not flavour.
- **Let them succeed and let the outcome not change.** For a fixed-timetable act,
  write explicitly that every intervention *works* mechanically and alters
  nothing — and that the GM must not have them fail instead. Failing is
  comforting, because failing implies succeeding would have helped.
- **Three unresolved things is the right number.** One is a loose end, two is a
  mystery the table will try to solve, four is untidy. Name them in the GM notes
  as *do not resolve* so a helpful GM does not answer them.
- **Midjourney will not stop putting lettering on a building.** "no text / no
  signage / no lettering" failed twice on a shopfront-shaped prompt. What worked:
  describe it as a *two-ink screen print*, name the two inks, say "flat pale
  yellow background instead of sky", and add "no shops". Palette drift and
  hallucinated signage are the same failure — the prompt was letting the model
  reach for a naturalistic reference photo.

## 2026-08 — LAST ADMISSION (simplifying a prologue that was too complex)

- **"Too complex" usually means too many things the GM must hold, not too much
  text.** OPEN DAY's load was a minute-by-minute timetable to narrate, three
  deliberate non-answers, and ten serial one-on-one scenes. The rewrite kept the
  same premise engine and cut to: one building, one truth, one decision, and
  three antagonists who each do one printed paragraph. Count the things the GM
  must *track*, not the pages.
- **Give an antagonist a page and let the players read it.** Printing the
  monsters' backstory as an in-world poster — and telling the GM to say it out
  loud — turns a puzzle into a game about scripts. Each one then gets a "script
  break" (put the person back in the room; say his name; go indoors) that is a
  complete answer costing nothing. Players who find one feel clever; the fight
  stays available for players who want it.
- **A haunted attraction is the cheapest way to hide the real thing.** A building
  full of paid performers pretending to be ghosts means "which of these is an
  actor" is the entire investigation and needs no explaining. It also supplies
  bystanders, a floor manager, a body, and a reason the players are all present.
- **Midjourney cannot count.** Two attempts at "exactly four name plates" both
  returned three, and the second also drifted photoreal. If a *count* is
  load-bearing in the fiction, it belongs in a handout, never in generated art —
  a picture that contradicts the clue is worse than no picture. Cut it and
  reassign the spare plate.
- **Draw the plan, don't prompt it.** (AFTERIMAGE v3.1, Sep 2026.) A scene map
  whose labels carry clues cannot be generated — Midjourney will not hold legible
  text or accurate geography. Hand-built SVG on a cream ground (rough displacement
  filter, monospace, an evidence tag block, hatch fills) reads as a real forensic
  plan, prints vector-sharp at any size and drops straight into Foundry. Two rules
  make it usable: **numbered callouts with a key below the drawing** instead of
  labels sprayed across the plan — that alone kills every collision — and the map
  says only what the *room* says. AFTERIMAGE's plan shows where the four cameras
  are and nothing about what is on them, because the recordings are the act's work.
- **A player-facing map is a turn-taking device.** Handing out the floorplan the
  moment they come through the door lets the table split *itself* into stations —
  which is what a one-location act needs to stop being one person narrating a room.
  Write the four-station split into the handout, not just the GM text.
- **When your document generates a package, verify the package, not the world.**
  A Foundry Adventure re-import does *not* overwrite documents already imported
  under the same ids: the package was correct, the world was stale, and every check
  I ran against the world was checking last week's build. Delete the adventure's
  ids from the world and import clean before believing any verification pass. The
  general rule: prove the artifact you built, then prove it *arrived*, and never
  let a green check on a cached copy stand in for either.
- **Rebalance the props when you rebalance the plot.** Restructuring the mystery
  silently invalidated the print pack: renumbered handouts, a corrected autopsy,
  and a drive index missing the partition the finale turns on. If the screen props
  and the paper props are separate documents, they are two chances to be wrong —
  put the handout text in one module and derive both, or diff them by hand every
  single revision.
- **Never put the climax's central lever behind a roll.** (AFTERIMAGE playtest 04,
  Sep 2026.) If the decisive move is a *fact* — something true, said out loud, in
  front of witnesses — then saying it works, full stop. Desk-tested the
  alternative: the players rolled to declare it, lost, and the GM had to improvise
  the most important exchange of the night on the spot. It turned to mush in four
  seconds. The fix is not a better roll, it is a different question: make the
  lever automatic and let the roll decide **how much the opposition salvages**,
  with a written row for every outcome *including* the one where the players lose.
  This is the house "rolls buy extra, never entry" rule, and the climax is exactly
  where it is most tempting and most costly to break.
- **The ending you steer the table toward must exist in the outcomes table.** If
  the act text spends a paragraph teaching the GM to let players build a
  particular ending, and the epilogue has no row for it, the GM improvises the
  last ten minutes of the game with four people watching. Write the row for the
  ending you *want*, not only the obvious ones.
- **Put a set-piece's designed ending on the rail, not on the die.** The chase's
  final location — candles, paper birds, its own commissioned plate — was obstacle
  result 6 on a d6, in a chase that lasted two rounds. It had about a 30% chance
  of ever appearing. If you wrote the place it ends, that is where it ends;
  randomise the obstacles along the way, never the destination.
- **Do the arithmetic on a set-piece before you budget it.** A chase budgeted at
  "3–5 rounds, ~12 minutes" ran two rounds and six, because the system counted a
  10+ as two successes and one good throw crossed the entire range track. Work out
  the expected successes per round against the number of steps on the track, then
  either fix the budget or fix the track — and tell the GM in the text that a fast
  resolution is normal, so they don't stretch it artificially.
- **When a revision changes a fact, grep for the old conclusion.** Changing the
  autopsy from "the grip was human" to "the wound cannot rule anybody out" left
  four summaries — the revelations checklist, the pitch paragraph, and two columns
  of a clue table — still asserting the thing the evidence now refuses to say. A
  GM skims the checklist before play, so the stale summary is the one that reaches
  the table.
- **State the hard cut-to-the-climax time exactly once.** It appeared three times
  and disagreed with itself by twenty minutes. Same rule for any number a GM acts
  on under pressure.
- **Story time and session time must not share a notation.** A countdown table of
  in-fiction times (`01:45`) facing a timing table of session times (`1:45`) is a
  trap. Give fiction times a leading zero and an `hrs`, and label the column.
- **Decide whether Slot Zero is inside or outside the session clock, and say so in
  the Overview.** Four strangers take 15–20 minutes on safety, pitches and
  choosing. Whether that is inside the budget decides whether the scenario fits
  the slot, and it is not a detail the GM should have to adjudicate at the table.
- **When a check reports a section missing, look for it in the wrong shape before
  you write a new one.** Four scenarios failed "no Clue Trail anywhere". Two of
  them had the trail already — Day One's act two as a three-column table with no
  *How found* and no *Type*, Vain Crown's as "Trail of Vesper — Act One triggers"
  with a Fallback column — and both were invisible to a parser looking for the
  house headers. Writing fresh trails would have duplicated the GM's own material
  and quietly dropped the fallbacks he had already thought through. Read the act
  first; the absence a tool reports is a failure to *recognise*, not always a
  failure to *exist*.
- **A clue trail is an index of the act, not new invention.** The material is
  already in the scene text — it just isn't gathered where a GM can sweep it in
  one glance. Writing the trail surfaces the revelations with nowhere to live:
  Day One's Guy's Hospital view had its own Sanity roll and no row; Vain Crown's
  single most important warning ("the crown was made to be looked at — so don't")
  was buried inside a priest's NPC block. If a trail needs facts that are not in
  the act, that is a scene problem, not a table problem.
- **Put the trail where the reveal happens, even when the tooling only reads acts.**
  Chopper's load-bearing revelation is in an INTERLUDE between acts two and three,
  which act-scoped tooling cannot see. Moving it into an act to satisfy the parser
  would have moved it away from the ten minutes it belongs to. Write it where it
  plays and record the tooling gap instead.
- **The Revelations checklist is the section scenarios skip, and it is the one that
  survives contact with a real table.** Four of six had none. Writing them was not
  invention — every revelation was already somewhere in the acts — but gathering
  them abstracted from *where* they are found is what lets a GM carry an
  undelivered one forward instead of losing it with the scene that was cut. Write
  it with two named to drop first and one named never to drop; "never" is the more
  useful half, because it says what the evening is actually about.
- **A checklist that cites a Pacing Note obliges you to write that Pacing Note.**
  Princes Bride told the GM to "drop 12 and 14 first" from a ten-item list that had
  never been longer. Name the revelations, not their numbers — numbers go stale the
  first time anyone reorders the list, and the GM reads that line under pressure.
- **A Countdown buried inside another section is not a Countdown.** Day One's lived
  as "Master Timeline" inside Running This Scenario and Vain Crown's as a sub-head
  of the Plot Summary. Both were good tables in the wrong place: the Countdown is
  the universal third route to every essential clue, so it has to be where a GM
  reaches for it mid-session, not where it was convenient to draft it. A dated
  history of what already happened belongs in the Plot Summary; the during-play
  clock is a separate thing and a scenario can need both.

- **2026-09-15 — An optional chain over a config key that does not exist is a
  silent no-op.** Cast cards on the generated boards read portraits from
  `cfg.portraits?.[key]`; no config in the repo has a `portraits` map, so every
  lookup returned undefined and all four link cards shipped faceless — beside
  Actor sheets that had the portraits all along. Nothing failed, no warning
  fired, and the build reported success. When wiring a generator to config, take
  the value from the same place the working code already takes it (here, the
  cast entry the adapter itself uses) rather than inventing a key for it, and
  assert the value is *present*, not merely that the field exists.

- **2026-09-15 — A file that cannot be imported by a test is where a wrong name
  survives.** The predicate choosing which dialog a GM sees was written inside a
  Foundry-importing file, referencing a class name that does not exist in it.
  `node --check` passed, because an undefined identifier is a runtime error and
  not a syntax one, and that file is guarded only by source-text assertions,
  which cannot tell a real class name from an invented one. The fix was not to
  read the code more carefully — it was to move the function somewhere a test
  could call it. When a decision matters and lives somewhere untestable, move
  the decision, not the scrutiny.

- **2026-09-15 — A generated file cannot be made attributable by staging it by
  path.** A build step that reads the whole working tree writes a file whose
  contents depend on everybody's uncommitted edits, so `git add <that file>`
  stages a result computed over someone else's work — path-precision does not
  help. In a repo several sessions are writing to, this shipped a commit whose
  own sources did not produce the hash it published. Rebuild immediately before
  staging and confirm nothing else is dirty; better, generate such files at
  release time and have the test assert consistency rather than exact bytes.

- **2026-09-15 — `git checkout <file>` to undo a scratch edit will silently take
  real work with it.** During a mutation sweep on a file that also held ten
  minutes of uncommitted work, a checkout reverted both. Copy the file aside and
  restore from the copy; a checkout restores from the last commit, which is not
  the same thing as undoing what you just did.

- **2026-09-15 — A guard that fires on the condition the tool exists to handle
  is not a safety check, it is a refusal to do the job.** A build-from-the-index
  script written to survive other people's uncommitted edits was first given a
  guard refusing to run when any input file had unstaged changes. It fired
  immediately on exactly the situation it was built for. The guard was also
  checking the wrong thing — the index is what the commit records, so a result
  computed over the index is correct no matter what else is dirty. Before adding
  a precondition, ask whether the normal case satisfies it.

  **The mirror of it came up the same day and is worse.** A proposed pre-commit
  hook would have *passed* on the bad case: with a shared git index, a peer's
  staged file is already in your commit, so the hook would rebuild a correct
  hash over their work and hand you a green check on a commit that took their
  change under your message. A check that passes while the bad thing happens is
  worse than no check, because it retires the attention that would otherwise
  have caught it. Both halves are the same error — a guard not matched to the
  hazard — and the test for both is to name the exact bad outcome and ask
  whether the guard's answer differs between that outcome and the good one.
