# Profiles

This directory will contain reusable bundles, e.g., `laptop`, `desktop`, `server`, `cloud`, `wsl`.

- Purpose: group common toggles and imports for a class of machines.
- Keep profiles small and focused: set toggles and import roles/modules.
- Avoid machine-specific values; those live under `hosts/`.

Examples (planned):
- `profiles/laptop.nix`: hibernation, power tweaks, workstation role.
- `profiles/desktop.nix`: workstation role without laptop power tweaks.
- `profiles/server.nix`: headless defaults, SSH, optional allowed ports.
- `profiles/cloud.nix`: cloud-init friendliness, minimal services.
- `profiles/wsl.nix`: WSL-specific adjustments.
