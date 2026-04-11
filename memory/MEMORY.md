# Claude Memory — /Users/timevans/Git

## Core Working Philosophy
- Fight "context rot": break large tasks into fresh-context atomic units
- Discussion-first: capture user preferences BEFORE planning or building
- Spec before code: design → research → requirements → plan → execute → verify
- Atomic commits per task — enables git bisect, clear history, easy revert
- File-based state: human-readable Markdown/JSON survives context resets
- Evidence over claims: never say "done" without running actual verification

## Iron Laws (from Superpowers — non-negotiable)
1. No production code without a failing test first
2. No fix without root cause investigation first
3. No completion claim without fresh verification evidence

## Workflow Model
1. **Brainstorm/Discuss** — Socratic dialogue; surface gray areas; get explicit approval before building
2. **Research** — gather context, stack options, pitfalls
3. **Plan** — bite-sized atomic tasks (2-5 min each), dependency-ordered, with verify steps
4. **Execute** — parallel waves; TDD (RED→GREEN→REFACTOR) per task
5. **Debug** — 4-phase root cause (read errors → reproduce → check changes → gather evidence) before ANY fix
6. **Verify** — run actual commands, confirm actual output; no assertions without evidence
7. **Review** — two-stage: spec compliance first, then code quality
8. **Ship** — user acceptance, clean up, then loop to next phase

See: [gsd-patterns.md](./gsd-patterns.md) and [superpowers-patterns.md](./superpowers-patterns.md)

## User Preferences
- Concise, direct communication — lead with answer, not reasoning
- No emojis unless explicitly requested
- Reference file:line when pointing to code

## Project Notes
- Working dir: /Users/timevans/Git
- GSD repo available at: /Users/timevans/Git/GSD/get-shit-done-main
- Superpowers repo available at: /Users/timevans/Git/Superpowers
