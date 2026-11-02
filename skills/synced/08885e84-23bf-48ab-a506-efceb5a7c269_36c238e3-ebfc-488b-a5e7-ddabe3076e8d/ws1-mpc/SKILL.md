---
name: ws1-mpc
description: "Answer Workspace ONE Modern Private Cloud questions from the local knowledge base, with citations back to the source docs."
---

# Workspace ONE Modern Private Cloud

A curated knowledge base for WS1 MPC lives at `~/Notes/mpc-kb`, built from the
`mpc-docs` source repository at `~/mpc-docs`. Use it before answering from
general knowledge — MPC is a partner-facing on-premises product and general
knowledge about Workspace ONE SaaS is frequently wrong about it.

## Steps

1. **Orient.** Read `~/Notes/mpc-kb/README.md` for the layout, then the file
   matching the question:

   | Question is about | Read |
   |---|---|
   | How the system fits together, why HashiStack, vocabulary | `00-map/architecture.md` |
   | Learning paths, teaching, audience sequencing | `00-map/knowledge-map.md` |
   | What the docs do and don't cover, gaps, freshness | `00-map/source-inventory.md` |
   | A term or component | `10-concepts/glossary.md` |
   | Deploying, prerequisites, install order | `20-procedures/deployment-path.md` |
   | Upgrades, backup/DR, Mod Stack stages, lifecycle | `20-procedures/operations.md` |
   | A `wso` command or flag | `30-cli/wso-cli-index.md` |
   | Something is broken | `40-troubleshooting/routing.md` |
   | DST/OpenSearch drift, device data missing | `40-troubleshooting/scripts.md` |

2. **Go to source when the KB is thin.** The KB summarises and routes; the full
   text is in `~/mpc-docs/docs/*.md`. Grep there for detail. The published site
   is <https://ws1mpc.omnissa.com/> if the local clone is unavailable.

3. **Cite.** Every substantive claim gets a link to the source page
   (`https://ws1mpc.omnissa.com/<page>/`) or the repo path. Do not paraphrase
   procedures without pointing at the page they came from.

4. **Flag gaps rather than filling them.** Eleven documented pages are empty,
   including Logs, UEM Performance, Tutorials and Security Policy. If the answer
   would live on one of those, say the upstream page is empty instead of
   inventing content. Check `00-map/source-inventory.md`.

## Facts worth holding

- MPC is a **migration in progress**: a new cloud-native control plane running
  alongside legacy UEM application servers, with the legacy half being phased
  out. Confusion usually traces back to not knowing this.
- `wso cp` is an **alias** of `wso control-plane`. The CLI reference page looks
  like 192 sections; there are 27 real commands.
- Consul and Nomad both have an **Agent** and a **Server** meaning different
  things. Always qualify.
- Upgrade order is fixed: CLI → control plane platform → control plane services
  → asset cleanup → UEM Windows services.
- Mod Stack enablement runs as **8 tracked stages** (5 write, 2a/2b/2c-2d read).
  A stage stuck at `STARTED` usually means a readiness flag has not flipped.
- `install.md` is the richest deployment page (22 diagrams) and is **not in the
  site nav**.

## Verification

- Confirm the KB is current before relying on it for anything being taught:
  `cd ~/mpc-docs && git log -1 --date=short --format=%h\ %ad`, compare against
  the `lastmod` dates in <https://ws1mpc.omnissa.com/sitemap.xml>.
- Refresh with:
  `cd ~/mpc-docs && git pull && python3 ~/Notes/mpc-kb/.build/build_kb.py ~/mpc-docs ~/Notes/mpc-kb`
- If the device is not linked or the folder not connected, say so and fall back
  to the public site rather than answering from memory.