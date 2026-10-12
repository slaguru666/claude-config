---
name: feedback-one-definition-not-two
description: When a codebase already defines a concept, a second local test for it is a bug waiting for the right data — even when the second test reads as obviously correct.
metadata:
  type: feedback
---

A feature that already has a definition may not hold a second opinion about it.

RingBRP's panic wound trigger gated on `actor.hasPlayerOwner` — a reasonable guess at
"is this a PC?" in Foundry generally, with a comment saying "Creatures do not panic".
It fired for nobody. The system's own answer is `partyActors()`, which reads the active
case file first; in the live world all six agents sit in a case file with
`ownership: {default: 0}` and none are owned. `died()` panicked the party correctly from
`partyActors()` while `majorWoundRoll()`, fifteen hundred lines away, panicked no one.
Both lines read as right. They disagreed about who the party is.

**Why:** a local test for a concept the codebase has already named is not a shortcut, it
is a fork. It agrees with the real definition on the data you happen to have and diverges
on the data you don't — so it passes review, passes tests, and fails in the one world
that matters. The giveaway is that the second test is phrased in the host framework's
vocabulary (`hasPlayerOwner`) rather than the project's (`partyActors`).

**How to apply:** before writing a predicate, grep for whether the project already
answers that question — "who is the party", "what counts as active", "which users are
staff". If it does, call it. If two call sites must agree about something, they should be
reading one function, not two correct-looking expressions. When fixing one, check the
neighbours for the same concept spelled differently ([[feedback-verify-the-neighbours]]),
and remember a deliberately-different local test is fine when it is *doing a different
job* — RingBRP's `defaultRosterFor()` keeps an ownership test because it guesses who to
put *on* a case before a case file exists, and says so.

Related: [[feedback-fixtures-encode-your-error]], [[feedback-guarantee-not-argument]],
[[ringbrp-project]]
