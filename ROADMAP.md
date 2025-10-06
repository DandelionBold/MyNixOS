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
- [ ] `hosts/laptop-casper/`
  - [ ] UEFI; BTRFS+LUKS; Hibernate enabled
  - [ ] Import: base modules + `roles/workstation` + `profiles/laptop`
  - [ ] GPU: auto (tune later if NVIDIA/AMD)
  - Verify: Wayland session works, sleep/hibernate OK, Wi‑Fi/Bluetooth OK
- [ ] `hosts/desktop-casper/`
  - [ ] UEFI; BTRFS+LUKS; Hibernate optional
  - [ ] Import: base modules + `roles/workstation` + `profiles/desktop`
  - [ ] GPU: auto (tune later if NVIDIA/AMD)
  - Verify: Wayland session, audio, printing OK
- [ ] `hosts/server-01/`
  - [ ] UEFI; BTRFS+LUKS; headless
  - [ ] Import: base modules + `roles/server` (+ `roles/db` + `roles/k3s` optional)
  - Verify: SSH reachable; nginx default site; DB services disabled by default until enabled
- [ ] `hosts/vm-lab/`
  - [ ] UEFI; simple disk; headless
  - [ ] Import: base modules + `profiles/vm`
  - Verify: boots under common hypervisors
- [ ] `hosts/wsl/`
  - [ ] WSL specifics; no systemd journal quirks TBD
  - [ ] Import: minimal services; HM for user envs
  - Verify: HM works; networking OK
- [ ] `hosts/cloud-01/`
  - [ ] cloud-init compatible; headless
  - [ ] Import: base modules + `roles/server` (+ `roles/k3s` optional)
  - Verify: SSH with keys; firewall port list applied if enabled

---

## Roles (toggle per host)
- [ ] `roles/workstation`
  - [ ] Enable KDE Plasma 6 + SDDM (Wayland)
  - [ ] PipeWire + WirePlumber; Bluetooth; printing/scanning
  - [ ] Apps: Firefox; fonts: Inter + JetBrainsMono Nerd
  - Verify: Login via SDDM; audio/Bluetooth/printing OK
- [ ] `roles/server`
  - [ ] Headless; OpenSSH enabled; hardened auth (no root login, no password auth)
  - [ ] Optional firewall allow‑list per host
  - [ ] nginx base service (off by default until host enables)
  - Verify: SSH key auth works; ports as declared
- [ ] `roles/gaming` (opt‑in)
  - [ ] Steam + Proton (disabled by default); Gamescope optional
  - [ ] NVIDIA toggles available (only if needed later)
  - Verify: Steam runs when role enabled
- [ ] `roles/db`
  - [ ] MySQL server + client (disabled by default)
  - [ ] MSSQL server + tools (EULA) (disabled by default)
  - [ ] Redis server + client (disabled by default)
  - Verify: Services start and bind only when host enables
- [ ] `roles/dev`
  - [ ] Docker engine + group membership
  - [ ] Language toolchains: Python initial; extend later
  - Verify: `docker run hello-world` works for user when enabled

---

## Modules (system-wide building blocks)
- [ ] Filesystems: BTRFS subvolumes, compression, snapshots (snapper)
  - [ ] Subvolumes: `@`, `@home`, `@nix`, `@log`, `@cache` (example)
  - [ ] Compression: zstd; noatime; SSD opts
  - [ ] Snapper: config skeleton (disabled by default)
  - Verify: Mounts match design; `btrfs subvolume list` shows expected
- [ ] Hibernate: swap + resume settings (laptop-only)
  - [ ] Create swapfile/partition; set `boot.resumeDevice`
  - Verify: Hibernation cycle succeeds
- [ ] Networking: NetworkManager defaults
  - [ ] Enable service; disable legacy wpa_supplicant management
  - Verify: `nmcli` works
- [ ] Bluetooth: enable + codec support
  - [ ] Enable service; add `bluez` utils; media keys support
  - Verify: Pairing/codec OK
- [ ] Printing/Scanning: CUPS + SANE
  - [ ] Enable `services.printing` and `hardware.sane`
  - Verify: Test page prints; scanner detected
- [ ] Audio: PipeWire stack
  - [ ] Enable PipeWire, WirePlumber, ALSA/JACK compatibility
  - Verify: Default sink/source present
- [ ] nginx: base config + vhost templates
  - [ ] Provide example vhost; TLS placeholder
  - Verify: Curl http(s) returns expected
- [ ] k3s: single-node server/agent modules
  - [ ] Toggle server/agent with token
  - Verify: `kubectl get nodes` OK
- [ ] Databases: MySQL, MSSQL, Redis service modules
  - [ ] Unit files and basics; services off by default
  - Verify: Services start when host enables
- [ ] Firewall rules module: off by default; declarative allowed ports list
  - [ ] Option `allowedTCPPorts`/`allowedUDPPorts` per host
  - Verify: Only declared ports open
- [ ] Users: `casper` base user
  - [ ] Create user; groups; optional sudo
  - Verify: Login works
- [ ] Locale/time/keyboard module
  - [ ] Timezone Cairo; locales en_US/ar_EG; `us,ara` Alt+Shift
  - Verify: `locale`, `timedatectl`, layout switch

---

## Home Manager (standalone)
- [ ] Define `home/` for `casper` with:
  - [ ] Shell (bash) config; prompt; aliases; history policy
  - [ ] Editor/terminal defaults (later)
  - [ ] Fonts/Theming (align with KDE later)
  - [ ] Apps: Firefox
  - Verify: `home-manager switch` completes with no changes pending

---

## Secrets (later)
- [ ] Choose one:
  - [ ] sops-nix (age or GPG)
  - [ ] agenix (age only)
- [ ] Create `secrets/README.md` with bootstrap steps (when chosen)
  - For sops-nix: create age key; store in `secrets/`; example secret
  - For agenix: generate age key; map users; example secret

---

## Per-Host Firewall Rules (disabled globally)
- [ ] Example per-host allowed ports list (SSH 22, HTTP 80, HTTPS 443, DB ports as needed)
  - [ ] Template: `allowedTCPPorts = [ 22 80 443 ]; allowedUDPPorts = [ ];`
  - Verify: `ss -tulpen` shows only listed ports when firewall enabled per host

---

## Tasks Status Log
- [ ] Initialize Git, set remote, sync `main`
  - [x] Init local repo
  - [x] Set `origin` to GitHub
  - [x] Fetch and track `main`
  - [x] Push changes
- [ ] Capture requirements and decisions in this roadmap
  - [x] Questionnaire answered and recorded
  - [x] Structure and conventions defined
- [ ] Implement `flake.nix` skeleton
  - [ ] Inputs/outputs defined; `nix flake check` passes
- [ ] Add base modules and roles scaffolding
  - [ ] Modules compile standalone; roles toggle cleanly
- [ ] Create first host (`laptop-casper`) and HM user `casper`
  - [ ] `nixos-rebuild build --flake .#laptop-casper` succeeds
- [ ] Test `nixos-rebuild switch --flake` locally (later)

-NoNewline
