---
type: project
status: active
repo: none
path: ssh livekit (149.102.145.10)
updated: 2026-09-20
---

# Media box (vmi2924158)

**What it is** — The **third** Contabo box, and until 2026-09-20 it was not in
this vault at all. Ubuntu 24.04.3, 4 vCPU / 7.8 GB, 145 GB disk (111 GB free).
`ssh livekit` reaches it as root. It is the home for [[parley]]'s LiveKit and
token service.

**Not to be confused with** [[oneoffgames-vps]] (`ssh foundry`,
85.190.246.132, `vmi2869320`) — the live game box — or `nodeserver`
(178.238.235.121), which rejects every key on the Mac.

**What it runs**
| Thing | Where |
|---|---|
| Nextcloud stack (fpm + mariadb + redis + Caddy) | `/opt/nextcloud-stack` |
| **Backup Foundry** | `/opt/foundryvtt`, data `/opt/foundrydata`, port 30000 → `foundry2.oneoffgames.com` |
| filebrowser | 8080 → `files2.oneoffgames.com` |
| omni-tools, bentopdf, onitools, Stirling-PDF | containers |

**TLS is a Caddy *container*, not a system service.** `nextcloud-stack-caddy-1`
holds 80 and 443; system `caddy` is inactive and there is no nginx. The config
is the host file **`/opt/nextcloud-stack/Caddyfile`**, mounted in. Add a site by
editing that file, then `docker exec nextcloud-stack-caddy-1 caddy validate` and
`caddy reload` — graceful, does not drop Nextcloud. **Back it up first**: it
fronts a working Nextcloud.

**Gotchas**
- **No default-deny firewall.** `-P INPUT ACCEPT`, ufw not installed. Only a few
  explicit ACCEPTs exist (30000, 40000-40100, 21). Anything bound to 0.0.0.0 here
  is on the internet — assume nothing is protected by the network.
- **Do not run LiveKit's bundled single-VM installer here.** It stands up its own
  Caddy on 443, which the Nextcloud container already holds. Run the binary and
  proxy to it instead.
- The Caddy container is on its own compose network and **cannot reach host
  loopback**. Existing blocks proxy to the host's *public* IP
  (`reverse_proxy 149.102.145.10:30000`) — follow that precedent, and remember it
  means the backing port is internet-reachable too.
- DNS for `oneoffgames.com` is at **Porkbun**; `rtc.` and `turn.` point here,
  everything else at the game box.

Related: [[parley]], [[oneoffgames-vps]], [[mini-s]]
