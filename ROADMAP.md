# MyNixOS Roadmap

> This file tracks what we will build and what we have done for a professional, public NixOS configuration using flakes and Home Manager (standalone). The repo root mirrors `/etc/nixos/`.

## Principles
- [x] Use flakes; pin `nixpkgs` to unstable
- [x] Home Manager standalone; manage full user envs
- [x] Multi-host design: laptop, desktop, server, VM, WSL, cloud
- [x] Roles + profiles + modules; minimal overlays initially
- [x] Allow unfree packages

## Open Questions (to revisit later)
- [ ] CI (format/lint/eval) with GitHub Actions
- [ ] Backup strategy (restic/borg) and data retention
- [ ] Additional overlays/inputs (NUR, others)

---

## Global Decisions
- **Firmware**: UEFI by default (per-host override allowed)
- **Filesystem**: BTRFS + LUKS, subvolumes, optional snapshots (snapper)
- **Hibernate**: Enabled on laptops (swapfile/partition + resume), optional per-host toggle
- **Audio**: PipeWire + WirePlumber
- **Bluetooth**: enabled
- **Printing/Scanning**: CUPS + SANE
- **Networking**: NetworkManager for Wi‑Fi/Ethernet
- **Firewall**: disabled by default; per-host rules section for selective ports
- **Web**: nginx
- **Containers**: Docker; Kubernetes via k3s (servers/cloud role)
- **Databases**: MySQL, MSSQL, Redis (client and server available via roles)
- **Desktop**: KDE Plasma 6 + SDDM on desktop/laptop (Wayland); headless on server/cloud
- **User**: `casper` (bash)
- **Locale/KB/Time**: Africa/Cairo, `en_US.UTF-8` + `ar_EG.UTF-8`; `us,ara` with Alt+Shift toggle
- **Browsers**: Firefox on non-server machines
- **Fonts**: Inter + JetBrainsMono Nerd Font (modifiable)

---

## Repository Plan (no code yet)
- [ ] Create `flake.nix` with inputs: `nixpkgs` (unstable), `home-manager`, optional `nixos-hardware` (for later)
- [ ] Define `nixConfig` (substituters, experimental-features)
- [ ] Structure folders:
  - [ ] `hosts/` (per machine)
  - [ ] `modules/` (system modules)
  - [ ] `roles/` (composable roles: workstation, server, gaming, db, k3s)
  - [ ] `profiles/` (user-facing bundles: laptop, desktop, server, cloud)
  - [ ] `home/` (Home Manager configs per user/host)
  - [ ] `overlays/` (empty for now)
  - [ ] `secrets/` (placeholder; choose sops-nix or agenix later)

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
- [x] Initialize Git, set remote, sync `main`
- [x] Capture requirements and decisions in this roadmap
- [ ] Implement `flake.nix` skeleton
- [ ] Add base modules and roles scaffolding
- [ ] Create first host (`laptop-casper`) and HM user `casper`
- [ ] Test `nixos-rebuild switch --flake` locally (later)

-NoNewline
