---
name: infra-dont-edit-a-file-a-process-is-reading
description: Rewriting a queue file while a shell `while read … done < file` loop is consuming it shifts its byte offset mid-line; kill, edit, restart instead
metadata:
  type: reference
---

A `while IFS=$'\t' read -r a b c; do … done < "$Q"` loop holds a **byte offset**
into `$Q`. Appending rows is safe and they are picked up. **Rewriting the file
in place is not**: truncate-and-write changes the length of lines ahead of the
reader, so the saved offset lands mid-line and subsequent reads come back as
fragments.

**Why:** I commented out eleven rows of `tools/art_queue.tsv` with a Python
`open(p,'w')` rewrite while `tools/gen_art.sh` was 10 rows into consuming it.
Nothing errored. The runner had already read the next row, and every row after
that was being read from a stale offset. Output that looks plausible is the
failure mode.

**How to apply:** to change a queue a runner is consuming — **kill the runner,
edit the file, validate it (row count and field count per row), restart.** The
script being idempotent is what makes this free, and that is the reason to build
queue runners idempotent in the first place. Two concurrent runners over one
queue is a separate bug: if the worker matches a remote result to "the job it
just sent", two in flight can cross-match and save the wrong output under the
right name.

Related: [[feedback-read-the-per-game-record]], [[feedback-check-the-instrument]]
