# Home Manager

Standalone Home Manager configs per user/host.

- Purpose: manage user environments separately from system configs.
- Primary user: `casper` (initial), add more under `home/` later.
- Tip: keep sensitive values out of HM; use secrets tooling when needed.

Planned structure:
- `home/casper/default.nix` (base)
- `home/casper/hosts/laptop-casper.nix` (host-specific extras)

Usage (standalone HM):
- Install HM on the system host, then run:
  - `home-manager switch --flake .#casper@laptop-casper`
  - We will add flake outputs for HM users later if desired.
