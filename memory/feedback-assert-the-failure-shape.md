---
name: feedback-assert-the-failure-shape
description: Write a guard's assertion from what the broken data or code would look like, not from the shape of the fix you just made — then prove it fails.
metadata:
  type: feedback
---

Write the assertion from the shape of the **failure**, not the shape of the fix.

Three guards in one RingBRP session were aimed at a hazard next to the real one:

- A tripwire for `WEAPONS.mass` being renamed checked the natural-attack set had not got
  *smaller*. A rename makes `Number(undefined ?? 0) === 0` true for everything, so the set
  gets **bigger** — 70 keys including every firearm — and a floor on its size never fires.
- A guard meant to catch a mechanical "mark everything true" data sweep asked whether the
  *whole corpus* was uniform. Sweeping one file left other files' `false` values intact, so
  the count never reached zero. The hazard was a file; the guard watched the corpus.
- A guard pinned the two call sites that held a rule, so when a third caller arrived and
  the rule correctly moved to the chokepoint, the guard passed while the property it named
  moved out from under it.

**Why:** right after fixing something you are holding the fix in your head, so the
assertion you reach for describes the fix — the line you wrote, the value you set, the
file you touched. The defect does not live there. It lives in whatever the data or code
looks like when the rule is *absent*, which is usually a different shape entirely and
often in the opposite direction.

**How to apply:** before writing the assertion, say out loud what the broken version
looks like — bigger or smaller, which file, which value, how many. Assert against that.
Then mutate the code or data to produce it and confirm the guard fails
([[feedback-guard-matches-the-hazard]], [[feedback-check-the-instrument]]). A guard that
has never failed is a guess. Prefer asserting a property over an implementation, and
prefer a second existing authority that must agree over a threshold you invented
([[feedback-one-definition-not-two]]).

Related: [[feedback-fixtures-encode-your-error]], [[ringbrp-project]]
