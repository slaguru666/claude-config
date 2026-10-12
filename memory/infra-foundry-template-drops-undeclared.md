---
name: infra-foundry-template-drops-undeclared
description: Foundry silently discards an update to a system.* path template.json does not declare — so a field the engine writes and the schema does not know about passes every test and does nothing in the game
metadata:
  type: reference
---

In a Foundry system, `actor.update({"system.foo.bar": x})` is **silently discarded** if
`template.json` does not declare `foo.bar`. No error, no warning, no clue at the call site.

**Why it matters more than it sounds:** a test double has no schema, so the write appears to
work everywhere except the only place that counts. In RingBRP (R-320a) `panicSeverityRoll`
wrote `system.panic.outOf` and `system.panic.outOfToken`, neither was declared, and **all 57
live panic scenarios passed** while the two worst rows of the severity table — out of the
scene, out of the case — would have done nothing whatsoever at a real table.

**The general shape, which is the part to remember:** *a field the engine writes and the
schema does not declare is a feature that passes every test and does nothing in the game.*
The suite can only check the half of that sentence it can see. Same family as
[[feedback-fixtures-encode-your-error]] — the thing agreeing with you is not evidence.

**How to apply:**
- After adding any `system.*` write, open `template.json` and declare it in the same change.
- Guard it rather than remembering it. The guard that works reads the paths **out of the
  source** instead of listing them, so tomorrow's path is covered tomorrow:
  collect `/["'`]system\.<area>\.([A-Za-z0-9_]+)/` from the engine, assert each is a key in
  whichever template block declares `<area>`. Mutation-test by undeclaring one.
- Assert the reverse too: a declared field nothing reads is dead data on every document
  ([[feedback-hold-the-success-line]]). RingBRP carried `panic.max` long after the ceiling
  it described was deleted.
- A live world is still the only proof for rendering and for schema acceptance. Reading the
  built pack back is the cheap middle step — it catches text drift, not dropped writes.

Related: [[ringbrp-project]], [[infra-foundry-shutdown-kills-server]].
