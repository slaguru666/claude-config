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
