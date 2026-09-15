---
name: feedback-guard-matches-the-hazard
description: "A guard must differ between the bad outcome and the good one — one that fires on the normal case refuses the job, one that passes during the failure is worse than none"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 4c6c6592-cb70-4a13-af73-1b5771ce78c2
  modified: 2026-09-15T10:11:26.363Z
---

Before adding a guard, precondition or hook, name the exact bad outcome and ask
whether the guard's answer actually differs between that outcome and the normal
one. Both failure directions happened on 2026-09-15, hours apart, in the same
piece of work.

**Fires on the normal case.** A build-from-the-index script, written precisely
to survive other sessions' uncommitted edits, was given a guard refusing to run
when any input file had unstaged changes. It fired instantly on a peer's dirty
file — the normal state of a tree three sessions write to — so the tool would
have been unusable exactly when it was needed. It was also checking the wrong
thing: the index is what a commit records, so a result computed over the index
is correct however much else is dirty.

**Passes during the failure, which is worse.** A peer proposed a pre-commit hook
comparing a fresh index build against the staged output. But all sessions share
one `.git`: a peer's staged file is in your commit already, so the hook would
rebuild a *correct* hash over their work and hand you a green check on a commit
that took their change under your message. It retires the attention that would
otherwise have caught it. The control that does cover that case was already in
force — stage by explicit path, read `git diff --cached`, unstage what is not
yours — and a mechanism beside it making the uncovered half look handled would
degrade it.

**How to apply:** state the bad outcome in one sentence, then check the guard
answers differently for it than for the ordinary case. If it answers the same,
it is decoration at best. Prefer strengthening the control that already covers
the hazard over adding a second one next to it. Related: [[feedback-check-the-instrument]]
(prove a detector fires before trusting its silence) and
[[feedback-fuzz-cannot-generate]] (a harness proves nothing about what it cannot
produce) — the same error in a test rather than in a control.
