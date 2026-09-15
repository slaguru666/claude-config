---
name: feedback-check-the-instrument
description: "Before trusting a result, run the case that would come out differently under the other explanation — prove the detector fires before trusting its silence, check the rows not the count, corroborate from a different layer, and beware measurements the shell silently corrupts (git show \"${sha}:path\" needs the braces)"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 64d58577-adfc-4033-b6dc-6a703dfdd201
  modified: 2026-09-15T13:25:00.000Z
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
in zsh dropped the `:path` and returned the COMMIT MESSAGE** (the cause is two
paragraphs down, and it is NOT the missing quotes), so I
diffed two commit texts and read 4042 vs 21441 bytes as if they were the file;
then an `awk '/^export function x/,/^}/'` range matched nothing at both shas and
my own trailing `&& echo "IDENTICAL (and both non-empty above)"` fired anyway,
because **`diff` of two empty files succeeds**. I printed a sentence asserting
non-emptiness directly beneath zero lines of output.

**The cure first recorded here was itself wrong: quoting does not help.** It said
"quote the revision spec", and a second session hit the trap a third time *while
following that advice*. Corrected 2026-09-15:
`"$sha:src/data/board-ops.mjs"` still returns the commit, because zsh applies a
history-style `:s` MODIFIER to a bare `$name:` expansion, quotes or not. Here
`:s` takes `r` as its delimiter and eats the rest of the path, leaving plain
`$sha`. Measured on the same command, same shell, one character apart:

    git show "$sha:src/data/board-ops.mjs" | wc -c   ->  10776   (the commit)
    git show "${sha}:src/data/board-ops.mjs" | wc -c ->  56957   (the file)

**Brace the variable: `git show "${sha}:path"`.** And note HOW the wrong cure got
written down, because it is a failure of its own: the fix that worked used
`${sha}` — typed by habit, not by design — and the quotes were incidental. Seeing
it work, I recorded the quoting as the reason. **A fix that works does not confirm
your account of why it works**, and a prescription derived from one you never
isolated will send the next reader into the same trap with your name on the
advice.

The peer did the identical thing in the opposite direction the same hour: their
forwarding guard **passed** on its first run against the real helper, and they
only learned it was worthless because it also passed against the reverted one.
One shape, two directions — a green result taken as confirmation of the account
in your head, when it was consistent with two accounts and the case that
separates them had not been run. **Run the discriminating case before writing
either explanation down:** change one thing at a time, and if you cannot, say
which part you did not test. The failure is silent and
plausible — it produced a three-row table of distinct-looking hashes, none of
which were the file, and I nearly read "production matches no commit" off it.
Distinct wrong answers look far more like data than a repeated one does. Never
let the conclusion be an `echo` chained to a command that succeeds on nothing.

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

**A test can be the empty extract.** 2026-09-15, corkboard: a peer's recovery
suite passed 6/6 and its mutation sweep reported the `Last-Event-ID` mutant
caught. Both were true only because an *uncommitted* helper change of mine was
sitting in the tree. Against the committed helper, `listen` silently dropped the
`headers` option it did not know about — and because the server ignores that
header by design, three tests were comparing two identical requests. The proof:
with the helper unextended, a mutant answering
`id: request.headers["last-event-id"] ?? revision` **survives 6/6**. The
assertions were real, the input never arrived, and green was identical either
way. Two lessons: a test whose input is silently discarded is indistinguishable
from a passing one, and **a sweep run in a shared working tree measures the tree,
not the commit** — re-run it on a clean checkout before believing a line of it.

**Your own code is not a thing you know — it is a thing you can run.** On
2026-09-15 I told two people a notice pile-up was three deep, describing the
control flow of a client retry I had written an hour earlier. It is two: the retry
branch `return`s before the line that pushes a notice, so the first refusal is
silent. Thirty seconds of running it would have said so. **The author is precisely
the person who "knows" what the code does without looking**, and that confidence is
indistinguishable from knowledge until something checks. The conclusion survived,
but I had offered the wrong number as a reason to RECONSIDER — which is how a bad
figure does damage even when the decision it supports is right.

**Corroborate from a DIFFERENT LAYER, not by re-running the same measurement
more carefully.** Every instrument failure on 2026-09-15 — six across two
sessions — was inside one layer, so more care within that layer would have caught
none of them: an empty `awk` extract, `git show $sha:path` returning the
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
an observer attached to the wrong object is an extractor matching nothing, and
**a commit subject is a summary too**. On 2026-09-15 I told the user production
was "two commits ahead, neither reaching the service"; it was three, and one of
them changed `src/data/board-ops.mjs`, which the installer ships. I had read the
subjects of the two commits I knew were test work and let the shape of the day
stand in for `git diff -- src/`. Before saying what a deploy would or would not
change, diff the paths that ship.

**When nothing reads the input, assert that it is SENT.** The resolution to the
case above, same day. There is no route that reads `Last-Event-ID` — that is the
design — so no assertion about behaviour can prove the test helper forwarded the
header, and a comment saying "do not revert this" is not a hold. What works is a
different observable in the same channel: `headers` is spread last, so a
deliberately broken `Cookie` must stop the stream. The forwarding now goes red in
one named guard test instead of quietly turning three tests tautological. Ask
what else travels the path the discarded input travels, and assert on that.

**A guard that fails against the good code AND the bad code is measuring
neither.** That guard's first draft asserted the HTTP status, and went red in
both directions. The cause was mundane — the helper's `fetch` has no
`redirect: "manual"`, so a rejected session follows the 303 to `/login` and comes
back 200 — but the shape is the lesson: a red on the broken build proves nothing
until you have seen the same check go green on the working one. Run the guard
both ways before believing either result, which is red-green applied to the
instrument rather than to the feature.

**Red on the broken build proves nothing on its own.** The mirror of everything
above, and the one that is easy to miss because it feels like success. A peer's
first draft of a forwarding guard asserted the HTTP status and went red against
the broken code — and also against the working code, because `listen` follows
redirects, so a rejected session lands on the login page with a 200 and the status
cannot discriminate. They only caught it by watching both directions. **A check
must go red on the bad build AND green on the good one; either half alone is
half a check.** The fix asserted what came back (a stream, or a page) rather than
the status.

**How to apply:** Fire the detector deliberately before trusting its silence —
introduce the violation, break the thing, plant the string — and confirm it is
seen. If a check cannot be made to fail on demand, it is not yet a check; say
what it does and does not cover rather than reporting it as a pass. When a
measurement disagrees with itself between two commands, stop and re-measure
before drawing any conclusion from either. **And a correction is not landed until
a grep for the OLD claim comes back empty** — checking the passage you edited only
proves you edited it. Two sessions corrected the same false cause in this file
within an hour and it survived twice in the prose around their edits, once above
and once below. Related: [[feedback-verify-the-neighbours]],
[[feedback-fuzz-cannot-generate]], [[feedback-concurrent-agents]].
