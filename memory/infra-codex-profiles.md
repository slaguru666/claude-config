---
name: infra-codex-profiles
description: "Codex profiles: per-file config, why the kit's root keys silently did nothing, and that only gpt-6-astra and gpt-5.5 still answer"
metadata:
  node_type: memory
  type: reference
---

Codex 0.154 refuses `--profile <name>` while `~/.codex/config.toml` still holds a
`profile = ` selector or `[profiles.*]` tables. Profiles are one file each —
`~/.codex/<name>.config.toml`, keys at root level. `codex-ops-kit` was fixed for
this upstream in July/August 2026; on 2026-09-13 both clones on the Mac were
stale at `de379e4` and the fixed installer had never been run, so `--profile
deep` had been failing for weeks.

**Two traps, both fixed in the kit but worth recognising if they recur:**

A managed block appended to a `config.toml` that already has table headers has
its **bare root keys parsed as belonging to the preceding table**. On this Mac
the kit's `model`, `profile` and `web_search` had landed inside
`[projects."…/New project"]`, doing nothing, while the installer stripped the
Codex app's own root settings to make room for them. Root keys must precede
every `[table]` header. The Codex app also writes past the block's end marker and
had dropped it, stranding the start marker.

**Model names go stale and break the CLI outright**, not gracefully — a wrong one
is a 400 on every invocation, plain `codex` included. As of 2026-09-13 only
`gpt-6-astra` and `gpt-5.5` answer for a ChatGPT account; `gpt-5.4`,
`gpt-5.4-mini`, `gpt-5.5-mini`, `gpt-6-astra-mini`, `gpt-6-astra-codex`,
`gpt-5.5-codex`, `o4-mini` and `codex-mini-latest` are all refused. Probe with
`codex exec -m <name> hi` before pinning one.

**How to apply:** edit templates in the kit (`~/Documents/Code/GitHub/codex-ops-kit`,
also cloned at `~/Documents/Code/codex-ops-kit` — pull both), never the live
files. After any kit change run `scripts/install_codex_kit.sh` and then actually
check `codex --profile deep` and plain `codex` both complete a round trip; the
installer reports success regardless. Related: [[feedback-codex-review-loop]].
