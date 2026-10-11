---
name: feedback-fixtures-encode-your-error
description: A test fixture you write to satisfy your own assertion encodes your misunderstanding and agrees with itself — copy real data instead
metadata:
  type: feedback
---

Writing a rung of the RingBRP panic track, I shipped two implementations that did
nothing at all, and **both passed a live test that ran the real code**. The tests were
not weak about the behaviour — they asserted exactly the right outcome. The fixtures were
objects the game cannot produce: an actor holding a weapon with `raised: true` (a shield
flag), then one holding a weapon with a `plans` flag (which lives on the build-time
catalogue entry, never on the item document).

**Why:** the fixture and the code were written by the same person in the same hour out of
the same wrong model, so they agreed with each other perfectly. Running the code is not
the same as running it on the data the system actually makes — "I executed it" feels like
much stronger evidence than it is when I also authored its input.

**How to apply:** for anything that reads a document, a record or a row, build the fixture
by **copying a real one** (`{...realActor.toObject(), name: "TEST"}`, a real API response,
a row from the real table) rather than hand-writing the shape I believe it has. When a
field decides behaviour, print that field off real data once before trusting any test
about it — the thing that broke this chain was dumping Anneke's item flags and seeing the
field was simply absent. And when the rule depends on a correspondence between two
representations, assert the correspondence in a guard, don't assume it.

Related: [[feedback-check-the-instrument]], [[feedback-guard-matches-the-hazard]],
[[feedback-assert-where-not-just-what]], [[ringbrp-project]].
