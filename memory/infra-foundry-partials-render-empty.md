---
name: infra-foundry-partials-render-empty
description: "A Handlebars partial Foundry has not preloaded renders as the empty string — no error, no warning, and a compile-check still passes; add it to loadTemplates and guard the list"
metadata:
  node_type: memory
  type: reference
  originSessionId: 710730ff-4590-4412-82b8-d6ae6765d92b
  modified: 2026-10-21T17:55:42.399Z
---

In Foundry, `{{> "systems/<id>/templates/partials/x.hbs"}}` only works if that path was passed to `loadTemplates` (v13+: `foundry.applications.handlebars.loadTemplates`, with `globalThis.loadTemplates` as the fallback the RingBRP system uses). A partial that was never preloaded **renders as the empty string**: no exception, no console warning, nothing in the UI but a gap.

The trap is the guard. RingBRP's `check-templates` compiles every `.hbs` and prints OK — and **compiling a template is not resolving its partials**, so extracting eight tab bodies into shared partials and forgetting the preload list would have shipped two character sheets with eight blank tabs each, with the whole suite green.

**Why:** found while building a second sheet that shares the first one's tab bodies; the preload list in `ringbrp.mjs` had exactly one entry (`body-figure.hbs`) and nothing anywhere said a second entry was needed.

**How to apply:** after adding a partial, add it to the `loadTemplates` array in the same edit, and hold the two against each other with a guard — collect every `{{> "systems/..."}}` reference across `templates/**` and assert each is on disk *and* present in the preload call. RingBRP's lives in `tools/check-behaviour.mjs` ("every partial a template includes is on disk and in the preload list"), mutation-tested both ways. To confirm in a live world: `Handlebars.partials["systems/<id>/templates/partials/x.hbs"]` must be truthy. Related: [[feedback-can-the-guard-see-it]], [[infra-foundry-template-drops-undeclared]], [[ringbrp-project]].
