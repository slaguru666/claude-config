---
name: feedback-hold-the-success-line
description: The figures a guard prints about its own coverage are claims like any other — make them reconcile, or they will describe a different set from the one they count.
metadata:
  type: feedback
---

A guard's success line is a claim, and claims need holding too.

RingBRP's `check-creatures` printed "**129** agreeing with their own role category" against
**93** declarations — a coverage number larger than the set it described — because the loop
counted every spec with a determinate category whether it declared anything or not. Writing
the figure honestly exposed it. Holding the arithmetic as an invariant
(`crossChecked + inMixed + noCategory + outsideCatalogue === declared`) then immediately
found a *second* one: 92 against 93, because a scenario-cast spec declared the field from
outside the catalogue the loop walked, and nothing counted it.

Two real defects from one line of arithmetic, in numbers that had been printed confidently
for three commits.

**Why:** a passing guard's output is the only thing anyone reads, so a wrong number there
is worse than a wrong number in a comment — it is evidence, and it gets quoted into commit
messages and docs. And an inflated coverage count hides exactly the thing you want to know:
how much the guard has *stopped* covering. Coverage silently shrinks as data grows
([[feedback-assert-the-failure-shape]]); the success line is where that shows up first, if
it is true.

**How to apply:** when a guard reports counts, make them reconcile — every item it declares
must land in exactly one bucket, and assert the sum. Name what the number counts
("declarations compared", not "creatures"). When coverage is partial, print what is *not*
covered and why, rather than omitting it: a category that cross-checks nothing should say so
in the output. If a project already holds the figures in its prose against the code, the
figures its guards print about themselves deserve the same treatment.

Related: [[feedback-guard-matches-the-hazard]], [[feedback-one-definition-not-two]],
[[ringbrp-project]]
