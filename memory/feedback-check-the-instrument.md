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
as clean. A browser console that reports no CSP violation reports exactly the
same thing when the capture is broken.

Worse are measurements the shell corrupts on the way back. **`$(...)` command
substitution strips NUL bytes**, so counting them through a substitution
reports zero for a file that has them. In the Corkboard repo this made two
sessions at once conclude that git's binary detection "uses more than NUL byte
checking" — the file had a NUL, the measurement did not survive the pipe.
Write the bytes to a file and measure the file.

**How to apply:** Fire the detector deliberately before trusting its silence —
introduce the violation, break the thing, plant the string — and confirm it is
seen. If a check cannot be made to fail on demand, it is not yet a check; say
what it does and does not cover rather than reporting it as a pass. When a
measurement disagrees with itself between two commands, stop and re-measure
before drawing any conclusion from either. Related: [[feedback-verify-the-neighbours]],
[[feedback-fuzz-cannot-generate]], [[feedback-concurrent-agents]].
