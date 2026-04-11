# Global Claude Instructions

## Communication
- Concise, direct — lead with answer, not reasoning
- No emojis unless explicitly asked
- Reference file:line when pointing to code

## Context Compaction
When compacting, preserve:
- Current task and immediate next steps
- File paths and function names modified
- Test results (failures only)
- Decisions made and their rationale
- Any blockers or open questions

Discard:
- Exploratory file reads that led nowhere
- Intermediate reasoning that reached a conclusion
- Full file contents already committed to code
- Verbose command output with no failures

## Working Style
- Verify before asserting — run the command, read the file
- Atomic changes — one thing at a time, confirm it works
- No speculative features beyond what was asked
