---
type: project
status: active
repo: slaguru666/claude-config
path: ~/.claude/skills/rpg
updated: 2026-09-13
---

# RPG skill

**What it is** — The house scenario-writing system, encoded as a Claude skill that
auto-triggers on any tabletop RPG work. Created 2026-07-19, distilled from
[[afterimage]].

**Where it lives** — `~/.claude/skills/rpg/`, shared across machines through the
`claude-config` repo ([[claude-config-sync]]).

**Current state** — In use. Encodes the 3h30 convention structure with the 2:45 hard
rule, the three-route clue standard, pregen private seams, the desk playtest
protocol, and the `mj-gen` art pipeline ([[midjourney-bridge]]).

**Next steps** — none; it grows as lessons arrive.

**Key decisions**
- **Live loop:** transferable lessons append to `references/lessons.md`, and are
  *deleted* from there once encoded into a reference. Scenario-specific facts go to
  [[graphiti]], not into the skill.

**Gotchas**
- **Sync ordering matters.** `sync.sh` copies live state over the repo *with
  deletes*. Always `git pull && ./install.sh` before working on a machine, and
  `./sync.sh` after — otherwise machines clobber each other's memory and skill
  files. This happened once, fixed by union merge 2026-07-19.

Related: [[custodians-ringbrp]], [[continuum-2026]], [[contingency-2027]]
