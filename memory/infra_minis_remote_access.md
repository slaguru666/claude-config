---
name: infra-minis-remote-access
description: "timevans-MINI-S (Zorin Linux box): static LAN IP 192.168.1.6, key-only SSH, fail2ban, Zyxel port-forward 2222->22 for external access"
metadata: 
  node_type: memory
  type: project
  originSessionId: e24d82e5-1bd0-48dc-99e6-9a4a434f0d2d
---

Host `timevans-MINI-S` (Zorin OS 18.1 Linux, the box this Claude Code runs on; CLAUDE.md still
describes it as a Mac Mini — outdated).

**Network / static IP**
- Wired iface `enp1s0` (MAC `78:55:36:05:8C:65`) locked to **static `192.168.1.6/24`** via NetworkManager
  profile "Wired connection 1" (`ipv4.method manual`), gateway `192.168.1.1`, DNS `192.168.1.1`. Survives reboot.
- Wi-Fi `wlo1` ("Buzzard") is a separate iface on `192.168.0.240/24` — unrelated.
- Router/gateway: **Zyxel DX3301-T0** at `192.168.1.1`, ISP **Voneus** broadband. Public IP seen as
  `185.66.205.125` (verify it's not CGNAT — check router WAN IP; 100.64.x.x = CGNAT, would block port-forwarding).

**SSH hardening (key-only)**
- `/etc/ssh/sshd_config.d/99-hardening.conf`: `PasswordAuthentication no`, `KbdInteractiveAuthentication no`,
  `PermitRootLogin no`, `PubkeyAuthentication yes`, `MaxAuthTries 3`, `LoginGraceTime 20`, `X11Forwarding no`.
- `~/.ssh/authorized_keys` holds the laptop key `ssh-ed25519 ... foundry-server` (client `192.168.1.52`).
- **fail2ban** installed, active+enabled; sshd jail = 4 retries / 10m -> 1h ban (`/etc/fail2ban/jail.local`).
- sshd listens on port **22** internally (not changed).

**External access**
- Zyxel **port-forward** maps WAN `2222` -> `192.168.1.6:22` (TCP). Connect from outside:
  `ssh -p 2222 timevans@<public-ip-or-DDNS>`. DHCP reservation for the MAC -> .6 recommended on the router to
  avoid lease conflicts. If public IP is dynamic, set up DDNS on the Zyxel.
- The `~/.ssh/id_ed25519` key on this host is the [[user-github]] outbound GitHub key, NOT a login key.

**Why:** user wants secure remote SSH into this machine over the internet; static IP + key-only auth +
fail2ban + a single forwarded port is the agreed setup.
