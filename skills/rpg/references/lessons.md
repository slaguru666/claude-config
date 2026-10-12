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

- **2026-09-15 — A fallback inside a probe turns "cannot measure this" into a
  confident wrong answer.** Checking whether a GM-only board was visible to
  players, the probe read
  `testUserPermission(users.find(u => !u.isGM) ?? currentUser, "OBSERVER")` and
  returned `true`. The world had no player users, so `??` substituted the GM and
  the answer was about the wrong person entirely. Write probes that return null
  or throw when their subject is absent, and print the subject alongside the
  result so a substitution is visible.

- **2026-09-15 — "The player template" and "the read-only template" are not the
  same thing, and a GM lives in the second.** A provenance line was added only
  to the editing template on the reasoning that the other one was for players.
  In Foundry a GM opening a journal page gets the READ-ONLY rendering by
  default; edit mode is a deliberate extra click. The feature was correct,
  tested, and absent from the first place anyone looks. Before deciding a view
  is "not for the GM", check what the GM sees when they do the ordinary thing.

- **2026-09-15 — A rule about refusing something is untested until a fixture
  asks for the thing being refused.** A layout rule said card width is the
  grid's and never the card's; mutating it to honour the card's width passed the
  whole suite, because no fixture card asked to be wider than its slot. The same
  sweep had already produced this once that day, on preserve-lists for
  collections nothing generates yet. If a rule's job is to say no, write the
  case that asks.

- **2026-09-15 — Empty space on a card means whatever the frame promises.** Five
  cast cards were photo cards with no photo: a white polaroid frame reading as a
  missing picture. The same words in an index card read as room to write.
  Nothing about the information changed. When generated art looks unfinished,
  check whether the container is promising something the data cannot deliver,
  before adding data to fill it.

- **2026-09-15 — Where a clue is written is a pacing choice, not a statement
  about whether it counts.** A tool that read Clue Trails from numbered acts
  only lost an entire interlude's worth — four Essential clues carrying a
  scenario's central reveal — and the document validated clean, because nothing
  knew to look. If the house format allows a beat between acts (INTERLUDE,
  ESCAPE SEQUENCE), every reader that walks acts has the same hole. Check the
  siblings of any section-walking rule.

- **2026-09-15 — A rule that distinguishes things is untested until two things
  need distinguishing.** Matching clues to beats by act number passed the whole
  suite: a set-piece clue has no act number, so `null === null` quietly matched
  every set-piece clue to every set-piece — invisible with one set-piece in the
  fixture. Write the second one.

## 2026-09 — STANDING ORDER (The Custodians, first desk pass)

- **A fallback that requires the revelation it is a fallback for is not a
  fallback.** The essential revelation had a primary route, a "half-knows" NPC
  fallback, and a document. Both rolls failed and the document was in the
  dead woman's private quarters — findable only by someone who already knew she
  had written it, which is the thing the revelation tells you. The party finished
  never learning the scenario's central fact. **Trace every fallback back to what
  the player must already know to reach it.** If the answer is "the revelation",
  it is decoration. The fix was to move the document somewhere the party has an
  independent reason to be, and to add a route through the NPC who cannot refuse.
- **Audit the rating, not just the skill name.** A guard confirmed every skill
  was rollable at 25%+, and the essential revelation still sat behind the cast's
  best-in-party 40 — a coin flip on the moral centre of the case. Worse, the
  casting table credited that skill to the interview specialist as a *strength*
  when it was her joint-lowest. **Print the actual number beside the clue when
  casting, not the character's job title.** A one-line probe over the pregens'
  expanded sheets catches it in seconds.
- **A failure state much worse than the alternative is not a choice, it is a
  reflex.** Three real endings, and the moment the clever one failed its roll the
  table took the safe one in ninety seconds — resolving a fifty-minute act in
  eight, because deliberating while the world ends is not a thing players do. The
  fix is staging, not text: hold the antagonist's pen *above the paper* for one
  full round of table talk before the fall-through. **Write the pause in as an
  instruction, and say it is not optional.**
- **Put the person who knows the price in the room where the price is paid.** The
  NPC who had worked out what cancelling costs was two corridors away when the
  party cancelled, leaving the GM to choose between teleporting her in and letting
  them choose blind. **Scene-block your cost-bearing NPCs to the decision, not to
  their job.**
- **When a roll's failure produces the same world as its success, delete it or
  give it a consequence.** The stealth roll's failure triggered an event that
  fired on a timer regardless. The tactician noticed immediately and asked what
  it had bought. Re-cast it so the roll buys *when* rather than *whether*.
- **Honest dice are the whole point of a desk pass.** Six of ten rolls failed in
  act one and the act was untouched, which validated the "the witness points at
  everything she has been trying to show someone for four years" backstop far
  better than a clean run would have. A seeded roller (mulberry32, seed printed,
  rolls consumed in printed order) makes the run re-checkable rather than
  remembered — and re-checkable is what lets a later pass argue with this one.
- **Midjourney's margin lettering is unfixable on screen-print prompts, and that
  is sometimes fine.** Four suppression attempts left faint pencil-scale edition
  marks in the lower margins. They read as a printmaker's annotation and
  contradict nothing, so they were documented as accepted rather than fought.
  **The rule is not "no lettering", it is "no lettering that says something"** —
  the moment a plate grows legible text near a clue, regenerate it.
- **Prompt one plate before writing the sheet.** The first generation came back
  as a completely different structure from the one prompted (an adit portal, not
  a mushroom vent head) but in exactly the right register. Re-captioning it cost
  nothing and the art sheet recorded why, which is cheaper than fighting the model
  toward a picture the scenario did not actually need.

- **2026-09-16 — A rewrite inherits the old document's evidence, and most of it
  no longer applies.** STANDING ORDER v1.0 kept v0.7's site, people and act
  budgets, and the five desk passes that justified those budgets had tested a
  different plot. The status line has to say which lessons carry forward (and
  mark each one where it lands) and which measurements do not, or the
  "convention-ready" claim survives the rewrite that voided it.
- **2026-09-16 — When a scenario gains a fight, measure it before writing the
  paragraph about it.** Guessing the Act Two detention as "a scuffle" would
  have been wrong: the four-player cut, with no fighter in it, loses to four
  wardens more often than it wins. Measuring first turned the brief's "do this
  diplomatically" from flavour into the table's best option, and the GM text
  could say so with a cited figure.
- **2026-09-23 — Put the moral problem on the far side of the players' success.**
  STANDING ORDER v2.0 moves the song's reveal after the vote, so the table spends
  an act persuading a thousand people to come up and only then learns what
  surfacing costs. The dilemma stops being a puzzle presented to them and becomes
  a consequence they built, and Act Two's argument gains its weight retroactively.
  The cost is a discipline: nothing in the earlier act may leak the reveal, so
  every clue that used to point at it has to be rewritten to point somewhere else.
- **2026-09-23 — A bureaucratic wall needs published rules or it reads as GM
  stonewalling.** The Seat refuses modern evidence by clause 5 of its own Standing
  Order, and the players hold that clause in Act Two. Naming the three things the
  wall *will* accept turns "they won't listen" into a solvable problem and stops
  the committee scene becoming a monologue the table cannot act on.
- **2026-10-07 — A generator failure has three modes, and the cheap probe tells you
  which.** A Midjourney job that produces nothing is (1) a *refused prompt* — the bot
  posts nothing at all, because the refusal is ephemeral, so the client waits out its
  whole timeout; (2) a *slow service* — the bot posts, late; or (3) **a flagged image —
  the bot posts and then deletes its own post**, meaning the job started and was pulled
  mid-generation. Only (1) is a blocked word. For (3), rewording the description is the
  only lever: a `--no` list does not help and retrying does not either.
  **And before rewording anything, re-send a prompt that is known to have worked today.**
  If that fails too, the words are not the variable — a clean cutoff in the *clock*
  rather than in the *content* is an account-level state (exhausted hours, a moderation
  strike), and every minute spent rewording after that point is wasted. Six prompts were
  nearly rewritten on the assumption they each contained a blocked word; one probe with
  an already-successful prompt settled it in two minutes.
- **2026-10-07 — A closed time loop answers; it never refuses.** Writing a scenario where
  the past cannot be changed, the failure mode is a table told "you can't" until it stops
  trying. The fix is to prepare, in a table, what each interference *turns out to have
  been* — the warning becomes the rumour already in the record, the stolen tape becomes
  the "re-cut" line in the log the players read decades later. The GM never blocks; the
  loop absorbs. And the loop protects the *past*, not the characters: keep a real, lethal
  jeopardy (a door that shuts on a schedule) so the stakes are personal even though the
  history is fixed.
- **2026-10-07 — "No encounter" is a design position and has to be written down as one.**
  A house rule that every fight is measured before its paragraph is written does not mean
  every scenario needs a fight. A case with none should say why in the document — who
  cannot be fought without breaking the premise, who is a civilian, what the lethal
  pressure is instead — and state what would have to be measured if one were ever added.
  Otherwise the absence reads as an omission and the next writer quietly fills it.
- **2026-10-08 — When the art pipeline goes quiet, send a control prompt before theorising.**
  Thirty-two consecutive Midjourney jobs for one scenario produced nothing over four and a
  half hours, and the silence was diagnosed in turn as dropped submissions, exhausted fast
  hours, and a broken bridge. All three were wrong, and each cost an hour. A short neutral
  prompt — *"a plain grey stone on wet sand"* — returned a finished grid in thirty seconds
  and killed all three theories at once. **Keep one throwaway prompt that is known to work
  and send it the moment a batch starts failing.** It separates "the service is fine and
  your art direction is the problem" from everything else, which is the only split that
  changes what you do next. The HTTP checks that feel rigorous — token valid, channel
  readable, submission accepted — cannot make that split, because a successful submission
  and a doomed one return the same status.
- **2026-10-08 — A whole art direction can be refused while every prompt in it looks harmless.**
  Moderation that flags the *generated image* rather than the prompt escalates: a press that
  rendered six plates in the afternoon had everything pulled by evening, including a portrait
  of a man in an overcoat holding a clipboard. Bisecting words is the wrong tool — there is no
  bad word. **Soften the press, not the subject**: the same art direction with "horror" and
  "lurid" removed went through. And retrying is not a strategy against this; thirty-two
  attempts bought nothing that the first two did not already prove.
- **2026-10-08 — Name a new section in the FORMAT's vocabulary, not the fiction's.**
  AFTERIMAGE gained a jeopardy beat between Acts Two and Three, and calling it
  `ACT TWO-AND-A-HALF` was a silent collision: scenario-forge's `actNumber`
  matches `^act\s+([a-z]+)`, so `[a-z]+` stops at the hyphen, "two" resolves, and
  the new section claims act **2** alongside the real one. The format already had
  the right word — `set-piece`, aliased to *interlude*, documented as "a beat
  BETWEEN acts as often as one after them". **Run the parser over the heading
  before writing a hundred and fifty lines under it**; `node -e` over
  `parseSections` costs thirty seconds and prints exactly what the build will
  think. The same check caught a new `##` block as an unrecognised heading —
  which is the validator working, and the fix was to demote it into the section
  it already sat inside rather than widen a shared tool's alias list for one
  scenario.
- **2026-10-08 — Do not pipe a long-running probe through `tail`.**
  The control-prompt discipline from earlier today was followed correctly and
  then undone by the shell: `mj-gen ... | tail -5` buffers until EOF, so twenty
  minutes of `[mj-gen] still waiting... (Ns left)` went into a pipe nobody could
  read and the output file sat empty. The probe was fine; the instrument was
  blindfolded. **Redirect a progress-reporting probe to a file and `tail` the
  file**, never pipe the process. *(And note the real timeout before waiting on
  one: `~/.config/mj-bridge/config.json` sets `timeout_seconds: 1800`, so a dead
  job hangs for half an hour per stage, not the ten minutes the default suggests.)*
- **2026-10-08 — `mj-gen` exits 0 when it times out, and every house art script
  trusts that exit code.** The control prompt ran the full 1800s, printed
  `timed out waiting for grid`, and returned **0**. All eight `gen-*.sh` scripts
  in Continuum2026 log `DONE $name (exit $?)`, so a whole batch can read
  `DONE / exit 0` down the log and have produced not one image — which is very
  probably what some earlier "completed" runs actually did. **Check that a file
  landed (`ls "$out/$name"*`), never the status code**, and count the misses so
  the script says so at the end. Fixed in `gen-afterimage-interlude.sh`; the
  other seven still have it.
- **2026-10-08 — "Measure the fight" means measure the EXCHANGE, not the duel.**
  The house rule was followed and still produced a wrong paragraph. AFTERIMAGE's
  new set-piece compared the party's best shooter to one enemy — 1.43 expected
  successes against 0.98 — and concluded the straight fight was losable. It was
  not: there were *two* enemies and three guns on the other side, and simulating
  the actual round-by-round exchange put the party's win at 92–100%. A pool
  comparison answers "who is better at shooting", which is almost never the
  question. **Simulate rounds, with health, action economy and target priority,
  and report the spread rather than an average** — the useful number turned out
  to be not "do they win" (they always do) but "is the Health-4 detective
  standing at the end" (41%, or 69% if the GM-run ally keeps out of it). The
  playtest also exposed what the first measurement had hidden: whether that ally
  shoots was never written down, and it moved the headline figure by 28 points.
- **2026-10-08 — A set-piece that orders individual tracking must restate the
  win conditions.** The chase says "run pursuers as individuals, not as one
  grouped side" — correctly, it stops the specialist being benched — and then
  keeps Hide ("MEDIUM+") and escape ("prey reaches EXTREME") from the single-range
  version. Both broke inside two rounds of a desk run: a prey at SHORT from one
  pursuer and MEDIUM from another is in an undefined state. **Whenever a rule
  splits one number into several, re-read every rule that consumed the old one.**
- **2026-10-08 — The route your playtester declines is the one that needs playing.**
  Pass 05's tactician looked at AFTERIMAGE's "tell the broker where she'll be" and
  said no on the merits, which read as the trap working. It meant the branch had
  never been run, and when a *frightened* table took it in pass 06 the pier it
  produced had three holes in it — the betrayed NPC had no written reaction, the
  antagonist it summons arrived after the one party who made him irrelevant, and a
  contested roll could wipe the central object before anybody chose anything.
  **A branch declined by a competent player is untested, not validated.** Schedule
  the contrarian pass around the choice nobody made, and cast the hat that would
  make it — the cautious player and the frightened player are different tables.
- **2026-10-08 — Order your antagonists by who removes whose teeth.**
  Two opposed pressures arriving in the wrong order cancel instead of compounding:
  the unlicensed one turned up twenty minutes after the corporate one and simply
  withdrew, because a man with no warrant does not perform in front of a recording
  drone. The costly choice became an anticlimax. **The party with the least
  standing has to arrive first and be frightening alone**; the one with the legal
  claim arrives second as the lever. Same two NPCs, same scene, opposite outcome.
- **2026-10-08 — A nested blockquote reads as one read-aloud block.**
  Wrapping GM guidance round a `> >` speech turned two spoken sentences into an
  eleven-sentence read-aloud and tripped the house 3-sentence limit. Keep the
  spoken line at the top level as its own `>` and put the staging around it as
  plain text.
- **2026-10-08 (correction to the two entries above) — a control prompt is a
  sample of one, and it can be the casualty.** Both of today's earlier entries
  concluded "the bridge or the account is dead" because the known-good probe
  — *"a plain grey stone on wet sand"* — produced nothing in thirty minutes.
  **It was not dead.** Reading the Discord channel directly showed the bot had
  been answering all along; that specific job had rendered to **65% and stalled
  there**, and the message was still sitting at `(65%) (fast)` almost two hours
  later. Re-sent, the identical prompt round-tripped in **twenty-five seconds**.
  So: the control prompt still separates "your art direction is the problem"
  from everything else, but **a failed control prompt proves nothing on its own
  — retry it once before concluding anything.** And when it fails twice, do not
  theorise: **read the channel.** Author, timestamp and content of the last
  twenty messages tells you in one call whether the bot is answering, whether
  your jobs appear, and whether a job is stuck mid-render — which is the one
  state that looks exactly like a dead service from the client side and is not.
- **2026-10-09 — A repo that keeps a superseded builder keeps a loaded gun.**
  AFTERIMAGE's `sync-portraits.sh --build` ran the frozen hand-rolled `build.mjs`
  that scenario-forge replaced, which is retained only so forge's regression
  suite has something to diff against. It overwrote a forge install and silently
  dropped a whole journal and two actors; **the only symptom was a scene count
  one lower than expected** in output I nearly did not read. When a build is
  superseded, the convenience scripts around it have to be repointed in the same
  pass — a comment in the config saying "do not edit both" does not reach the
  helper two files over. And the portrait sync had a hardcoded name map with no
  entry for the new NPC, so his art silently did not copy: **any mapping keyed by
  hand is a place new content disappears quietly.**
- **2026-10-12 — Anchor a figure's size to something else in the frame.** Six plates of the same
  man at six distances failed twice. Describing the scene and putting him last — *"barely more
  than a mark on the paper"* — made the render leave him out altogether; that phrasing is an
  instruction to treat him as negligible and it is obeyed. Leading with him walked him up to the
  camera and dragged the whole image from an airbrushed poster into a grainy film still. **What
  works is a scale anchor: "no taller in the frame than the parked cars beside him."** Concrete,
  checkable, and it holds distance without losing the subject. Pair it with a `--no` list
  containing `close-up, portrait` whenever the subject is named first.
- **2026-10-12 — A dice pool cannot tell party compositions apart at one-shot scale.** A set piece
  built to test six pregens — nine doors, nine different locks, the right specialist scoring
  better — was measured three times across three party splits and scored 2.23/2.25/2.23, then
  3.76/3.57/3.52, then 3.35/3.22/3.32. Flat every time, because any three characters cover most
  skills between them and six rolls is too few for the spread to show. **If you want "we do not
  have the right person for this" to land, gate it in the fiction: this door does not open without
  her, and she is across town.** No roll. The composition becomes the mechanic.
- **2026-10-12 — Measure a set piece before you write its numbers, and expect the first design to
  be wrong.** The climax's first build — eight clauses, a death per failed track — killed 9.4
  civilians a run and failed the four-player cut 78% of the time. The second, five clauses with a
  clearable casualty queue, gave 93.2% and 63.6%. **Neither figure was guessable** and the first
  one would have shipped as a massacre. The corollary: commit the harness, not just the numbers,
  or the next person inherits a figure nobody can reproduce.
- **2026-10-12 — Write the shortcut your players will actually take.** A desk pass nearly ended in
  Act Two when a player with the solution in hand asked why they were waiting until the scripted
  night. The honest answer was "no reason", and the pass had to improvise a railroad, which the
  player spotted. **The fix is never to block it — it is to write what the climax looks like when
  it happens early.** A competent table finds the shortest path; a scenario that only works when
  they miss it is a scenario that works by luck.
- **2026-10-12 — Two handouts that must overlay are one geometry drawn twice, not two drawings
  to the same stated scale.** A case whose central scene is laying a 1986 street plan over a
  1971 site plan needs the two sheets in register, and "both at 1:1250" is not a guarantee —
  it is an intention that drifts the moment either sheet is edited. **Put everything in the
  shared feature's own coordinates** (here: distance along the old corridor, and distance
  across it) and compute the page position. Then there is only one frame and nothing to drift
  from. Add registration crosses at identical coordinates on both, and print at 100%.
- **2026-10-12 — A map that carries a mechanic needs a test, because it is code.** The overlay
  generator's `--check` holds eleven rules — the route never crosses ground it is forbidden to
  cross, the four houses named in a clue are the next four on it and the fifth is not, the two
  safe houses sit wholly on the old courtyard and off the route. Three of those caught faults
  that reading the drawing had not: worst was a dogleg that curled back into a terrace and took
  two houses the clue says it misses, which would have made a player-read handout contradict
  the text. **If the players will measure it, measure it first.**
- **2026-10-12 — Putting a date on a handout creates a question the text has to answer.** The
  moment eleven incident dates were printed on a player-facing plan, the document owed an
  answer to "why did eight of these take seven years and the next three take three nights?" —
  which nothing in it had. Props are not decoration: **every figure a handout shows is a
  question a player is now entitled to ask**, so read a new prop back as a player and answer
  what it raises before it reaches the table.
- **2026-10-12 — Typeset the prop early; it forces a precision prose lets you dodge.** A
  clipboard page that had read fine as a blockquote for three desk passes turned out, the
  moment it was set as a real form next to the map, to list three addresses that were not on
  the antagonist's route and to omit one that was. Prose can say "the next few houses" and
  survive; **a form has rows, and a player reads the rows against the map.** Anything a player
  will hold in their hand is a consistency test, so run it before the table does.
- **2026-10-12 — Handout text that lives in two places needs a guard, not good intentions.**
  The words are in the scenario a GM reads and in the HTML they print, and they drift silently
  — nobody proof-reads a pack against its own source. A check that every word of each printed
  sheet appears in the scenario costs about thirty lines and catches the edit that was only
  made in one of them. Prove it fails before trusting it to pass.
- **2026-10-12 — A short slot is not a long scenario cut down; it is an execution clock.** The
  house default is four hours with an investigation act, and halving that by trimming scenes
  produces a thin mystery rather than a fast game. The structure that actually works at two
  and a half hours is the inversion: **the party arrives already knowing the problem, and the
  whole session is execution against a clock they can see** — one location, one direction of
  travel, three beats, no break. And if the premise is a real event, **let its own duration set
  the runtime**: a disaster that took two hours and forty minutes is a two-hour-forty session
  at one minute to one minute, and the clock then needs no handout and no GM bookkeeping.
- **2026-10-12 — Price the best ending in refusals, not rolls.** A "perfect" outcome that hangs
  on dice is luck, and one that hangs on a clever single insight is a quiz. Make it an object
  count the players can see on the table — six things, still in six hands at the end — and then
  spend the session offering six good reasons to give one away, **each reason a named person
  with a real need and none of them the antagonist.** No roll defends the object; it is a
  decision, repeated. The table earns the good ending by being hard six times and being right,
  which is a thing they will remember arguing about.
- **2026-10-12 — Make the antagonist the helpful one.** A monster that stalks, hides or
  threatens turns identification into a search problem and the players into hunters. A monster
  that is courteous, useful and *always nearby* turns identification into a betrayal of someone
  the table likes, and it lets the confirming evidence be positional — plot where it has been
  and it has been beside you all night. **It also fixes the pacing**, because the thing can be
  on screen constantly without the scenario having to escalate.
- **2026-10-12 — Read the setting's own framing before designing the period.** Asked for a 1912
  case, I had most of an Edwardian branch of the organisation designed before checking, and the
  corpus does not work that way at all — agents go from the present through a crossing, with a
  standing order stripping their modern kit. Ten minutes of reading turned an invention that
  would have contradicted canon into **the engine of the scenario**: a door that works both ways
  is the one thing the antagonist has never been offered. The established mechanism is usually a
  better premise than the one you would have made up for it.
- **2026-10-12 — A model built to serve the prose will contradict the prose, and that is what it
  is for.** A map that carries a mechanic needs a model underneath it rather than a set of
  labels, and the moment there is one it starts answering questions you did not ask it. Act Four
  of a sinking-ship case claimed a route below decks from half past one to five past two; the
  flooding model gave eighteen minutes. **Change the prose, not the model** — the shortened
  window was better drama than the one I had written, because a route that closes is what makes
  the last choice forced instead of sentimental. If the model only ever agrees with you, it is
  decoration and you have learned nothing from building it.
- **2026-10-12 — Say so out loud when an assertion has become true by construction.** The check
  that mattered was "the suspect is within sight of the party at every sighting". Deriving the
  suspect's movements from the party's — the right fix, because two hand-maintained copies had
  already drifted — turned that assertion into a tautology. The guard is still worth keeping for
  its other half (that the innocent tracks are out of sight often enough for the pattern to
  mean anything), but **a comment has to say which half is evidence**, or a later reader takes
  the tautology for proof.
- **2026-10-12 — Put label placement in the data, not in the drawing code.** The first render of
  a generated prop printed two place names through each other and a third across a funnel, and
  the checker had nothing to say because placement lived in the draw calls. Give every label a
  lane and compute its width from the string, and collisions become arithmetic a rule can hold.
  **A prop a player cannot read is not a prop**, and "I looked at it and it seemed fine" is the
  same quality of evidence here as it is anywhere else.
- **2026-10-12 — A test harness that restores files must restore the one it broke, and nothing
  else.** Mutation-testing a handout pack, my probe loop copied back a backup of the *scenario*
  taken before I had written that session's handout text into it. Four probes then "fired"
  correctly while actually failing for a reason I had caused, and I was one careless glance from
  recording four proofs that were nothing of the kind. The tell was that the first probe's
  message named the right sheet and every later one named the same wrong sheet. **A backup taken
  before the edit under test is not a backup, it is a time bomb** — and a row of green or red
  that all says the same thing is a reason to check the instrument, not to feel finished.
- **2026-10-12 — A prop can pass every check and still be wrong, so print it and look at it.**
  The cancelled ticket that is the single piece of hard evidence in a case had its cancellation
  rule drawn straight through the name on it. Word-for-word agreement with the scenario: perfect.
  Font sizes: fine. **Legibility of the one thing the handout exists to say: not checkable, and
  not checked.** Render the pack, put the pages side by side, and read them as the player will,
  every time.
- **2026-10-12 — When a second thing needs the same check, write the function, not the paste.**
  A handout guard written for one scenario would have become two near-identical blocks the
  moment a second pack existed, and the copies drift — one learns about HTML entities or accented
  surnames and the other does not. One function called twice, parameterised by the pack. Related:
  **make the guard's success line say what it actually held**, or a pack can be checked correctly
  and reported nowhere.
- **2026-10-12 — Before calling a job stalled, put the clock in the same command as the
  evidence.** Mid-way through an art batch I checked the Discord queue, saw a generation message
  with no completion beside it, concluded the prompt had been refused, and killed the runner.
  The job was forty-seven seconds old and finished fine — the queue stamps its messages in UTC
  and the machine was on BST, so I was reading a one-hour offset as a nine-minute stall. **An
  absence only means something once you know how long it has been absent**, and a timestamp
  from somebody else's clock is not a measurement until you have put your own beside it.
- **2026-10-12 — A progress log that only prints on completion is not a progress log.** The
  first runner captured the generator's output instead of streaming it, so the log went silent
  for the whole minute each image takes and a slow job looked exactly like a dead one. That
  silence is what made the misreading above possible. **Stream long-running tools; buffer
  nothing you intend to watch.**
- **"Don't regenerate for being inaccurate" does not cover a plate that missed its moment.**
  The house rule for generated art is to accept period or technical wrongness and only re-roll
  for the wrong medium. But a plate of a sinking ship that came back floating level is not an
  inaccurate detail, it is the wrong instant — and the plate exists to show that instant.
  **Distinguish "wrong detail, keep" from "wrong subject, re-roll"**, and say which in the
  prompt sheet so the next person does not have to relitigate it.
- **2026-10-12 — When the harness finally answers, publish the answer AND the reading.** A
  stat block had carried a note saying *do not quote a figure for this until it has been
  measured*. Measured, it came back trivially killable: four agents floor it in two rounds and
  none of them goes down. The temptation is to treat that as a flaw and buff the thing. It was
  the design — the monster does not fight to win, it fights to be carried, and winning the
  fight hands it a fresh host. **A number alone is misread as a verdict**, so the figure now
  prints with the sentence that tells a GM what it means. If your measurement contradicts your
  prose, check which one is wrong before you change either.
- **2026-10-12 — A "Not built" list that lies about what is done is worse than no list.** Three
  of five lines still claimed the art, the bestiary entry and the harness figure were
  outstanding, hours after each landed. The list is the first thing a returning GM or author
  reads to decide what to do next, so a stale one sends them to work that is finished and hides
  the work that is not. **Trim it in the same commit that closes an item**, never in a sweep
  later.
