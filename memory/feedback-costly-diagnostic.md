---
name: feedback-costly-diagnostic
description: Before running a diagnostic, check what it consumes — some cost exactly the thing they are diagnosing.
metadata:
  type: feedback
---

A Midjourney plate stalled mid-batch and the right tool for "pulled by moderation, or just
slow?" was `mj-blocked` — which answers **by sending a job of its own**, on a bridge that takes
one job at a time. Running it would have killed the plate it was there to explain, and the
diagnosis would have reported the failure it caused.

**Why:** a diagnostic is usually treated as free and read-only. Some are not: they take the
lock, the slot, the rate limit, or the single-threaded resource that the thing under
investigation is currently holding.

**How to apply:** before reaching for a diagnostic mid-flight, read what it actually does — one
look at the top of `mj-blocked` says "send, watch the channel for two minutes". If it consumes
the contended resource, either wait, or end the stalled job first and let the normal failure
path run. Related: [[feedback-check-the-instrument]] (prove the detector fires) and
[[midjourney_bridge]] (one job at a time; a queued second dies silently and exits 0).
