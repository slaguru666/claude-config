---
name: feedback-measure-what-they-experience
description: When someone says they can't perceive what you claim to have built, measure the artefact they are actually using, not the one you made
metadata:
  type: feedback
---

Tim said "i do not hear background music, ???" after I had shipped twelve scored
trailer beds and verified them with spectral measurements.

The measurements were right. He was playing the **live trailers on the website**,
which I had deliberately not re-rendered yet — so he was correct too, about a
different file. Live measured **18.2%** of energy in the musical band; what I had
sent him measured **49.9%**.

**Why:** the instinct when challenged is to re-state the evidence for the thing
you built. That evidence was about files he had never opened. The useful move was
to measure *his* artefact — download the live URL and analyse it — which located
the mismatch in one step and showed he was not mistaken.

**How to apply:** when a user reports they cannot see, hear or find something you
believe you delivered, first establish *which copy they have*: the live one, the
one you sent, the local one, an old cached one. Measure that. Then hand them a
test that settles it in one action without needing to trust you — here, a
three-way A/B of the same thirty seconds (old mix, new mix, bed alone), with an
explicit statement of what each outcome would mean. Never lead with a defence of
the measurement. See [[feedback-check-the-instrument]] and
[[feedback-pushed-is-not-deployed]], which is the same error in another costume:
built, sent and deployed are three different places.
