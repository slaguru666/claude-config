---
name: feedback-assert-where-not-just-what
description: "A unique-match assertion proves you edited the right text and says nothing about where new text landed — assert the result's container and ordinal, not the anchor"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 710730ff-4590-4412-82b8-d6ae6765d92b
  modified: 2026-09-13T15:08:42.543Z
---

When editing a file programmatically, **`assert count(anchor) == 1` is only half a check.**
Uniqueness proves you replaced the text you meant. For an *insertion* it proves nothing at
all: it says the anchor is unique, not that the anchor is the right place.

**Why:** the two failure modes it misses are both silent.

- **Wrong container.** Inserting immediately before a heading puts the text at the *end of
  the previous section*, not the start of the next one. On 2026-09-13 I did exactly this in
  the RingBRP repo — planted a decoy before `## Folklore` to prove a guard was scoped to its
  section, the decoy never left the preceding section, the guard passed, and I read that
  green as the guard working. The test proved nothing and nearly went into a report.
- **Wrong ordinal.** A peer session's `EXPOSURE` list said "five things", had six, and ran
  1, 2, 3, 4, 6, 5. Its edit asserted a unique match and got one. It survived two document
  versions, five guard additions and a sweep of every reader in the repo, and was found by a
  cold read in about a minute.

**How to apply:**

- After an insertion, assert the **result**, not the edit: which heading it now sits under,
  what the lines either side are, or the ordinal sequence of the list it joined. One line of
  Python either side of the write.
- `s.replace(anchor, new + anchor)` is the dangerous shape. Prefer anchoring on the *end* of
  the thing you mean to follow, or slicing at an index you computed from the container.
- Reading the written file back is not optional for structural edits — the assertion has to
  run against what is on disk, not against the string you built.
- Programmatic checks do not see ordering that only prose asserts. A list that counts itself
  ("five things") is not a format and should not get a guard; it wants a human reading it.
  Dice never read a heading, and neither does a regex.
- The generalisation: **a passing check whose premise was never established is worse than no
  check**, because it arrives carrying evidence. Same failure as
  [[feedback-verify-the-neighbours]] one level up.

Related: [[feedback-concurrent-agents]] for the shared-tree rules that make a mis-placed edit
expensive rather than merely wrong; [[ringbrp-project]] for the repo.
