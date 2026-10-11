---
name: midjourney-bridge
description: "Local CLI for generating Midjourney images via Discord from any Claude session — call mj-gen with a prompt, get a PNG file you can read/place."
metadata: 
  node_type: memory
  type: reference
  originSessionId: fa4ca039-8c0e-4b9c-aee8-b6d7a81482b5
  modified: 2026-10-08T00:40:00.000Z
---

# Midjourney bridge (`mj-gen`)

The user has a working Midjourney → local PNG pipeline. From any Claude session you can write a prompt, run `mj-gen` via Bash, and the resulting image lands on disk where you can read it back and place it into game/scenario files.

## Commands (in `~/bin/`, on PATH)

- `mj-gen "<prompt>" [--out <dir>] [--upscale 1|2|3|4] [--name <stem>]` — sends `/imagine`, waits for the 2×2 grid, clicks an upscale button (default U1), downloads the upscaled PNG. Prints the saved path on stdout. Default output dir: `~/MidjourneyInbox/`.
- `mj-auth-check` — verifies Discord token + configured channel are reachable. Run if `mj-gen` starts erroring on auth.
- `mj-capture-command` — refreshes the cached `/imagine` slash-command ID. Run if Midjourney updates the command and `mj-gen` returns "unknown interaction" or similar.

All three are pre-approved in `~/.claude/settings.json` → `permissions.allow`, so they don't trigger permission prompts.

## Config layout

- `~/.config/mj-bridge/config.json` — guild_id, channel_id, default_output_dir, default_upscale, poll/timeout intervals, cached `imagine_command` metadata.
- `~/.config/mj-bridge/secrets.env` — `DISCORD_TOKEN="..."` (0600 perms). Never read or echo this file's contents back into conversation — the token is as powerful as the Discord password.

## How it actually works (so you can debug)

The script talks directly to `discord.com/api/v9` using the user's Discord user token. It posts an interaction payload that triggers the real MJ bot on Discord's servers; MJ runs the job on its own GPUs and posts the result back into the configured channel; the script polls `/channels/<id>/messages` and downloads the attachment. Stdlib-only (urllib, json) — no pip dependencies.

Discord does **not** need to be open on the Mac. Only requirement is internet + a valid Discord token + an active MJ subscription with Fast Hours / queue room.

## Typical usage from a conversation

```bash
mj-gen "Ink sketch, lone figure standing on a flooded London street at dawn, ..., --ar 1:1 --s 250 --v 6.0" \
  --out "/path/to/project/assets" \
  --name some-descriptive-stem
```

Then read the resulting PNG back to verify it matches the brief before placing it into game files. If the user dislikes U1, re-run `mj-gen` (cheap re-roll) or — if the same grid is still in the channel — manually post the other U-button custom_ids; the script currently only auto-clicks one upscale per call.

## Prompt gotchas (learned in production)

- MJ's moderation blocks prompts containing banned words **even in negation**
  ("no visible gore") — the grid never arrives and `mj-gen` times out with no
  error. Reword positively ("understated, nothing graphic").
- Scene prompts drift photorealistic; for illustration styles lead with
  "hand-drawn pen and ink illustration, NOT a photograph" and append
  `--no photography, photorealism`.
- Saved files get a `-u1` (upscale-button) suffix — rename to canonical names.
- Don't run two `mj-gen` calls concurrently in one channel: each polls the
  channel for the newest grid and they can grab each other's jobs.
- **A silently-dying job = a banned word, almost always.** MJ declines in an
  ephemeral reply the channel-poller can never see, so `mj-gen` waits out its
  full timeout on nothing — NO new bot messages appear in the channel (check
  via the messages API). Words confirmed to trip it even in innocent use:
  **"gore"** (even negated: "no visible gore") and **"bust"** ("portrait bust
  of a warrior"). Reword and rerun; the fix is never account-side unless the
  account page actually shows 0 fast hours. (19 Jul 2026: five "Portrait
  bust..." prompts died in a row and were misread as fast-hours exhaustion —
  the account had 13h56m remaining; "Head and shoulders portrait" worked
  first try.) `timeout_seconds` in config.json is 1800 (was 600).
- **16 Sep 2026, same mistake twice:** Joan Wetherlaw's portrait "timed out" in
  two sessions and was written up as fast hours running out — wrong again; other
  prompts in the same minutes returned in 40s. Proven blocker: **"bare"** ("one
  bare bulb" → "a single hanging light bulb" rendered). Joan's died on one of
  "waxed" / "yard brush" / "unimpressed". **Check first:** list the channel's last
  messages (import `~/bin/mj-gen` as a module and call `discord_request`; never
  print the token) — no bot post for the job = blocked prompt. Kill a stuck
  `mj-gen` after ~3 min rather than waiting 30.
- **⚠ 23 Sep 2026 — "bare" is NOT confirmed, and the note above may be wrong too.**
  Two RingBRP creatures stalled six times between them. Regenerating one with
  "bare" replaced worked, and that was written up here and committed as the
  diagnosis. **It did not survive retesting**: the same prompt with "bare"
  restored and nothing else changed was accepted in seconds. The variable that
  really differed was that the successful run was the only job in flight. The
  16 Sep "one bare bulb" finding rests on the same kind of evidence — one retry
  after one edit — so treat it as unconfirmed rather than proven.
  Also tested and dead: the other creature's full prompt is accepted immediately,
  so it was never blocked; and four jobs fired two seconds apart were all
  answered, so it is not a concurrency limit at that scale. **What caused those
  six failures is still unknown.**
- **The lesson is about the evidence, not the word.** One successful retry after
  one edit is not a diagnosis — there is no control, and a stall that comes and
  goes will hand you a false positive every time. Confirm both directions: make
  it work, then put the suspect word back and make it fail again.
- **THREE failure modes, not one. This is the thing to know.**
  1. **Refused before starting** — nothing is ever posted to the channel. The
     ephemeral decline; a banned word. Bisect the prompt.
  2. **Started, then deleted** — the bot POSTS, the job begins, and Midjourney
     then removes its own message. This is the GENERATED IMAGE being flagged, not
     the prompt, so no `--no` list and no amount of retrying helps; the
     description has to change. Discovered 23 Sep on RingBRP's `moor_cat`, which
     failed six times and had every prompt-level hypothesis tested against it.
     The tell: the message exists while you watch, and is gone from the history
     afterwards.
  3. **Genuinely slow** — posted and still there.
- **`~/bin/mj-blocked "<prompt>"` — written 23 Sep, FIXED 8 Oct, use it first.**
  Sends the prompt, watches ~2 minutes, then confirms the outcome.
  Exit 0 = running, 2 = refused before starting, 3 = started then deleted.
  `--last` just lists recent bot posts.
  **The 23 Sep version gave a false mode-3 on every successful job.** It watched
  one message id, and Midjourney posts a "(Waiting to start)" placeholder which it
  then DELETES and replaces with the finished grid under a NEW id — read as "the
  image was flagged", i.e. "rewording is the only lever", about jobs that had just
  succeeded. It sent two sessions down the wrong path. It now waits for a real grid
  via `mj-gen`'s own `find_grid`, and calls mode 3 only after 45s with nothing at
  all in the channel for that job. Regression-tested offline by replaying a scripted
  channel through a fake `$HOME` (no network, no token): old → 3, new → 0.
- **12 Oct 2026 — ANCHOR A FIGURE'S SIZE TO SOMETHING ELSE IN THE FRAME.** The single most
  useful prompt technique found so far. Six plates of one man at six distances failed twice:
  describing the scene and putting him last — *"barely more than a mark on the paper"* — made
  the render omit him entirely, because that phrasing is an instruction to treat him as
  negligible. Leading with him walked him up to the camera and dragged an airbrushed poster into
  a grainy film still. **What works: "no taller in the frame than the parked cars beside him."**
  Concrete and checkable. Pair with `--no close-up, portrait` whenever the subject is named
  first, and `--no photograph, film still` to hold a painted press.
- **12 Oct 2026 — a press designed around the filter never hit it.** WALKING PACE ran ~40 horror
  plates with a **zero pull rate**, days after DEAD RECKONING's thirty-two-job wall, on the same
  account. The difference was written into the art sheet as a rule: **no plate depicts an injury,
  a body or a weapon**, and the respirator hood is *described* ("a pale canvas hood with two
  round glass eyepieces") rather than named. The horror lives in the prose. **Everything that
  cost time was composition, not moderation** — which is the opposite of the assumption that
  wasted the previous session.

- **⚠ 8 Oct 2026 — mode 2 can swallow a whole art direction, and retrying is
  worthless against it.** DEAD RECKONING's 1968 Hammer press rendered six plates
  happily, then **thirty-two consecutive jobs** — plates and portraits, spaced 2–2.5
  minutes, over four and a half hours — produced no file at all. Diagnosed in turn as
  dropped submissions, exhausted fast hours, and a dead bridge. **All three wrong.**
  Every one of those jobs started, posted, and had its post pulled. Prompts as
  innocuous as *a man in an overcoat holding a clipboard* were pulled.
  **The one diagnostic that settles it in 30 seconds: send a short known-good control
  prompt.** *"a plain grey stone on wet sand"* came back as a full fast-mode grid one
  minute before a DEAD RECKONING prompt was pulled. Token 200, channel 200,
  `POST /interactions` 204 — and note that **204 is also what a SUCCESSFUL submission
  returns**, so it proves acceptance and nothing more; `mj-capture-command` returned
  byte-identical metadata. None of those four checks can tell you anything. The control
  prompt can.
  **When a press enters this state, soften the press, not the subject** — the variant
  without "horror" and "lurid" rendered the same day.
- **`find_grid` in mj-gen matches on the first 40 alphanumerics of the prompt**,
  so if the bot's post is deleted mid-job, mj-gen waits out the full timeout with
  "timed out waiting for grid" and no other explanation. That message means one
  of the three modes above — it does not mean the service is slow.
- **In the RingBRP repo**, `tools/mj-queue.mjs` keeps the banned list and
  `promptFor()` THROWS rather than warning, because a warning in a log predicts a
  job that never arrives and never errors. It also refuses more than six `--no`
  terms. Nothing should be ADDED to that list on the strength of a single retry.

## Known fragility

- If MJ changes the `/imagine` slash command schema, run `mj-capture-command` to refresh.
- If MJ changes button `custom_id` format (currently `MJ::JOB::upsample::N::<uuid>`), the upscale step in `~/bin/mj-gen` needs a code patch.
- If the Discord token expires (password change, "log out everywhere," Discord flagging activity), all three commands fail with HTTP 401. User regenerates the token via DevTools and pastes into `secrets.env`.

See also: [[brp-day-one-style]] (if/when written) — the BRP Day One scenario uses a specific ink-sketch prompt template aimed at this pipeline.
