---
name: feedback-fuzz-cannot-generate
description: A fuzz or property test proves nothing about a shape of event it cannot generate; say what the harness models, not just how many cases it ran
metadata:
  type: feedback
---

Do not report a clean fuzz as evidence of absence without saying what the
harness can actually produce. In corkboard I ran 86,924 undos, found no
escape, and wrote that the commit-window race was unreachable. Codex found
it on the next round: the harness had never modelled an interleaving *inside*
the `await page.update()` window, so the defect was outside its reach by
construction. The count was large and completely irrelevant.

**Why:** a big sample number reads as strong evidence and hides the real
question, which is the shape of the space sampled. Twice now a guard has been
justified by a fuzz that could not have contradicted it.

A second, sharper case the same day. A detached Foundry window would not drag
cards. I fixed it twice, and both times built a harness that proved the fix —
because I built the harness from my own assumption of the order of events. The
real order, in `ApplicationV2._insertElement`, queues the adopt on a semaphore
so it runs AFTER `_onRender`; my harness adopted first and then bound. Under the
real order the fix delivered `[]`. Reading the ordering in the source took two
minutes and would have replaced both attempts.

**How to apply:** when reporting a fuzz or property run, state the generator's
range in the same breath as the result — "n runs over these fields, these
orderings, these concurrent writers" — and name at least one shape it cannot
produce. Before claiming a path is unreachable, check whether the harness
could have reached it at all. When the bug is about ORDER, read the order in the
framework's source before writing the test — a harness that encodes your guess
about the sequence can only ever confirm it. Related: [[feedback-verify-the-neighbours]],
[[feedback-codex-review-loop]].
