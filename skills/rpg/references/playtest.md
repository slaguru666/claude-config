# Desk Playtest Protocol

A scenario is not "convention-ready" until it has survived desk playtests and
the fixes are applied and versioned. Three passes is the proven cadence:
full session (GM chair) → stress re-run of the weakest act → full session
(player chair, contrarian choices).

## Method

- **Full table simulation.** Run the scenario as GM *and* play every pregen as
  a distinct player archetype. The proven quartet:
  - the methodical veteran note-taker
  - the roleplay-first talker who never reads handouts silently
  - the quiet rules-literate tactician
  - the lore-digger who asks "can I check…?" constantly
- **Roll dice honestly** for every contested beat (physical dice or a fair
  roller). Fudged playtests produce fudged timing.
- **Log timing against the schedule** per section: planned vs actual, with the
  drift explained. Note where the break landed.
- **Play the players, not the script.** Ask the obvious professional questions
  ("I scan her", "can I phone ahead?", "I run the face against city feeds").
  Every improvised ruling the playtest forces is a hole in the text — the
  written scenario must absorb it.
- Later passes go **contrarian**: split the party wrong, skip the expected
  route, refuse the set-piece, shoot early. Verify the fast-tracks and
  contingencies actually work.

## The playtest document

One markdown file per pass in `playtest/`:

1. **Method header** — what was simulated, which version of the scenario
2. **Play log** by section — planned/actual minutes, what landed, what
   dragged, table quotes worth keeping, each problem flagged inline with ⚠
3. **Player-hat verdicts** — one line per player archetype, with a score
4. **Feedback summary / fix list** — numbered, prioritised, each fix stating
   the problem, the proposed text change, and where it goes. Nothing is
   rewritten inside the playtest doc itself.

## Applying fixes

- Apply fixes as a separate pass; bump the version (v1 → v2 → v2.1 …) and
  record in the README which playtest's fixes each version absorbed.
- Classify every ⚠ before fixing:
  - **Text hole** (a legitimate player move the scenario doesn't answer) →
    write the answer into the scenario, not the GM's head
  - **Timing** (a section runs hot) → pre-write the cut into the Pacing Note
  - **Staging** (a scene lands only if performed a specific way — e.g. an NPC
    must recite while the GM hands the card) → formalise the staging
    instruction in the scene
  - **Missing option** (players invented a compromise the text doesn't list) →
    add it to the choices/outcomes tables
- Timing target: full run inside the time budget with the drift noted. If a
  playtest lands on schedule "to the minute with zero slack", that is a
  **fail** for a real table of strangers — cut deeper.
- Convention-ready = full-session playtests from both chairs inside budget,
  multiple endings reached, art and handouts done, README status updated.

## Post-slot debrief (after the real convention run)

The con run is the highest-value data the system ever gets. Same day, ten
minutes, one file in `playtest/` (`<scenario>-con-run-<event>.md`):

- Timing actuals per act vs the table, and where the break landed
- Every improvised ruling (each one is a text hole — classify as above)
- Compromise endings or routes the table invented
- What confused players, what they quoted back, which handout landed hardest
- Verdict: what to fix before this scenario runs again

Then close the loop as usual: fix list → version bump → transferable lessons
appended to `lessons.md` → Graphiti.
