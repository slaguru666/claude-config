---
type: project
status: complete
repo: none
path: ~/bin/mj-gen
updated: 2026-09-13
---

# Midjourney bridge

**What it is** — A working Midjourney → local PNG pipeline. From any Claude session:
write a prompt, run `mj-gen`, and the image lands on disk ready to read back and
place into scenario files. Stdlib-only Python, no pip dependencies, no Midjourney API.

**Where it lives** — `~/bin/mj-gen`, `~/bin/mj-auth-check`, `~/bin/mj-capture-command`
(all on PATH and pre-approved in Claude settings, so no permission prompts). Config at
`~/.config/mj-bridge/config.json`; the Discord token lives in `secrets.env` there —
**never read or echo that file.** Default output `~/MidjourneyInbox/`.

**Current state** — Working. `mj-gen "<prompt>" [--out <dir>] [--upscale N] [--name <stem>]`
sends `/imagine`, waits for the 2×2 grid, clicks an upscale button, downloads the PNG
and prints the path.

**Next steps** — none.

**Key decisions**
- Talks directly to the Discord API with Tim's user token; Midjourney runs the job on
  its own GPUs. **Discord does not need to be open on the Mac.**

**Gotchas — mostly moderation**
- **A silently-dying job is a banned word, almost always.** Midjourney declines in an
  ephemeral reply the channel poller can never see, so `mj-gen` waits out its full
  timeout on nothing. Confirmed trip words in innocent use: **"gore"** (even negated)
  and **"bust"** ("portrait bust of a warrior" → use "head and shoulders portrait").
  Five deaths in a row were once misread as exhausted fast hours; the account had
  13h56m left.
- Scene prompts drift photorealistic — lead with "hand-drawn pen and ink
  illustration, NOT a photograph" and append `--no photography, photorealism`.
- Don't run two `mj-gen` calls concurrently in one channel; they grab each other's jobs.
- Saved files get a `-u1` suffix. Rename to canonical names.
- If the slash-command schema changes, run `mj-capture-command`. If the button
  `custom_id` format changes, `mj-gen` needs a code patch. HTTP 401 everywhere means
  the Discord token expired.

Related: [[afterimage]], [[rpg-skill]], [[loom]]
