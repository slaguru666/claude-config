---
name: infra-mj-banned-word-filter
description: Midjourney silently drops jobs containing banned words like "bare"; it looks like a timeout, and substrings count ("abreast")
metadata:
  type: reference
---

Midjourney **silently never answers** a prompt containing a banned word. Via
the `mj-gen` Discord bridge this presents as the client's own **30m01s
timeout**, with no error and no refusal message — indistinguishable from a
hung job until you time it. Successes come back in **~40–55 s**, so the
duration alone classifies the failure.

The filter is a **nudity/body word list, matched as substrings**, and it fires
on wholly innocuous English:

- **`bare`** — "bare winter trees", "bare tabletop", "bare floorboards",
  "bare earth", "bare moorland". Present in 6 of 7 failing prompts, 0 of 39
  succeeding ones. Swapping it for *leafless / empty / uncovered / open* fixed
  them, same prompt otherwise.
- **`abreast`** — contains *breast*. The 7th failure, "waiting four abreast".

**Diagnosing it:** do not rewrite the subject. Diff the **vocabulary** of
failing prompts against known-successful ones — words appearing only in
failures — which is free and takes one command. Rewriting five prompts' subject
matter while keeping "bare" in every one cost five 30-minute timeouts and
yielded nothing.

Prompts are art-direction text for [[rpg-skill]] scenarios, queue at
`tools/art_queue.tsv`. Related: [[feedback-control-needs-known-answer]],
[[costly-diagnostic]], [[contingency-2027]].
