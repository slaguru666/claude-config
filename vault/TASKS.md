---
type: tasks
updated: 2026-09-13
---

# Tasks

Live list across everything. Completed items roll to `Archive/` monthly.
Index: [[INDEX]]

## Active

- [x] Undo double-fire report — **not reproducible; no defect** [[corkboard]] (2026-09-13). One click gives one handler run and one toast; the binding is single on every render path. Do not re-chase.
- [ ] **Undo race — REOPENED, my "do not re-chase" was wrong** [[corkboard]] (2026-09-14, review 31). Writing the inverse whole closes the race only when the competing write lands FIRST. Landing second, Foundry's diff has already thinned it to the fields that changed on that client, and they recombine with the box the inverse restored: Bob-then-Alice gives length 20, Alice-then-Bob gives 0. `diff:false` is necessary and insufficient. Also open: `looksResurrected` infers from values, so delete cleanup misses a phantom matching the defaults and deletes a genuine restoration somebody recoloured. Needs a decision, not a patch — this area has punished value-rules four times.

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
- [x] scenario-forge — **content port done** (2026-09-14): handouts, actors, scenes, tables + the blade-runner adapter. AFTERIMAGE rebuilds with all 30 journals / 13 actors / 6 scenes / 1 table; 222 tests, `6845182` [[scenario-forge]]
- [x] scenario-forge — module.json, adventure assembly, LevelDB packer; `forge build` works end to end (2026-09-13) [[scenario-forge]]
- [x] **scenario-forge live acceptance test PASSED** (2026-09-13) — built, installed, imported into a scratch world, pages open and read correctly [[scenario-forge]]
- [ ] Tidy up after the acceptance test — delete the **Forge Acceptance Test** world and `~/FoundryVTT/Data/modules/afterimage-forge` [[scenario-forge]]
- [ ] scenario-forge — the four Corkboard boards, plus Corkboard phase 1 (data barrel + exports map, provenance flag, re-sync) [[scenario-forge]]
- [ ] Corkboard phase 1 for scenario-forge: `src/data/index.mjs` barrel + `exports` map, provenance flag, re-sync [[corkboard]]
- [ ] scenario-forge acceptance test — build AFTERIMAGE, import into a scratch world, open the case board (the one thing the spike could not verify) [[scenario-forge]]
- [ ] Normalise the other five scenarios to the house format — real editing, not a script [[scenario-forge]]
- [ ] Tim's read-through — the handout pack is printed (2026-09-13): 23 sheets, four
      print-only spill pages fixed, `print/AFTERIMAGE-handouts.pdf` [[afterimage]]
- [x] Con print pack rebuilt (2026-09-13) — 117pp, 91MB; AFTERIMAGE plates re-encoded
      to JPEG to clear GitHub's 100MB file limit [[continuum-2026]]
- [ ] Decide the **F2-H02-E** collision — the pack uses it for the night-market plan
      (2026-09-11), the scenario table gave it to the props sheet (2026-09-13) [[afterimage]]
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
- [x] Publish from the app [[corkboard]] — Publish button + `corkboard-publish` service; filter runs client-side, server refuses unfiltered boards (2026-09-13)
- [ ] Unpublish from the app [[corkboard]] — taking a board down is still `ssh` + `rm`; a DELETE on the same service and auth
- [x] Shared Corkboard slice 1 — accounts, sessions, admin page, live at https://corkboard.oneoffgames.com [[corkboard]] (2026-09-14)
- [x] Shared Corkboard slice 2 — boards, the commit endpoint and the module server; a board renders under a CSP with no `unsafe-inline` [[corkboard]] (2026-09-14)
- [ ] **Sign in once at corkboard.oneoffgames.com and open a board** [[corkboard]] — the one thing slice 2 could not verify; account `tim`, password in `/root/.corkboard-admin` on the box
- [x] Shared Corkboard slice 3 — SSE fan-out; live updates over public HTTPS in 60ms [[corkboard]] (2026-09-14)
- [ ] **Open one board in two signed-in tabs and drag a card** [[corkboard]] — closes both remaining slice 2+3 gaps at once
- [ ] Shared Corkboard slice 4 — grants + the server-side filter; `boardStateFor` is the one function to widen [[corkboard]]
- [ ] Tidy the box after slice 1: drop the `corkboard_test` role and database, close any SSH tunnel on port 55432 [[corkboard]]
- [x] Read-only published board [[corkboard]] — `./publish.sh`, players open `#view/<slug>`; sanitised before it leaves the machine (2026-09-13)
- [ ] Confirm non-official marketplaces auto-fetch on MINI-S [[claude-config-sync]]
- [ ] Decide whether to retire Seafile or Nextcloud [[mini-s]]
- [ ] Generate the iOS project — needs full Xcode + CocoaPods, not on this Mac [[the-director]]

## Someday

- [ ] Enterable hero buildings, more biomes, moving-traffic city look [[mapwright]]
- [ ] Put the five audio apps in git — currently nowhere but disk [[drift]]
