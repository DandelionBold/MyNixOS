# MyNixOS Roadmap

> This file tracks what we will build and what we have done for a professional, public NixOS configuration using flakes and Home Manager (standalone). The repo root mirrors `/etc/nixos/`.

## How to use this roadmap
- [ ] Each main section has nested checklists. A parent task is considered done only when all its sub‑tasks are checked.
- [ ] Use `[ ]` for not started, `[~]` for in progress, `[x]` for done.
- [ ] Keep short explanations inline below each item so the intent is clear.
- [ ] For per‑host work, track progress inside the specific host section.

## Principles
- [ ] Use flakes; pin `nixpkgs` to unstable
  - [ ] Definition: Use `flake.nix`/`flake.lock`; track `nixpkgs` on unstable.
  - [ ] Acceptance: `nix flake metadata` works; `flake.lock` committed.
- [ ] Home Manager standalone; manage full user envs
  - [ ] Definition: Install HM and configure per‑user in standalone mode.
  - [ ] Acceptance: `home-manager switch` works for `casper`.
- [ ] Multi-host design: laptop, desktop, server, VM, WSL, cloud
  - [ ] Definition: `hosts/` contains per‑host trees using shared modules/roles.
  - [ ] Acceptance: Two distinct hosts build successfully with shared modules.
- [ ] Roles + profiles + modules; minimal overlays initially
  - [ ] Definition: Features are composable via `roles/` and `modules/` with small focused files.
  - [ ] Acceptance: Enabling/disabling a role changes the build predictably.
- [ ] Allow unfree packages
  - [ ] Definition: `nixpkgs.config.allowUnfree = true;` set globally, overridable per host.
  - [ ] Acceptance: Unfree packages (e.g., `steam`) evaluate when role enabled.

## Open Questions (to revisit later)
- [ ] CI (format/lint/eval) with GitHub Actions
- [ ] Backup strategy (restic/borg) and data retention
- [ ] Additional overlays/inputs (NUR, others)

---

## Global Decisions
- [ ] Firmware: UEFI by default (per-host override allowed)
  - Why: Modern default; enables secure boot later.
  - Override: Set per host in `hosts/<name>/hardware-configuration.nix` if BIOS.
- [ ] Filesystem: BTRFS + LUKS (subvolumes, compression, snapshots via snapper)
  - Why: Snapshots + compression benefit laptops/desktops; easy rollback.
  - Override: Allow ext4+LUKS or ZFS per host if needed.
- [ ] Hibernate: Enabled on laptops (swap + resume)
  - Why: Power savings; optional per‑host toggle.
  - Verify: `systemctl hibernate` resumes successfully.
- [ ] Audio: PipeWire + WirePlumber
  - Why: Replaces PulseAudio/JACK; better screen share + Bluetooth.
- [ ] Bluetooth: enabled
  - Verify: `bluetoothctl` can scan/pair; media controls work.
- [ ] Printing/Scanning: CUPS + SANE
  - Verify: Test page prints; `scanimage -L` detects device.
- [ ] Networking: NetworkManager for Wi‑Fi/Ethernet
  - Verify: `nmcli` lists devices and connects.
- [ ] Firewall: disabled globally; allow per‑host declarative port lists
  - Why: Simplicity; still allow specific ports on servers.
  - Verify: Ports open only when listed per host.
- [ ] Web: nginx
  - Verify: Default vhost responds on 80/443 when enabled.
- [ ] Containers: Docker; Kubernetes via k3s (servers/cloud role)
  - Verify: `docker run hello-world`; `kubectl get nodes` on k3s hosts.
- [ ] Databases: MySQL, MSSQL, Redis (client and server via roles)
  - Verify: Services start and accept local connections.
- [ ] Desktop: KDE Plasma 6 + SDDM on desktop/laptop (Wayland)
  - Verify: Wayland session works; SDDM greeter loads.
- [ ] User: `casper` (bash)
  - Verify: User exists; can `sudo` when configured.
- [ ] Locale/KB/Time: Cairo TZ; en_US + ar_EG; `us,ara` Alt+Shift
  - Verify: `locale`, `timedatectl`, keyboard layout switch.
- [ ] Browsers: Firefox on non-server machines
  - Verify: Launches and syncs (optional).
- [ ] Fonts: Inter + JetBrainsMono Nerd Font (modifiable)
  - Verify: Fonts available to system and HM profiles.

---

## Repository Plan (no code yet)
- [ ] Create `flake.nix` skeleton
  - [ ] Inputs: `nixpkgs` (unstable), `home-manager`, optional `nixos-hardware`
  - [ ] Outputs: `nixosConfigurations` (per host), `packages` (optional), `devShells` (optional)
  - [ ] `nixConfig`: substituters, trusted keys, `experimental-features` = `nix-command flakes`
  - Verify: `nix flake check` and `nix flake metadata` succeed.
- [ ] Create folder structure
  - [ ] `hosts/` per machine (each with minimal `default.nix`)
  - [ ] `modules/` focused NixOS modules (audio, bluetooth, locale, filesystems, etc.)
  - [ ] `roles/` composable roles (workstation/server/gaming/db/dev/k3s)
  - [ ] `profiles/` bundles (laptop/desktop/server/cloud/wsl)
  - [ ] `home/` for HM users (`casper` first)
  - [ ] `overlays/` empty placeholder
  - [ ] `secrets/` placeholder with README (tooling TBD)
  - Verify: Imports resolve; structure is visible in repository tree.
- [ ] Add base NixOS modules (scaffold only)
  - [ ] Filesystems: BTRFS subvolumes + LUKS options; snapper disabled by default
  - [ ] Hibernate: swap+resume toggles
  - [ ] Networking: NetworkManager enable
  - [ ] Bluetooth: enable
  - [ ] Printing/Scanning: CUPS + SANE enable
  - [ ] Audio: PipeWire + WirePlumber
  - [ ] Users: `casper`
  - [ ] Locale/time/keyboard settings
  - Verify: Modules evaluate standalone with example host.
- [ ] Add roles (scaffold only)
  - [ ] workstation: Plasma 6 + SDDM + Firefox + fonts
  - [ ] server: headless + OpenSSH + optional ports list + nginx
  - [ ] gaming: Steam/Proton (off by default)
  - [ ] db: MySQL, MSSQL, Redis (services off by default; enable per host)
  - [ ] dev: Docker + Python toolchain
  - [ ] k3s: single‑node server/agent toggle
  - Verify: Enabling a role adds expected options.
- [ ] First host: `laptop-casper`
  - [ ] Hardware config autogenerated
  - [ ] Import base modules + workstation role + laptop profile
  - [ ] HM: user `casper` linked
  - Verify: `nixos-rebuild build --flake .#laptop-casper` succeeds.
- [ ] Documentation touchpoints
  - [ ] Update ROADMAP checkboxes per milestone
  - [ ] Add brief `README.md` explaining how to build a host (later)

---

## Hosts (examples; to be created later)
- [ ] `hosts/laptop-casper/` (UEFI, BTRFS+LUKS, KDE Plasma, Hibernate)
- [ ] `hosts/desktop-casper/` (UEFI, BTRFS+LUKS, KDE Plasma)
- [ ] `hosts/server-01/` (UEFI, BTRFS+LUKS, headless, k3s, DB role)
- [ ] `hosts/vm-lab/` (UEFI, simple disk, headless)
- [ ] `hosts/wsl/` (WSL specific, no systemd journal quirks TBD)
- [ ] `hosts/cloud-01/` (cloud-init compatible, headless, k3s)

---

## Roles (toggle per host)
- [ ] `roles/workstation`:
  - [ ] KDE Plasma 6 + SDDM
  - [ ] Firefox, fonts, printing, scanning, Bluetooth
  - [ ] PipeWire + WirePlumber
  - [ ] NetworkManager
- [ ] `roles/server`:
  - [ ] Headless
  - [ ] OpenSSH enabled; harden auth; optional selected firewall ports
  - [ ] k3s (optional)
  - [ ] nginx
- [ ] `roles/gaming` (opt‑in):
  - [ ] Steam + Proton (disabled by default)
  - [ ] Gamescope (optional)
- [ ] `roles/db`:
  - [ ] MySQL server + client
  - [ ] MSSQL server + tools (EULA)
  - [ ] Redis server + client
- [ ] `roles/dev`:
  - [ ] Docker
  - [ ] Language toolchains: Python (initial), expand later

---

## Modules (system-wide building blocks)
- [ ] Filesystems: BTRFS subvolumes, compression, snapshots (snapper)
- [ ] Hibernate: swap + resume settings (laptop-only)
- [ ] Networking: NetworkManager defaults
- [ ] Bluetooth: enable + codec support
- [ ] Printing/Scanning: CUPS + SANE
- [ ] Audio: PipeWire stack
- [ ] nginx: base config + vhost templates
- [ ] k3s: single-node server/agent modules
- [ ] Databases: MySQL, MSSQL, Redis service modules
- [ ] Firewall rules module: off by default; declarative allowed ports list
- [ ] Users: `casper` base user
- [ ] Locale/time/keyboard module

---

## Home Manager (standalone)
- [ ] Define `home/` for `casper` with:
  - [ ] Shell (bash) config
  - [ ] Editor/terminal defaults (later)
  - [ ] Fonts/theming (KDE integration later)
  - [ ] App defaults (Firefox)

---

## Secrets (later)
- [ ] Choose one:
  - [ ] sops-nix (age or GPG)
  - [ ] agenix (age only)
- [ ] Create `secrets/README.md` with bootstrap steps (when chosen)

---

## Per-Host Firewall Rules (disabled globally)
- [ ] Example per-host allowed ports list (SSH 22, HTTP 80, HTTPS 443, DB ports as needed)

---

## Tasks Status Log
- [ ] Initialize Git, set remote, sync `main`
- [ ] Capture requirements and decisions in this roadmap
- [ ] Implement `flake.nix` skeleton
- [ ] Add base modules and roles scaffolding
- [ ] Create first host (`laptop-casper`) and HM user `casper`
- [ ] Test `nixos-rebuild switch --flake` locally (later)

-NoNewline
