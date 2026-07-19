---
name: rpg-skill
description: "The \"rpg\" Claude Code skill — house scenario-writing system, shared via claude-config repo, self-updating lessons log"
metadata: 
  node_type: memory
  type: project
  originSessionId: 063192d8-013b-4c4f-9d0b-ad355d9ae7c1
  modified: 2026-07-19T11:17:43.964Z
---

The **rpg** skill at `~/.claude/skills/rpg/` (created 2026-07-19) auto-triggers on any tabletop RPG scenario work and encodes the house system: 3h30 convention structure with 2:45 hard rule, three-route clue standard, pregen private seams, desk playtest protocol, mj-gen art pipeline.

**Live loop:** transferable lessons are appended to `references/lessons.md` (promotion rule: delete once encoded into a reference); scenario-specific facts go to Graphiti; sync across machines with `cd ~/Git/claude-config && ./sync.sh`.

**Sync ordering matters:** `sync.sh` copies live state over the repo with deletes — always `git pull && ./install.sh` before working on a machine, `./sync.sh` after, or machines clobber each other's memory/skill files (this happened once; fixed by union merge 2026-07-19).

Related: [[afterimage-scenario]] (the exemplar scenario the skill was distilled from).
