---
name: convention-scenario-tooling
description: Use when writing or restructuring a tabletop RPG convention one-shot scenario document, or when building/deploying GM-facing apps (consoles, handout/print packs, story readers, device editions) derived from those scenarios. Triggers include "make a version of the con app for <device>", scenario/act/handout authoring, and offline GM PWA deploys.
---

# Convention scenario tooling

Authoring convention one-shot **documents** and shipping the **apps** derived from them.
Distilled from Continuum 2026 (six one-shots, a weekend at the table) — including, honestly,
the parts that were done the hard way.

## The one idea that ties it together

**A convention scenario has one source of truth — the scenario document — and everything else
is a render of it.** Print packs, GM consoles, a phone story reader, and per-device editions
are all downstream. Get the document *structured* (not freeform prose) and the apps fall out
cheaply. Fork the content into parallel copies and every app becomes bespoke, drifting
hand-work.

## Two jobs, two references

- **Writing the scenario** → read [scenario-authoring.md]. The proven section order, the
  stand-in-can-run-it-cold constraint, the immovable-clock + pre-written-cuts pacing spine, the
  antagonist countdown, and the per-act structure. The logline, the GM's Truth, and the
  Player-Experience paragraph are load-bearing — every downstream app needs exactly those.
- **Building/deploying the apps** → read [app-editions-and-deploy.md]. The fork-vs-adapt
  decision, the verified rsync→container→Caddy deploy pattern, and the gotchas (service-worker
  cache staleness, the Caddyfile inode trap, SSH target) that cost real hours.

## The fork-vs-adapt decision (memorise this)

A "make a version for device X" request is one of three things:

- **Presentation-only delta** (colour, motion, density, layout) → **adapt one source** (media
  query / theme flag). Ship its own URL if needed, but content + build stay single-source.
- **Build-time divergence a runtime toggle can't express** (e.g. e-paper needs a head-injected
  timer clamp) → **separate build, still fed from the one content source.**
- **Different content model / machinery** (a read-only story reader vs interactive consoles) →
  **separate artifact** — but *generate its data from the scenario docs, never hand-copy it.*

**Never fork for a presentation-only delta.** And when the **Nth** edition is requested, stop
and inventory the whole edition set before answering — five separate builds accreted one
reasonable "yes" at a time, most never used. Answer the set, not the isolated request.

## Known open defect in the reference project

The phone reader's `pwa/phone/data/*.json` is a **hand-distilled second copy** of the scenario
narrative, unlinked to `scenarios/*.md` → it goes stale silently when a scenario is rewritten.
The fix is a generator that extracts named fields from the docs at build time. If you extend
these apps, do this first.

## Quick reference

| Need | Go to |
|---|---|
| Section order / act template / pacing | scenario-authoring.md |
| Should this be a new build or a theme? | fork-vs-adapt table above |
| Deploy a new edition to the VPS | app-editions-and-deploy.md § deploy pattern |
| "My change isn't showing up" | app-editions-and-deploy.md § service-worker cache |
| Editing the live Caddyfile | app-editions-and-deploy.md § Caddyfile inode trap |
