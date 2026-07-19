# Production Pipeline

Everything beyond the scenario text that makes a slot runnable.

## Folder & repo layout

Each scenario ships as a self-contained folder:

```
<SCENARIO>/
├── README.md          # index table, status line (version, playtests, remaining prep), licence footer
├── scenarios/         # the scenario markdown (+ art/ for scenario illustrations)
├── characters/        # pregens.md, character-sheets.html, art/ (portraits)
├── handouts/          # print-ready handout pack (HTML)
├── reference/         # set-piece GM quick-reference sheets
├── playtest/          # one file per desk playtest
├── gm-utility/        # GM console app (module per scenario)
└── print/             # final print artifacts
```

- iCloud is the working copy:
  `~/Library/Mobile Documents/com~apple~CloudDocs/RPGS/Conventions/<Event Year>/<Day>/<Slot>/...`
- Each event gets a **private GitHub repo** (`slaguru666/<Event><Year>`, e.g.
  `Continuum2026`) as backup + cross-machine share. Commit at meaningful
  checkpoints (draft, post-playtest, version bumps), not per-edit.
- Licensed settings (Blade Runner, CoC, …) stay in **private** repos with the
  licence footer: "© <publisher>. Private convention play materials — not for
  sale or distribution."

## Handouts & props

- IDs: `[Slot]-H[act]-[letter]` (e.g. `F2-H00-A` = Friday slot 2, pre-game,
  first handout). Every handout appears in the scenario's per-act handout
  tables with When Given.
- Build one **print-ready HTML pack** per scenario (A4, print margins,
  background graphics on). Physical props beat screens: print guidance in the
  scenario says what to hand around vs lay flat.
- The best handout tricks are *staged*: duplicated documents revealed
  simultaneously, sealed items ("bag it, don't open it"), cut-out props.
  Write the staging into the scenario, not just the pack.

## Artwork

- Base style: **ink sketch / pencil illustration** — hand-drawn, single-weight
  line, sparse wash, negative space. Never photorealistic. Each scenario adds
  one art-direction line (e.g. "heavy rain hatching").
- Asset IDs `[Slot]-ART-[##]`, tracked in the scenario's Artwork Assets table
  with description, where used, and the full generation prompt (prompts are
  part of the document — regeneration must be possible).
- Generate with the Midjourney bridge: `mj-gen "<prompt>"` drops a PNG on
  disk. Keep alternates in an archive folder; portraits feed the character
  sheets.

## GM console (`gm-utility/`)

Touch-screen GM app (static HTML, no build step) with: session clock with the
scenario's checkpoints, dice roller with system-specific push/advantage rules,
set-piece runner (e.g. chase obstacles), PC/NPC dashboards, fullscreen props,
autosaving state. Scenarios plug in as modules — when building a new scenario,
add a module rather than a new app.

## Print checklist (before the con)

- Character sheets: A4 portrait, 100% scale, one page per PC + table
  quick-reference page
- Accessibility: handout body text ≥11pt (con halls are dim, eyes are tired);
  the GM reads every handout aloud as it's given
- Handout pack, including any duplicated staging cards
- Set-piece GM quick-ref
- GM read-through of the final versioned scenario
- README status flipped to convention-ready with remaining-prep list emptied
