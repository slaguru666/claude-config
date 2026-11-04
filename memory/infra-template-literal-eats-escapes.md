---
name: infra-template-literal-eats-escapes
description: "JavaScript written inside a .mjs generator's template literal loses \\n and \\d at generation time — the emitted script dies on an unterminated string while the page still renders perfectly"
metadata:
  node_type: memory
  type: reference
  originSessionId: 710730ff-4590-4412-82b8-d6ae6765d92b
  modified: 2026-11-04T13:00:00.000Z
---

A Node generator that builds an HTML page with a backtick template literal, and embeds a
`<script>` inside it, silently processes every escape in that script. `src.join('\n')` is
emitted as `join('` + a real newline + `')` — an **unterminated string literal** — and
`/[\d.]+/` becomes `/[d.]+/`, a regex that matches the wrong thing without erroring.

The failure is quiet in the way that matters: the page still renders, the stylesheets still
load, the screenshot still looks right. Only `Uncaught SyntaxError: Invalid or unexpected
token` in the console says the script never ran, and nothing in the generator's own output
hints at it. In RingBRP this hid three contrast sweeps that appeared to exist and did not.

**How to apply:** do not write JavaScript inside a template literal in a generator. Put it in
its own plain `.js` file and inline it with `readFile`, which cannot process escapes. If it
must be inline, check the EMITTED file rather than the source: `grep "join('\\\\n')" out.html`
should show the backslash-n, and seeing `join(' ')` split across two lines is the bug. Related:
[[feedback-check-the-instrument]], [[ringbrp-project]].
