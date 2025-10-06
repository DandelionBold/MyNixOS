# MyNixOS

A professional, multi-host NixOS configuration using flakes and Home Manager (standalone).

## Quick Start

### Building a Host

To build a specific host configuration:

```bash
# Build the configuration (dry run)
nixos-rebuild build --flake .#laptop

# Switch to the configuration (on a NixOS system)
nixos-rebuild switch --flake .#laptop

# Build for a different host
nixos-rebuild build --flake .#desktop
```

### Available Hosts

- `laptop` - Laptop with KDE Plasma, hibernate support
- `desktop` - Desktop with KDE Plasma, no hibernate
- `server` - Headless server with SSH, nginx, databases
- `vm` - Virtual machine optimized configuration
- `cloud` - Cloud instance configuration

### Home Manager

To manage user environments with Home Manager:

```bash
# Switch user environment for casper
home-manager switch --flake .#casper@laptop
```

## Architecture

This configuration uses a modular approach:

- **`hosts/`** - Per-machine configurations
- **`roles/`** - Composable feature sets (workstation, server, gaming, etc.)
- **`profiles/`** - Host type bundles (laptop, desktop, vm, etc.)
- **`modules/`** - System-wide building blocks
- **`home/`** - Home Manager user configurations

## Configuration

### Global Settings

- **System**: x86_64-linux (configurable)
- **Channel**: nixpkgs unstable
- **Unfree packages**: Allowed globally
- **Firewall**: Disabled globally (per-host allow-lists available)

### Key Features

- **Desktop**: KDE Plasma 6 + SDDM (Wayland)
- **Audio**: PipeWire + WirePlumber
- **Networking**: NetworkManager
- **Development**: Docker, Python toolchain
- **Databases**: MySQL, MSSQL, Redis (disabled by default)
- **Containers**: k3s for Kubernetes

## Development

### Adding a New Host

1. Create `hosts/your-host/default.nix`
2. Import required modules and roles
3. Add to `flake.nix` outputs
4. Test with `nixos-rebuild build --flake .#your-host`

### Adding a New Role

1. Create `roles/your-role.nix`
2. Define role-specific configuration
3. Import in relevant hosts or profiles

### Adding a New Module

1. Create `modules/your-module.nix`
2. Define module options and configuration
3. Import in hosts that need the functionality

## Roadmap

See [ROADMAP.md](ROADMAP.md) for detailed progress tracking and planned features.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
