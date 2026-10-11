---
name: infra-npm-sandbox-exit-194
description: In the Claude desktop app sandbox, `npm run <script>` exits 194 with no output; run the script's command chain under bash instead before concluding anything failed
metadata:
  type: reference
---

In the desktop app's Code sandbox, `npm run check` in
`~/FoundryVTT/Data/systems/ringbrp` exits **194** and prints only npm's own two header
lines — no guard output at all. It does this **on a clean tree as well**, so it is not a
signal about the working copy.

The same chain run directly succeeds:

    bash -c "$(node -e "console.log(require('./package.json').scripts.check)")"

→ exit 0, all 27 guards printing OK. `npm run` (no args) works, and `node`/`bun` work, so
it is npm's child-process spawn that the sandbox stops, not the tools.

**Do not report a suite as failing on the strength of an npm exit code here** — reach for
the underlying chain and read the guards' own output. Same shape as
[[feedback-check-the-instrument]]: the instrument failed in the direction that looked like
a real defect.

Side effect worth knowing: running the full chain opens the LevelDB packs, so
`packs/weapons/*.log`, `CURRENT` and `MANIFEST-*` show up modified/deleted/untracked
afterwards. That is log rotation, not content — leave it out of commits.
