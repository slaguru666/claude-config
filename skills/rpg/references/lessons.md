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
