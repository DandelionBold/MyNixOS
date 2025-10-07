# Modules

System-wide building blocks and Home Manager modules for reusable functionality.

## Purpose
- Small, focused modules that export clear options
- Home Manager modules for user-specific configurations
- Sensible defaults (off unless safe to enable)
- Each module should evaluate standalone in a minimal host

## Current Modules

### System Modules
- `users-manager.nix` - Dynamic user creation from centralized usersList
- `home-manager-generator.nix` - Automatic Home Manager config generation
- `vm-manager.nix` - VM detection and shared optimizations
- `nginx.nix` - Web server configuration
- `firewall-allowlist.nix` - Security rules

### Home Manager Modules
- `theme.nix` - Per-user theming (GTK, icons, cursor themes)

## Usage

Modules are imported by features, which are then imported by hosts:

```
Hosts → Features → Modules
```

Example:
```nix
# In a feature
imports = [ ../modules/theme.nix ];
```
