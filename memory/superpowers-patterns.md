# Superpowers Patterns & Mental Models

Source: /Users/timevans/Git/Superpowers (v5.0.6, Jesse Vincent / obra)

## Core Problem Superpowers Solves
- AI agents write code confidently that is untested, unverified, and unreviewed
- "Quick fixes" mask root causes; claims of completion are unverified assertions
- No enforced discipline means each session rediscovers the same failure modes
- Solution: iron-law workflows that mandate process at each stage

## Iron Laws (non-negotiable, never rationalize away)

1. **No production code without a failing test first** (TDD)
2. **No fix without root cause investigation first** (debugging)
3. **No completion claim without fresh verification evidence** (verification)

These are NOT guidelines. Rationalizations like "too simple to test", "quick fix", "I'm confident it works" are red flags — stop, don't proceed.

## Key Mental Models

### 1. RED-GREEN-REFACTOR (TDD Cycle)
Every feature, every time:
1. Write a failing test (RED) — verify it actually fails, don't skip this
2. Write minimal code to pass (GREEN) — minimal means minimal
3. Refactor with tests still passing (REFACTOR)
- "If you didn't watch the test fail, you don't know if it tests the right thing"
- Tests written after the fact prove nothing; tests written first prove the code works

### 2. Design Before Code (Brainstorming)
Socratic dialogue to refine ideas before a line is written:
- Present designs in discrete sections, get user approval on each
- Explore alternatives — what if we didn't do it this way?
- Surface constraints and tradeoffs the user hasn't thought of
- Save design spec to `docs/superpowers/specs/YYYY-MM-DD-<topic>-design.md`
- Do NOT start implementing until design is explicitly approved

### 3. Bite-Sized Plans
Good plans have tasks that are:
- 2-5 minutes of work each
- Self-contained with exact file paths
- Include complete code (not "add error handling")
- Include the specific test verification step
- Include the atomic commit step
- Save plan to `docs/superpowers/plans/YYYY-MM-DD-<feature>.md`

### 4. Systematic Debugging (4-Phase Root Cause)
Before touching any code:
1. **Read errors carefully** — exact message, file, line, stack trace
2. **Reproduce** — confirm you can trigger it reliably
3. **Check recent changes** — git log/diff, what changed?
4. **Gather evidence** — logs, state, reproduction case

Only AFTER all four phases: hypothesize → test hypothesis → fix → verify fix.
No guesses. No "probably". No trying things to see if they work.

### 5. Evidence Before Completion Claims
Never say "done", "working", "fixed" without:
- Running the actual verification command
- Seeing the actual output
- Confirming the output matches expected
"Should work", "I'm confident", "probably" = not done. Run the command.

### 6. Two-Stage Code Review
When reviewing code (or requesting review):
- Stage 1: Spec compliance — does it do what was designed?
- Stage 2: Code quality — is it well-written, secure, maintainable?
Never collapse these into one pass. Spec compliance comes first.

### 7. Subagent Context Isolation
When dispatching subagents:
- Each gets a fresh context with ONLY what it needs
- No session history leaks in
- Provide: task description, relevant files, acceptance criteria
- Do NOT provide: full conversation history, unrelated context
- Two-stage review built into subagent-driven-development

### 8. Git Worktree Isolation
For non-trivial branches:
- Create isolated worktree (`.worktrees/<branch-name>/`)
- Run baseline tests before starting — confirm clean state
- Work doesn't pollute main checkout
- Verify tests pass before finishing branch

### 9. finishing-a-development-branch Checklist
Before merging anything:
1. All tests pass
2. New code has tests
3. Verification evidence collected (not assumed)
4. Present options: merge / open PR / discard
5. Clean up worktree after merge

## Skill Design Principles (meta)
When writing process documentation / skills:
- Description field = WHEN to use (not what it does) — Claude searches by trigger condition
- Pressure test first: run agent WITHOUT skill, observe failure mode
- Then write skill to address exactly that failure mode
- Verify compliance by re-running the failing scenario
- "Writing skills IS test-driven development applied to documentation"

## Anti-Patterns to Avoid (from Superpowers)
- Writing tests after code is written (they prove nothing)
- Fixing bugs without identifying root cause first
- Claiming completion before running verification
- Broad agent context (subagents get minimal, focused context only)
- Parallel tasks that share mutable state
- Skipping the RED step in TDD ("it obviously fails")
- Ad-hoc debugging ("let me just try changing this")
- "Just this once" exceptions to iron laws

## How This Complements GSD
GSD handles: project structure, phase management, research, planning, state files, context rot
Superpowers handles: code discipline, TDD enforcement, debugging methodology, verification rigor, review quality

Combined workflow:
1. GSD: Discuss → Research → Plan (file-based, wave-organized)
2. Superpowers: Brainstorm → Write plan (bite-sized) → TDD execute → Systematic debug → Verify → Review → Merge
