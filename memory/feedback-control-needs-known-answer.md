---
name: feedback-control-needs-known-answer
description: A control test must be a case whose answer you already know; re-running another unknown proves nothing
metadata:
  type: feedback
---

A control has to be a case whose answer you **already know**. Re-running a
second *unknown* is not a control, however carefully it is set up.

Spent a night on seven failing Midjourney prompts. The control I designed
re-sent one original prompt verbatim, reasoning that success would mean
"transient" and failure "reproducibly blocked". It could not distinguish either
from **the service being down** — and the log showed nothing had succeeded for
2.5 hours, so that was live. Re-sending the text of a job **known to have
succeeded an hour earlier** settled it in 42 seconds: it worked, so the bridge
was healthy and the failures were real.

**Why:** a test whose outcome is uninformative under a hypothesis you have not
excluded buys nothing, no matter how clean the setup looks. The question is not
"will this tell me something?" but "what does each outcome rule out?" — and a
case with a known answer rules out the instrument itself.

**How to apply:** before spending a costly test, name the outcome you expect
under *each* live hypothesis. If two hypotheses predict the same result, the
test is wasted — find the case where they diverge, which is usually the one you
have already seen work. Verify the instrument before trusting its verdict.
Related: [[feedback-check-the-instrument]], [[costly-diagnostic]],
[[infra-mj-banned-word-filter]].
