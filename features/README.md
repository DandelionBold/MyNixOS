# Roles

Roles are composable feature sets (e.g., `workstation`, `server`, `gaming`, `db`, `dev`, `k3s`).

- Purpose: enable/disable groups of options as a single toggle per host.
- Guideline: roles should only import modules and set options related to that role.
- Avoid host-specific details; configure those under `hosts/`.

Examples (planned):
- `roles/workstation`: Plasma 6 + SDDM, PipeWire, printing, Bluetooth, Firefox, fonts.
- `roles/server`: headless, OpenSSH, optional allowed ports, nginx baseline.
- `roles/gaming`: Steam/Proton (opt-in), Gamescope optional.
- `roles/db`: MySQL, MSSQL, Redis (disabled by default; enable per host).
- `roles/dev`: Docker and language toolchains.
- `roles/k3s`: single-node server/agent toggle.
