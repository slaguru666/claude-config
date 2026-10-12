---
name: feedback-read-the-update-diff
description: Re-recording a frozen baseline is two different events — adding a row and changing a value; only the diff tells you which
metadata:
  type: feedback
---

A guard's `--update` that **adds** a row is a safe act. One that **changes** an existing
value has silently moved the thing the guard exists to hold still. The command prints the
same success line for both, so after any `--update` read the diff and say which happened.

**Why:** in the RingBRP repo three frozen artifacts gate the build (`lethality-baseline.json`,
`focus-baseline.json`, `figures-baseline.json`). Adding eight creatures needed re-recording all
three. Reading the diffs showed lethality gained 8 rows and changed nothing, focus gained 8 and
moved exactly two numbers — both population counts, 139→140 and 131→132 — and figures gained a
row at 0 while a document *left* the ratchet by gaining its first citations. Without the diff,
"baseline recorded" covers a re-record that quietly rewrote a figure some document still quotes,
which is the one failure the whole regime is built to prevent.

**How to apply:** after `--update`, `git diff --numstat <artifact>` then look at every `-` line.
Insertions-only is reportable as such. Any deletion needs a named reason before you commit it,
and "the guard asked me to re-record" is not one. Corollary: there may be more than one frozen
record — a green `check-lethality` did not stop `check-focus` refusing the same eight creatures.
Related: [[feedback-check-the-instrument]], [[feedback-verify-the-neighbours]].
