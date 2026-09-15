---
name: feedback-check-the-instrument
description: "A quiet result from a tool nobody has poked is not evidence — prove the detector fires before trusting its silence, and beware measurements the shell silently corrupts"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 64d58577-adfc-4033-b6dc-6a703dfdd201
  modified: 2026-09-14T21:57:37.967Z
---

Before reporting that something found nothing, prove the thing that found
nothing is capable of finding something.

**Why:** This has produced false "passes" repeatedly across sessions, and each
time the output was indistinguishable from a real success. `rsync -n` prints
nothing without `-i`, so a dry run used as evidence compared two empty outputs.
macOS has no `timeout`, so a mutation sweep wrapped in it ran nothing and read
as clean. **A second session did exactly this again on 2026-09-15 having read
this memory** — knowing the rule did not stop them reaching for the tool it
warns about, because the reach is a reflex and the rule is a fact. So here is
the substitute rather than only the warning, verified on this Mac (`timeout`
and `gtimeout` both absent, `/usr/bin/perl` present):

    perl -e 'alarm shift @ARGV; exec @ARGV' 30 <your command>

It exits 142 when the cap fires, so the cap is detectable rather than silent.
Verified again independently on 2026-09-15: `sleep 30` capped at 2s exits 142,
a fast command exits 0.

A browser console that reports no CSP violation reports exactly the same thing
when the capture is broken.

Worse are measurements the shell corrupts on the way back. **`$(...)` command
substitution strips NUL bytes**, so counting them through a substitution
reports zero for a file that has them. In the Corkboard repo this made two
sessions at once conclude that git's binary detection "uses more than NUL byte
checking" — the file had a NUL, the measurement did not survive the pipe.
Write the bytes to a file and measure the file.

**The sweep itself is an instrument, and it needs the same treatment.** Writing a
test for a surviving mutant and *catching* that mutant are different facts, one
command apart — always re-run the mutant against the new test rather than
assuming a test written for it works. Two ways this failed in one session
(2026-09-15, corkboard): a peer's new test passed for the wrong reason, because
the row they planted to exercise a count also conflicted, so the rule refused
the call before the count was ever reached; and a survivor I nearly recorded as
equivalent was not — dropping `order by base` from a query is invisible only
because the planner picks an index scan on a PK that happens to be in that
order. Forced to a seq scan after an UPDATE moved tuples, the same rows came
back `[2,3,4,0,1]`. **"It comes back ordered" is a plan, not a guarantee** —
and the argument that insertion order already IS key order, sound for an
in-memory fake, does not transfer to a database.

**How to apply:** Fire the detector deliberately before trusting its silence —
introduce the violation, break the thing, plant the string — and confirm it is
seen. If a check cannot be made to fail on demand, it is not yet a check; say
what it does and does not cover rather than reporting it as a pass. When a
measurement disagrees with itself between two commands, stop and re-measure
before drawing any conclusion from either. Related: [[feedback-verify-the-neighbours]],
[[feedback-fuzz-cannot-generate]], [[feedback-concurrent-agents]].
