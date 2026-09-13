---
type: tasks
updated: 2026-09-13
---

# Tasks

Live list across everything. Completed items roll to `Archive/` monthly.
Index: [[INDEX]]

## Active

- [x] Undo double-fire report — **not reproducible; no defect** [[corkboard]] (2026-09-13). One click gives one handler run and one toast; the binding is single on every render path. Do not re-chase.
- [ ] Open, and separate from the above: the undo race in `docs/reviews/codex-review-29.md` — a write landing inside the undo's own `page.update` can still collapse a line, because validation and application are not atomic. Deliberately unpatched [[corkboard]]

- [ ] Phase 3 — extract the controller incrementally, subsystem by subsystem [[corkboard]]
    - [x] gestures: cards/strings, shapes/ink, zones (2026-09-13)
    - [x] IndexedDB commits, board create/list/name/delete (2026-09-13)
    - [x] shared sanitiser — one allow-list, both hosts (2026-09-13)
    - [ ] dialogs and IO
- [ ] Build the standalone Corkboard app shell [[corkboard]]
      - [x] viewport and gesture arbitration — all eight `reacquire` verified live (2026-09-13)
      - [x] slice 1: open a board, draw on it, reopen it with the work still there (2026-09-13)
      - [x] slice 2: the shared sanitiser and a rich-text editor for card bodies (2026-09-13)
      - [x] slice 3: asset ids, blob store, the display-time image resolver (2026-09-13)
- [ ] **Run CLEAN GROUND with human beings** — now literally the only thing left; eleven desk
      passes, every desk-reachable branch played, artwork placed (v0.25). Before convention-ready;
      no number of desk passes can settle Act Four's 45 minutes with no mechanical threat, or
      whether THE OFFER plays as a decision [[custodians-ringbrp]]
- [ ] Load `sla-mothership` once and confirm the libWrapper banner is gone — stored config
      fixed and verified against its backup, but that world has not been launched since
      [[oneoffgames-vps]]
- [x] **scenario-forge** — remote created, private `slaguru666/scenario-forge`, spec pushed (2026-09-13) [[scenario-forge]]
- [x] scenario-forge — parser + validator, run against all six (2026-09-13). 37 findings → 18 [[scenario-forge]]
- [ ] **Write Clue Trails for Vain Crown, Silvery Moon and Chopper** — absent entirely; now caught by C-04. The bulk of the normalisation work, and it is writing not editing [[scenario-forge]]
- [ ] Write a Clue Trail for Day One act 2 — caught by C-05 [[scenario-forge]]
- [x] Handout indexes cleared (2026-09-13) — 5 of the 9 were a parser bug (per-act tables); 4 real gaps indexed from the print packs; AFTERIMAGE's props row given F2-H02-E [[scenario-forge]]
- [x] Day One's two unknown headings — renamed to lead with new canonical stems `running-this` and `rules-reference` (2026-09-13) [[scenario-forge]]
- [x] Section order fixed in three scenarios (2026-09-13). Silvery Moon and Chopper now validate clean [[scenario-forge]]
- [x] Three read-aloud blocks trimmed (2026-09-13) — overflow became GM-voiced bullets, no content cut. AFTERIMAGE and Princes Bride validate clean [[scenario-forge]]
- [x] scenario-forge — journal builder; AFTERIMAGE's nine scenario entries reproduce byte-identically (2026-09-13) [[scenario-forge]]
- [ ] scenario-forge — port AFTERIMAGE's handouts/actors/scenes/tables from `content/*.mjs` into `scenario.config.mjs` (~1000 lines, mechanical) [[scenario-forge]]
- [ ] scenario-forge — module.json, adventure assembly and the LevelDB packer (carry the no-Foundry-CLI comment forward) [[scenario-forge]]
- [ ] Corkboard phase 1 for scenario-forge: `src/data/index.mjs` barrel + `exports` map, provenance flag, re-sync [[corkboard]]
- [ ] scenario-forge acceptance test — build AFTERIMAGE, import into a scratch world, open the case board (the one thing the spike could not verify) [[scenario-forge]]
- [ ] Normalise the other five scenarios to the house format — real editing, not a script [[scenario-forge]]
- [ ] Print the handout pack and do Tim's read-through [[afterimage]]
- [ ] Push Masque to Gitea and GitHub — still local only [[masque]]
- [ ] Install BlackHole via `./setup.sh` — required before real Discord use [[masque]]
- [ ] Discord smoke test with a real mic [[masque]]
- [ ] Load-test Blueprint News in a running Foundry world (both modules) [[blueprint-news]]
- [ ] Resolve the Continuum slate count — five games recorded, six slots claimed [[continuum-2026]]
- [ ] Check whether Witchfinder Garrett actually appeared in earlier material [[contingency-2027]]
- [ ] Replace placeholder slot times once Warhorn publishes [[contingency-2027]]
- [x] Install Node + Claude Code on MINI-S — done user-local, no sudo needed [[mini-s]]
- [x] ~~Confirm the outside Foundry admin IPs~~ — resolved: `178.239.163.114` is the Claude-in-Chrome egress, measured [[oneoffgames-vps]]
- [ ] **Rotate both GitHub PATs** — exposed in a session transcript; update `~/.config/github/tokens.env` on MINI-S afterwards [[mini-s]]
- [ ] Once rotated, delete the pre-cleanup backups on MINI-S (`~/.bashrc.bak-*`, `~/.zshrc.bak-*`, `~/.claude/settings.local.json.bak-*`) and let `~/.claude/backups/` age out [[mini-s]]
- [ ] Re-run `install.sh` on MINI-S from an interactive shell after rotating, to register the official GitHub MCP server [[claude-config-sync]]
- [ ] Rotate the Canvas API token — it was shared in chat [[canvas-oss-course]]
- [x] Decide how MINI-S reaches this vault — solved via `claude-config` [[mini-s]]

## Blocked / awaiting a decision

- [ ] iPad storage durability testing [[corkboard]] — the app is now live at https://web.oneoffgames.com/corkboard/app/ (not `corkboard-spike/`), so this is unblocked
- [x] File-exchange validation [[corkboard]] — `.corkboard` bundles both ways, verified in Foundry v14 and the app (2026-09-13)
- [ ] Local-network sync for offline iPads — out of scope for Phase 2 [[corkboard]]
- [ ] Confirm non-official marketplaces auto-fetch on MINI-S [[claude-config-sync]]
- [ ] Decide whether to retire Seafile or Nextcloud [[mini-s]]
- [ ] Generate the iOS project — needs full Xcode + CocoaPods, not on this Mac [[the-director]]

## Someday

- [ ] Enterable hero buildings, more biomes, moving-traffic city look [[mapwright]]
- [ ] Put the five audio apps in git — currently nowhere but disk [[drift]]
