---
name: feedback-scoping-protects-one-direction
description: "Scoping a new stylesheet under a root class stops YOUR rules escaping; it does nothing to stop the old sheet's bare-class rules reaching in — measure every text node, don't read the CSS"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 710730ff-4590-4412-82b8-d6ae6765d92b
  modified: 2026-10-21T17:55:29.659Z
---

Building a second themed surface (a Registry-file character sheet beside an existing ultramarine one), the design said: scope every rule under `.rb-registry` and leave the shared `ringbrp-sheet` class off the form, and the two stylesheets cannot touch each other. Half true. Scoping stopped the new rules escaping. Dropping the shared class shed only the rules *scoped to that class* — and the old stylesheet coloured dozens of shared classes with **bare selectors** (`.rb-skill-val { color: var(--rb-white) }`), which match anywhere in the document. 58 skill percentages rendered white on buff at **1.15:1**: invisible, on the deliverable's main screen, with every guard green.

Specificity did not save it either. The new rule `.rb-registry .rb-skill-val` was higher-specificity and simply never declared `color` — specificity is irrelevant for a property you do not set.

**Why:** the fix I reached for first was overriding the classes I noticed, and noticing-by-reading is what produced the 58 in the first place. The durable fix is a *floor*: a zero-specificity blanket (`.rb-registry :where(*) { color: inherit; background-color: transparent }`) that beats every bare rule in the old file on load order and loses to every real rule in the new one. One at bare-class weight, one at two-class weight for the old file's `.rb-rail td`-style selectors.

**The floor covers the resting state only.** A day later a hovered table row still came through solid ultramarine: `:hover` adds a class-weight, so `.rb-table tbody tr:hover` (0-2-1) outranks a 0-2-0 floor. Any pseudo-class — `:hover`, `:focus`, `:checked`, `:disabled` — clears a floor built for the plain state, so set the floor and then give the new surface its own treatment for each interactive state rather than assuming they inherit it.

**How to apply:** when a second visual surface reuses another's markup, assume its stylesheet reaches in, and set a floor rather than a list. Verify by walking every rendered text node and computing contrast against its *composited* background — reading the CSS cannot find this, and a class list goes stale on the next class anybody colours. **Composite the alpha before believing a contrast number**: two of my eight remaining "failures" were a 12% red tint read as solid red, i.e. the instrument, not the page. Related: [[feedback-check-the-instrument]], [[feedback-can-the-guard-see-it]], [[infra-foundry-partials-render-empty]], [[ringbrp-project]].
