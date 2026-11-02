---
name: feedback-read-the-per-game-record
description: Before a pipeline spends money, time or API jobs per item, the per-item record is an input, not documentation — a decision recorded four times is still unread if you never grep for it
metadata:
  type: feedback
---

Two games on the Contingency 2027 slate were recorded as **deliberately
art-free** in four separate places — both game READMEs (*"no art pipeline"*,
*"no art budget, no map"*), one outline's design intent (*"cheap on purpose …
no art"*), and the production tracker's own `n/a` in the Art column. I queued
ten Midjourney assets for them and generated seven before noticing. Every image
produced that session was for a game that was not supposed to have any.

**Why:** they were the slate's deliberate ballast — the two cheap builds that
made the other ten affordable. The decision was not buried or implicit; it was
stated four times in files I had already opened for other reasons. The cost of
checking was one grep. The cost of not checking was the whole session's
generation budget, plus a repo that now contradicts its own design record in the
one place it had been most explicit.

**How to apply:** when a pipeline is about to spend a real resource — money,
API jobs, wall-clock, a rate limit — on a **per-item** basis, read the per-item
record first and treat it as an input to the queue, not as documentation of it.
Grep for the negative case specifically (`art-free`, `no art`, `n/a`, `skip`,
`cheap`), because a decision *not* to do something leaves no artifact to trip
over later. And when you find you have already spent it: stop the remaining
spend, restore the record, and leave the output for the owner to decide on —
reversing generation is their call, not your cleanup.

Related: [[feedback-one-definition-not-two]], [[feedback-costly-diagnostic]],
[[contingency-2027]]
