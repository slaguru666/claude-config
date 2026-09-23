---
name: feedback-verify-the-neighbours
description: "When you go to the code to check one claim, read the functions next to it — four errors in one session were found that way, never the claim itself"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 4c6c6592-cb70-4a13-af73-1b5771ce78c2
  modified: 2026-09-23T01:30:00.000Z
---

When verifying a claim, **read the neighbouring functions while you are in there.** On
2026-09-13, working on CLEAN GROUND in the RingBRP repo, four separate errors surfaced this
way across two sessions — and in every case the thing found was *not* the claim being
checked but the function next to it.

**Why:** the cost of verifying is almost entirely the cost of getting to where the code
lives. Once `rules.mjs` is open, the next function along is free. That is the cheapest
work available and in that session it paid four times.

**The sharpest instance, worth keeping as a pattern:** I shipped a sentence saying
combatants "go down at half their maximum hit points". Verified false — `conditionFor`
(`rules.mjs:1623`) puts someone down at **hp ≤ 2**; half max hp is `majorWoundFor`
(`:32`), a different rule that only decides how long a dying character lasts. A peer
session had independently written the *same invented rule* into its own log.

The reason it survived both of us reading the output: for a 10 hp creature,
`majorWoundFor` is 5 and the leg/abdomen/chest location capacities are *also* 5 — so on
the locations that get hit most, the invented rule returns the real rule's answer. The
fight narration prints "MAJOR WOUND · disabled" on one line, two unrelated rules firing
together and reading as one. They diverge only on arms and head (4 vs 5), and neither of
us had examined an arm.

**So: a generalisation that agrees with the output on the common case is worse than a
guess, because it arrives with real evidence.** Watching the thing work is not checking
the rule.

**2026-09-23 — the same bug three files apart, and what to do about it.** `spec.species`
was read to decide a creature's SHAPE in three tools. Every creature with a non-human body
carries `species: "baseline"` and says what it is in `bodyPlan`, so: `mj-queue` drew a
wingless gryphon, `make-portraits` drew a human silhouette for 48 creatures, and
`BESTIARY.md` published "26 of them are not human-shaped" when the number is 74. Each was
found by reading the neighbour of the one before — which worked three times and is exactly
why it should not be relied on a fourth.

**The upgrade to this lesson: when the neighbours keep having the same defect, stop reading
neighbours and make the shape of the defect checkable.** It was one line every time — a
shape function fed from `species` with no resolved plan on the line — so a guard was added
to `check-anatomy`. Proved by checking each file's parent commit out of git history and
watching the guard name that file at the line the fix touched: a mutation test against the
real defect rather than a planted one, which is the strongest form available and costs
nothing when the history is right there.

**How to apply:**

- Verify a correction rather than applying it — twice in that session a peer's correction
  was right but incomplete, and checking it found the larger error.
- Going to the file to check one thing, read what surrounds it. Budget for that.
- Distrust reconstructions of a rule you have only ever seen *working*. Both errors that
  session pointed the same direction — they made the fight easier than it is — because a
  fight you watched is one you survived reading.
- When two thresholds coincide on common inputs, find an input where they do not, and
  check there. That is the only place the difference is visible.
- **Count the instances.** One neighbour with the same bug is luck; three is a class, and a
  class is a guard. Ask what the defect looks like as a line of source — if you can say it
  in one sentence, it is checkable.
- **Mutation-test against history, not invention.** `git show <fix>~1:path > path`, run the
  new guard, restore. If it does not name that file at that line, the guard is measuring
  something else.

Related: [[feedback-concurrent-agents]] — the signal that an assumption inside a guard is
wrong is almost always somebody arriving with a different reason to care; you cannot audit
your own guards, because a passing guard and a guard asking the wrong question are the
same experience from inside the build. [[ringbrp-project]] for the repo.
