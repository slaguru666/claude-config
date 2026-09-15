---
name: feedback-check-the-instrument
description: "A quiet result from a tool nobody has poked is not evidence — prove the detector fires before trusting its silence, and beware measurements the shell silently corrupts"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 64d58577-adfc-4033-b6dc-6a703dfdd201
  modified: 2026-09-15T11:35:00.000Z
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

**The extractor is an instrument too, and an empty extract reads as agreement.**
On 2026-09-15 two sessions did this within ten minutes of each other, comparing
the same function across two shas. A peer's extractor matched nothing twice and
printed `da39a3ee5e6b4b0d` — the SHA-1 of the empty string — then said
"IDENTICAL". Mine failed two different ways in a row: **`git show $sha:path`
unquoted in zsh dropped the `:path` and returned the COMMIT MESSAGE**, so I
diffed two commit texts and read 4042 vs 21441 bytes as if they were the file;
then an `awk '/^export function x/,/^}/'` range matched nothing at both shas and
my own trailing `&& echo "IDENTICAL (and both non-empty above)"` fired anyway,
because **`diff` of two empty files succeeds**. I printed a sentence asserting
non-emptiness directly beneath zero lines of output. Quote the revision spec
(`git show "$sha:path"`), and never let the conclusion be an `echo` chained to a
command that succeeds on nothing.

Two habits that would have caught all four failures, and cost nothing:

    # 1. make the instrument show its work
    cat /tmp/extract.txt
    # 2. refuse to compare when there is nothing to compare
    [ -s a ] && [ -s b ] || { echo "REFUSING: an extract is empty"; exit 1; }

A comparison is only evidence once you have seen what was compared.

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

**Corroborate from a DIFFERENT LAYER, not by re-running the same measurement
more carefully.** Every instrument failure on 2026-09-15 — six across two
sessions — was inside one layer, so more care within that layer would have caught
none of them: an empty `awk` extract, `git show $sha:path` unquoted returning the
commit message, a log filter whose `1[3-9]:` matched the MINUTE field, a
MutationObserver on a node the redraw replaces, a `window.fetch` wrapper the app
outruns by holding its own reference from module load, and a `journalctl` that
physically cannot see per-request traffic.

What worked every time was dropping a layer. A peer counted redraws **inside**
the page and could in principle have been watching a page redraw itself; nginx's
access log showed **two `/events` connections at 92,164 bytes each, identical** —
bytes crossing the proxy to two clients, outside the app entirely. Same fact, one
layer down, and immune to every failure above. Likewise: the box's `src/` tree
digest beats reading a deploy script's output, and printing the rows beats
trusting the count. **A total is a claim about data you have stopped looking at.**

"Check the rows, not the count" is the short form, and it generalises past logs —
an observer attached to the wrong object is an extractor matching nothing.

**How to apply:** Fire the detector deliberately before trusting its silence —
introduce the violation, break the thing, plant the string — and confirm it is
seen. If a check cannot be made to fail on demand, it is not yet a check; say
what it does and does not cover rather than reporting it as a pass. When a
measurement disagrees with itself between two commands, stop and re-measure
before drawing any conclusion from either. Related: [[feedback-verify-the-neighbours]],
[[feedback-fuzz-cannot-generate]], [[feedback-concurrent-agents]].
