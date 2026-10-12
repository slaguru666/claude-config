---
name: feedback-scope-the-document-check
description: A check that looks for a figure "somewhere in the file" is usually vacuous — scope it to the section that must carry the claim, then mutate inside that section
metadata:
  type: feedback
---

When writing a guard that holds a document to a derived figure, scope the search to the
**section that must carry the claim**, never the whole file. Then prove it by mutating
*inside that section* — a mutation elsewhere in the file proves nothing about it.

**Why:** holding a scenario's climax to quote two derived minutes, I asserted
`md.includes(minute)` against the whole document. Both minutes already appeared in a derived
table several hundred lines away, so the climax could have omitted them entirely and the guard
would have reported OK. My first mutation test passed the guard and looked like success; only
mutating within the section revealed the silence. A guard that cannot fail is worse than none,
because it reads as coverage.

**How to apply:** split the document on the section heading and assert against that slice, and
assert the slice is non-empty too (a heading rename otherwise silently empties it and the check
passes on an empty string). When mutating to prove the guard fires, edit the section the way a
real author would, not the first occurrence in the file — `replace(..., 1)` on a string that
appears several times mutates the wrong copy and the guard stays quiet for the wrong reason.
Related: [[feedback-guard-matches-the-hazard]], [[feedback-assert-the-failure-shape]],
[[feedback-assert-where-not-just-what]].
