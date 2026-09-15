---
name: feedback-guarantee-not-argument
description: "An argument that is sound about one implementation is not evidence about another — ask whether the same guarantee exists, not whether the same reasoning applies"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 64d58577-adfc-4033-b6dc-6a703dfdd201
  modified: 2026-09-15T09:23:15.711Z
---

When reasoning carries from one implementation to another, the question is never
*does the same argument apply* — it is **does the same guarantee exist**.

Two instances in one day (2026-09-15, corkboard), in opposite directions, from
two different sessions:

- **An argument that something was impossible.** I told a peer that `changes`'s
  `(board_id, base)` primary key blocked spec §6 entirely: accepting two commits
  at base 7 is a unique violation, so the feature needs an `ALTER` the repo has
  no mechanism for. Sound — *given* that a merged commit is stored at the base
  the client claimed. That was an implementation choice I had mistaken for a
  requirement. Recording it at the **current** revision keeps one row per
  revision, leaves the key alone, and the feature shipped with no schema change
  at all. **A blocker is only a blocker under the design you were picturing.**
- **An argument that something was safe.** The same peer noted that an
  in-memory fake needs no `.sort()`, because rows are appended in revision order
  and insertion order therefore IS key order. True for an array. Carried across
  to Postgres by analogy — and a heap gives no such guarantee. `order by base`
  looked redundant only because the planner happened to pick an index scan on
  that very key; forced to a seq scan after an UPDATE moved tuples, the same
  rows came back `[2,3,4,0,1]`.

**Why:** neither felt like guessing. Both were real arguments, correctly
reasoned, about the wrong subject — which is what makes this different from
being careless, and why confidence is no defence against it. The tell is an
argument that was *established* somewhere else: a fake, a previous schema, the
other host, a sibling function.

**How to apply:** when you catch yourself saying "the same reasoning applies
here", stop and name the *mechanism* that would enforce it in the new place. If
you can't point at one — a constraint, an index, a type, a caller that cannot
emit the thing — the property is not guaranteed, it is merely happening. Then
either test it where it now lives, or write down that it is unproved. Prefer the
test: a note decays and a test does not. Related:
[[feedback-check-the-instrument]], [[feedback-verify-the-neighbours]],
[[feedback-fuzz-cannot-generate]].
