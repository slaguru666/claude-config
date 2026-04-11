# GSD Patterns & Mental Models

Source: /Users/timevans/Git/GSD/get-shit-done-main (v1.29.0)

## Core Problem GSD Solves
- **Vibecoding**: casual AI-assisted coding where context degrades and quality drops
- **Context rot**: quality degradation as context window fills up
- Solution: structured context engineering, fresh agent contexts per task, file-based state

## Key Mental Models

### 1. Wave-Based Execution
Group tasks by dependencies into waves. Run each wave in parallel:
- Wave 1: all independent tasks (parallel)
- Wave 2: tasks that depend on Wave 1 (parallel within wave)
- Never execute dependent tasks in parallel — causes conflicts
- Each task gets its own fresh context window (200K)

### 2. Discussion-First
Before planning ANYTHING non-trivial, surface ambiguities:
- Layouts and visual preferences
- Error handling strategies
- Naming conventions
- Tone/UX approach
- Edge cases the user hasn't mentioned
Two modes: `discuss` (interview style) or `assumptions` (analyze codebase, propose assumptions)

### 3. Atomic Plans with XML Structure
Each plan task should be:
- Independently executable
- Has specific files, action, verification step, and done criteria
- Atomic git commit per task
- Checker validates plans are complete before execution (read-only check)

### 4. State as Files (not memory)
All project state lives in `.planning/` as Markdown/JSON:
- PROJECT.md — vision, constraints, decisions
- REQUIREMENTS.md — scoped requirements (v1/v2/out-of-scope)
- ROADMAP.md — phase breakdown with status
- STATE.md — current position, decisions, blockers (living document)
- phases/XX-phase-name/ — per-phase context, research, plans, summaries

### 5. Researcher → Planner → Checker → Executor → Verifier
Each role is specialized, never combined:
- Researchers: gather info, never write code
- Checkers: evaluate plans, never modify them (read-only)
- Executors: implement, don't research
- Verifiers: confirm outcomes match goals post-execution

### 6. Fresh Context Per Task
Avoid context rot by spawning subagents with focused roles and fresh context.
Orchestrators stay thin — they coordinate, don't implement.

### 7. Model Profiles
Match model capability to task complexity:
- Planning (most complex): Opus
- Execution (implementation): Sonnet
- Verification (checking): Sonnet or Haiku
- Budget tasks: all Sonnet

### 8. "Absent = Enabled" Config Philosophy
Default configs should default to safe/on. Users explicitly disable, not enable.
Missing keys mean feature is active.

## Greenfield vs Brownfield
- **Greenfield**: new-project → research → requirements → roadmap
- **Brownfield** (existing code): map-codebase first (4 parallel researchers analyze stack, architecture, conventions, concerns, testing, integrations)

## Verification Layers
1. **Plan check** — does the plan cover all requirements? (before execution)
2. **Integration check** — do plans work together? (cross-plan compatibility)
3. **Post-execution verify** — did execution achieve goals?
4. **UAT** — user acceptance testing (manual)
5. **Nyquist validation** — test coverage gaps identified and filled
6. **UI review** — 6-pillar visual audit (if UI work)

## Security Patterns (GSD v1.27+)
- Validate user paths resolve within project directory
- Scan planning artifacts for prompt injection before use
- Sanitize user text before shell interpolation
- Safe JSON parsing — catch malformed args before state corruption

## Anti-Patterns to Avoid (from GSD philosophy)
- Editing code without reading it first
- Planning without discussing ambiguities
- Large monolithic tasks (break into atomic units)
- Combining researcher/planner/executor roles
- Ignoring existing conventions in brownfield projects
- Skipping verification steps
- Batch commits (commit per task, not per phase)
