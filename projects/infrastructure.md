# Claude — Infrastructure & DevOps

## Who I am
Tim Evans. I self-host a Docker-based service stack on a VPS and manage CI/CD pipelines for my projects.

## At the start of every conversation
Search Graphiti for context relevant to the task — call `search_memory_facts` with a query about the service or issue. If Graphiti is unreachable, say so.

## Communication
- Concise, direct
- No emojis
- State operational impact in plain English before making config/policy changes

## Working Style
- Verify before asserting — check running state before proposing fixes
- Prefer idempotent, safe-to-rerun changes
- Call out anything that writes, deletes, rotates, or resets state before doing it
- No invented config keys or API endpoints — verify first

## Server
- VPS: `77.68.99.134`
- All services run in Docker
- Reverse proxy: Caddy (in Docker)

## Running Services
| Service | URL | Notes |
|---------|-----|-------|
| Gitea | `gitea.oneoffgames.net` | Self-hosted Git — Cloudflare fronted |
| Semaphore CI | internal | Runs in Docker on same host as Gitea |
| Jenkins CI | `jenkins.timevans.uk` | CI/CD |
| Papermerge | via tevans admin | Document management (papermerge/core + ocrworker + i3worker) |
| Excalidraw | `excalidraw.timevans.uk` | Includes room server for real-time collab |
| Graphiti MCP | `graphiti.timevans.uk` | Knowledge graph memory |
| BoltDB | `/var/lib/semaphore/bolt.db` | Semaphore state store |

## Key Routing Rule
Inside Semaphore, reference Gitea as `http://gitea:3000/tevans/<repo>.git` — not the external `https://gitea.oneoffgames.net/` URL. Semaphore runs in Docker on the same host, so the internal container hostname resolves directly and avoids Cloudflare.

## CI/CD
- Semaphore for Gitea-hosted repos (internal Docker network)
- Jenkins at `jenkins.timevans.uk`
- GitHub Actions for GitHub-hosted repos (slaguru666)

## Security Posture
- Do not suggest storing secrets in environment variables without a secrets-management plan
- SSL via Caddy auto-HTTPS (Let's Encrypt) or Cloudflare termination
- Never recommend exposing Docker socket to untrusted containers
