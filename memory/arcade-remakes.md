---
name: arcade-remakes
description: "Standalone macOS arcade games (single-file Swift/AppKit), remakes and originals, each ~/<name> with a private slaguru666 repo"
metadata:
  node_type: memory
  type: project
  originSessionId: 62859eab-1eb2-4772-8388-71317b87ddbf
  modified: 2026-10-15T21:51:45.794Z
---

Two arcade remakes built 2026-10-15, each a single `Sources/main.swift` (AppKit + AVAudioEngine synthesized sound, no deps) plus `Sources/makeicon.swift` and `build.sh` (`--install` copies the .app to ~/Applications).

- ~/asteroids -> github.com/slaguru666/asteroids (private)
- ~/battlezone -> github.com/slaguru666/battlezone (private)
- ~/pacman -> github.com/slaguru666/pacman (private), app is PacMan.app
- ~/spaceinvaders -> slaguru666/spaceinvaders, built by a separate session 2026-10-15
- ~/defender -> github.com/slaguru666/defender (private)
- ~/shardfall -> github.com/slaguru666/shardfall (private): ORIGINAL game (not a remake) the user asked to be invented for 2026 with a retro vibe; shards/multiplier/overdrive/dash/sector upgrades/singularity/Monolith boss, adaptive synthwave music
- ~/gridfront -> github.com/slaguru666/gridfront (private): ORIGINAL 2026 take on Battlezone (reuses its 3D projection); hover tank w/ shield+hull, strafe, boost, homing salvos, salvage->armory, wasps/mortars (ground rings)/hoppers, storm every 4th zone, Juggernaut boss every 5th (turrets first)
- ~/missilecommand -> github.com/slaguru666/missilecommand (private), app MissileCommand.app: classic rules + mouse aim, combo chains, per-wave upgrade pick, EMP slow-time, hypersonic warheads, orbital platform boss every 5th; first game with stereo pan + AVAudioUnitReverb (pool -> fxMix -> reverb -> main)
- ~/wavelance -> github.com/slaguru666/wavelance (private): ORIGINAL R-Type-style shooter (user asked for "a new r-type"); charge beam, detachable pod (3 colours), bits, 3 stages + bosses, loop; 4 melodic synth tracks via a parameterised track() generator. Gotcha found: enemies parked at the boss core absorb shots - clear them at boss start
- ~/lunar-lander -> slaguru666/lunar-lander (pre-existing Electron HTML game): added `mac/` WKWebView wrapper (LunarLander.swift + build.sh) around the unchanged lunar-lander.html; verify via screencapture of the real window, a hidden WKWebView throttles rAF and snapshots black
- ~/scramble2026 -> github.com/slaguru666/scramble2026 (private): modern Scramble, 6 zones, fuel tank forced every 50 cols, afterburner, flak, Citadel boss. Gotcha: the ship is clamped to x<=768, so the boss target must stop inside that reach
- ~/periapsis -> github.com/slaguru666/periapsis (private): ORIGINAL vector game, orbital gravity around a central planet; shots fall too (slingshot/orbital bonuses), raiders land and drill cities, Eclipse boss every 5th. Gotchas: never mutate `shots` with removeAll inside collide()'s index walk (expire via life=0); keep boss orbit clear of the player's default orbit; things in eccentric orbits must not be able to strand a wave off-screen
- ~/asteroids-deluxe -> github.com/slaguru666/asteroids-deluxe (private); user asked for "Asteroids 2" = Asteroids Deluxe (no official "Asteroids 2"); built from the Asteroids base, original shapes/sounds, no ROM assets

Windows of apps launched with `open -g` report a tiny skewed frame (opening animation unfinished) until activated; not a sizing bug.

Verification pattern that worked: strip the last 5 lines (app startup) with sed, compile with a headless autopilot harness, render frames to PNG. Do not drive the desktop with synthetic keys while the user is active — keystrokes landed in Chrome once.

**Why:** the user may ask for more remakes in the same style. **How to apply:** reuse the GameView/AppDelegate/Sound skeleton and build.sh from either repo.
