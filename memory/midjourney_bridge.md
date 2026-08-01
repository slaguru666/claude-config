---
name: midjourney-bridge
description: "Local CLI for generating Midjourney images via Discord from any Claude session — call mj-gen with a prompt, get a PNG file you can read/place."
metadata: 
  node_type: memory
  type: reference
  originSessionId: fa4ca039-8c0e-4b9c-aee8-b6d7a81482b5
  modified: 2026-07-19T14:01:49.937Z
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

## Known fragility

- If MJ changes the `/imagine` slash command schema, run `mj-capture-command` to refresh.
- If MJ changes button `custom_id` format (currently `MJ::JOB::upsample::N::<uuid>`), the upscale step in `~/bin/mj-gen` needs a code patch.
- If the Discord token expires (password change, "log out everywhere," Discord flagging activity), all three commands fail with HTTP 401. User regenerates the token via DevTools and pastes into `secrets.env`.

See also: [[brp-day-one-style]] (if/when written) — the BRP Day One scenario uses a specific ink-sketch prompt template aimed at this pipeline.
