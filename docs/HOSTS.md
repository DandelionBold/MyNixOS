# Host Architecture Documentation

## Overview

This document describes the host architecture and configuration system for MyNixOS. The system uses a hierarchical approach with base configurations and personal variants.

## Architecture Principles

### 1. **Hierarchical Configuration System**
- **Base Configurations**: Core functionality for each host type
- **Personal Variants**: Base + personal customizations using `@personal` syntax
- **Dynamic Generation**: Configurations are generated dynamically based on file existence

### 2. **Modular Design**
- **Base Modules**: Common modules loaded by all hosts (`modules/base.nix`)
- **Host-Specific Modules**: Modules specific to certain host types
- **Roles**: Bundles of functionality for specific use cases
- **Profiles**: Machine-type specific configurations

## Host Structure

```
hosts/
├── laptop/
│   ├── default.nix              # Base laptop configuration
│   └── personal/
│       ├── personal.nix         # Personal laptop overrides
│       └── hardware-configuration.nix
├── desktop/
│   └── default.nix              # Base desktop configuration
├── server/
│   └── default.nix              # Base server configuration
├── vm/
│   ├── default.nix              # Base VM configuration
│   └── personal/
│       ├── personal.nix         # Personal VM overrides
│       └── hardware-configuration.nix
├── wsl/
│   └── default.nix              # Base WSL configuration
└── cloud/
    └── default.nix              # Base cloud configuration
```

## Configuration Types

### Base Configurations
- **Purpose**: Core functionality for each host type
- **Usage**: `nixos-rebuild switch --flake .#laptop`
- **Files**: `hosts/{hostname}/default.nix`

### Personal Configurations
- **Purpose**: Base configuration + personal customizations
- **Usage**: `nixos-rebuild switch --flake .#laptop@personal`
- **Files**: `hosts/{hostname}/personal/personal.nix`
- **Behavior**: Imports base config and adds overrides

## Module System

### Base Modules (`modules/base.nix`)
Common modules loaded by ALL hosts:
- `locale.nix` - Locale, timezone, keyboard settings
- `networking.nix` - NetworkManager configuration
- `user.nix` - Generic user management (configurable via `_module.args.user`)

### Host-Specific Modules
Each host type loads additional modules as needed:

#### Laptop
- `bluetooth.nix` - Bluetooth support
- `printing.nix` - CUPS printing
- `audio.nix` - PipeWire audio
- `laptop.nix` role - Power management, hibernate
- `dev.nix` role - Development tools

#### Desktop
- `bluetooth.nix` - Bluetooth support
- `printing.nix` - CUPS printing
- `audio.nix` - PipeWire audio
- `desktop.nix` role - KDE Plasma, fonts, power

#### Server
- `databases.nix` - MySQL, MSSQL, Redis
- `nginx.nix` - Web server
- `firewall-allowlist.nix` - Firewall rules
- `server.nix` role - Headless server defaults

#### VM
- `vm.nix` - Virtualization support (VirtualBox, VMware, QEMU, etc.)
- `vm.nix` profile - VM-optimized settings

#### Cloud
- `server.nix` role - Headless server defaults

## Dynamic Configuration Generation

### Host Tree Structure
```nix
hostTree = {
  laptop = [ "personal" ];    # laptop has "personal" variant
  desktop = [ ];              # desktop has no variants
  server = [ ];               # server has no variants
  vm = [ "personal" ];        # vm has "personal" variant
  wsl = [ ];                  # wsl has no variants
  cloud = [ ];                # cloud has no variants
};
```

### Generated Configurations
- **Base**: `laptop`, `desktop`, `server`, `vm`, `wsl`, `cloud`
- **Variants**: `laptop@personal`, `vm@personal` (only if files exist)

## User Management

### Configurable Users
- **Default User**: "casper" (configurable via `_module.args.user`)
- **User Module**: `modules/user.nix` creates `users.users.${userName}`
- **Personal Override**: Set `_module.args.user` in personal configs

### Example Personal Config
```nix
# hosts/laptop/personal/personal.nix
{
  # Import the base laptop configuration
  imports = [ ../default.nix ];
  
  # Personal overrides
  _module.args.user = "casper";
  
  # Add any personal laptop-specific customizations here
  # Example: services.nginx.enable = true;
}
```

## VM Virtualization

### Supported VM Types
- **VirtualBox**: `virtualisation.virtualbox.guest.enable = true`
- **VMware**: `virtualisation.vmware.guest.enable = true` + `open-vm-tools`
- **QEMU/KVM**: `virtualisation.qemu.guestAgent.enable = true` + `qemuGuest` service
- **Hyper-V**: `virtualisation.hypervGuest.enable = true`
- **Docker**: `virtualisation.docker.enable = true`

### VM Configuration
Set VM type in personal config:
```nix
# hosts/vm/personal/personal.nix
{
  _module.args.vmType = "virtualbox";  # or "vmware", "qemu", "hyperv", "docker"
}
```

## Usage Examples

### Building Configurations
```bash
# Base configurations
nixos-rebuild switch --flake .#laptop
nixos-rebuild switch --flake .#vm

# Personal configurations
nixos-rebuild switch --flake .#laptop@personal
nixos-rebuild switch --flake .#vm@personal
```

### Adding New Hosts
1. Create `hosts/{hostname}/default.nix`
2. Add to `hostTree` in `flake.nix`
3. Import `../modules/base.nix` and host-specific modules

### Adding New Variants
1. Create `hosts/{hostname}/{variant}/{variant}.nix`
2. Add variant to host's array in `hostTree`
3. Variant config should import base config

## Benefits

### 1. **DRY Principle**
- Common modules in `base.nix` - no repetition
- Host-specific modules only where needed

### 2. **Flexibility**
- Base configs for clean setups
- Personal configs for customizations
- Easy to add new hosts and variants

### 3. **Maintainability**
- Centralized common configuration
- Clear separation of concerns
- Dynamic generation based on file existence

### 4. **Scalability**
- Easy to add new host types
- Easy to add new variants
- Configurable user and VM types

## File Organization

### Key Files
- `flake.nix` - Dynamic configuration generation
- `modules/base.nix` - Common modules for all hosts
- `modules/user.nix` - Configurable user management
- `modules/vm.nix` - VM virtualization support
- `hosts/{hostname}/default.nix` - Base host configuration
- `hosts/{hostname}/personal/personal.nix` - Personal overrides

### Naming Conventions
- **Hosts**: Type-based names (`laptop`, `desktop`, `server`, `vm`, `wsl`, `cloud`)
- **Variants**: Descriptive names (`personal`, `work`, `gaming`)
- **Users**: Configurable via `_module.args.user`
- **VM Types**: Configurable via `_module.args.vmType`

This architecture provides a clean, maintainable, and scalable foundation for managing multiple NixOS hosts with both shared and personalized configurations.
