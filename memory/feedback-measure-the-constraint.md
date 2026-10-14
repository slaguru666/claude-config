---
name: feedback-measure-the-constraint
description: When the user states a size constraint ("one page", "under 10 minutes"), render and count it — and then look at the result.
metadata:
  type: feedback
---

When a request carries a **size constraint** — one page, one screen, under a minute, fits on a
card — treat it as a measurement to be taken, not an adjective to aim at. FRESH WATER was
briefed as "no more than 1 page"; it read like one page in the editor and printed as **four**
A4 sides in the house style.

**Why:** the editor's line count is not the deliverable's page count, and the gap is large
enough to change the design. Four pages would have meant quietly shipping something that was
not what was asked for.

**How to apply:** render it with the real renderer and count. Then **look at the rendered
output**, because a page count of 1 is also what overflowing, clipped content reports — the
count can only tell you it did not spill onto a second page, never that everything is on the
first. Looking is also what reveals spare room worth filling. Same failure family as
[[feedback-hold-the-success-line]] and the flyer that reported "1 page" while still carrying a
stale headline. If the constraint cannot be met at the current density, change the density
deliberately and say so — do not silently redefine the unit.
