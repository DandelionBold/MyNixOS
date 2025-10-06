# MyNixOS: Quick Start Guide

For experienced users who want to get started quickly.

## Prerequisites
- NixOS system
- Git installed
- Basic NixOS knowledge

## Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/DandelionBold/MyNixOS.git
   cd MyNixOS
   ```

2. **Build a configuration:**
   ```bash
   # For laptop
   nixos-rebuild switch --flake .#laptop
   
   # For desktop
   nixos-rebuild switch --flake .#desktop
   
   # For personal laptop
   nixos-rebuild switch --flake .#laptop@personal
   ```

## Available Configurations

| Configuration | Description |
|---------------|-------------|
| `laptop` | Base laptop configuration |
| `laptop@personal` | Laptop with personal customizations |
| `desktop` | Base desktop configuration |
| `server` | Server configuration |
| `vm` | Virtual machine configuration |
| `cloud` | Cloud server configuration |

## Key Features

### Applications
- **Browsers**: Firefox
- **Terminals**: Alacritty, Kitty, GNOME Terminal
- **File Managers**: Dolphin, Thunar, Ranger
- **Text Editors**: Vim, Emacs, Neovim, Kate, Gedit
- **Screenshot Tools**: Spectacle, Flameshot, OBS Studio
- **Media Tools**: VLC, GIMP, Krita, Audacity
- **Office Suite**: LibreOffice

### Development
- **Languages**: Python, Node.js (extensible)
- **Containers**: Docker, Kubernetes (k3s)
- **Databases**: MySQL, MSSQL, Redis
- **IDEs**: VSCode
- **Version Control**: Git, GitHub CLI

### Desktop Environment
- **KDE Plasma 6** with Wayland
- **Themes**: Dark/Light variants
- **Fonts**: Fira Code, Noto fonts
- **Backgrounds**: Customizable local images

### System Features
- **Audio**: PipeWire
- **Bluetooth**: Full support
- **Printing**: CUPS
- **Power Management**: Laptop optimizations
- **Hibernation**: Laptop support
- **Networking**: NetworkManager

## Customization

### Adding Packages
Edit the relevant feature file in `features/`:
```nix
environment.systemPackages = with pkgs; [
  existing-package
  new-package
];
```

### Adding Services
Edit the relevant feature file:
```nix
services.new-service = {
  enable = true;
  # configuration
};
```

### Creating New Host
1. Create `hosts/my-host/default.nix`
2. Add to `flake.nix` nixosConfigurations
3. Import desired features

### Creating New Feature
1. Create file in appropriate `features/` subfolder
2. Import in host configuration

## Project Structure

```
MyNixOS/
├── flake.nix                    # Main configuration
├── hosts/                       # Host configurations
│   ├── laptop/default.nix
│   ├── desktop/default.nix
│   └── ...
├── features/                    # Reusable features
│   ├── applications/            # Apps by category
│   ├── development/             # Dev tools
│   ├── desktop-environments/    # Desktop UI
│   ├── hardware/                # Hardware features
│   └── system/                  # System features
├── modules/                     # Basic components
├── profiles/                    # Machine-specific
└── home/                        # User environments
```

## Commands

```bash
# Build configuration
nixos-rebuild switch --flake .#hostname

# Test configuration
nixos-rebuild build --flake .#hostname

# Rollback
nixos-rebuild switch --rollback

# Update flake
nix flake update

# Show available options
nixos-option services.nginx.enable
```

## Troubleshooting

- **Build fails**: Check syntax with `nix flake check`
- **Package not found**: Search with `nix search nixpkgs package-name`
- **Service won't start**: Check logs with `journalctl -u service-name`
- **Rollback**: Use `nixos-rebuild switch --rollback`

## Documentation

- **Complete Guide**: `docs/COMPLETE_GUIDE.md` - Comprehensive beginner's guide
- **Troubleshooting**: `docs/TROUBLESHOOTING.md` - Common issues and solutions
- **Advanced**: `docs/ADVANCED_CUSTOMIZATION.md` - Advanced topics

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
