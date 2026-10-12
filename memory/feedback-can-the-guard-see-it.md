---
name: feedback-can-the-guard-see-it
description: A guard keyed on a prefix or pattern is silent, not safe, about a file using the wrong one — and a count that doesn't move is the tell
metadata:
  type: feedback
---

Before trusting any guard that reads markers out of a document, confirm the guard can
**see** that document's markers. A reader keyed on a prefix reports green for a file whose
markers it never matched, and its success line will cheerfully describe a set your file is
not in.

**Why:** a RingBRP scenario tagged its rolls `[BR: …]` — the prefix from a different game the
same user writes for — while `check-scenarios` reads `[CUS: …]`. Not one roll in the document
had ever been checked, through a whole build-and-review cycle, while two guards printed *every
skill named resolves* and *every one reachable at 25% or better*. Neither was ever about that
file. Fixing the prefix moved the corpus count 210 → 218 and immediately surfaced four
malformed tags and three routes gated on skills nobody in the cast held.

**How to apply:** the tell is arithmetic — **add one instance of the thing being counted and
check the count moves.** If it doesn't, the reader isn't seeing your file. When adding a file
to a corpus a guard sweeps, verify inclusion before trusting the pass: compare its marker
syntax against a sibling file that is known green, not against the documentation. Corollary:
a literal example of a marker written in prose IS read as a live marker, and backticks may not
protect it — check which reader strips what. Related: [[feedback-hold-the-success-line]],
[[feedback-check-the-instrument]], [[feedback-read-the-update-diff]].
