# NixOS Configuration Hierarchy

## Overview

This document explains the clear hierarchy and organization of the MyNixOS configuration system. The architecture follows a three-tier structure: **Hosts** → **Features** → **Modules**.

## Architecture Principles

### 1. **Clear Separation of Concerns**
- **Hosts**: Complete system configurations for specific machine types
- **Features**: High-level functional capabilities and common base functionality
- **Modules**: Low-level individual system services and components

### 2. **Hierarchical Import Structure**
```
Hosts (Complete Systems)
├── Features (Functional Capabilities)
│   ├── Base Features (Common to All)
│   └── Specific Features (Context-Specific)
└── Modules (Individual Services)
```

## Directory Structure

```
MyNixOS/
├── hosts/                    # Complete system configurations
│   ├── laptop/
│   │   ├── default.nix       # Complete laptop system
│   │   └── personal/
│   │       ├── personal.nix  # Personal overrides
│   │       └── hardware-configuration.nix
│   ├── desktop/
│   │   └── default.nix       # Complete desktop system
│   ├── server/
│   │   └── default.nix       # Complete server system
│   ├── vm/
│   │   ├── default.nix       # Complete VM system
│   │   └── personal/
│   │       ├── personal.nix  # Personal overrides
│   │       └── hardware-configuration.nix
│   └── cloud/
│       └── default.nix       # Complete cloud system
├── features/                 # High-level functional capabilities
│   ├── base.nix             # Common base functionality (ALL hosts)
│   ├── workstation.nix      # Desktop environment (KDE Plasma)
│   ├── dev.nix              # Development environment
│   ├── server.nix           # Server functionality
│   ├── db.nix               # Database services
│   ├── gaming.nix           # Gaming tools
│   └── k3s.nix              # Kubernetes
├── modules/                  # Low-level individual services
│   ├── locale.nix           # Locale, timezone, keyboard
│   ├── networking.nix       # NetworkManager
│   ├── user.nix             # User management
│   ├── audio.nix            # PipeWire audio
│   ├── bluetooth.nix        # Bluetooth
│   ├── printing.nix         # CUPS printing
│   ├── fonts.nix            # Font configuration
│   ├── power.nix            # Power management
│   ├── hibernate.nix        # Hibernation support
│   ├── vm.nix               # VM virtualization
│   ├── databases.nix        # Database services
│   ├── nginx.nix            # Web server
│   ├── firewall-allowlist.nix # Firewall rules
│   └── filesystems-btrfs.nix # BTRFS filesystem
├── profiles/                 # Machine-type specific settings
│   ├── laptop.nix           # Laptop power management
│   ├── desktop.nix          # Desktop optimizations
│   └── vm.nix               # VM optimizations
└── home/                    # User environments (Home Manager)
    └── casper/
        └── default.nix      # User environment for casper
```

## Tier 1: Hosts (Complete Systems)

### Purpose
Complete system configurations for specific machine types. Each host represents a fully functional NixOS system.

### Characteristics
- **Complete**: Contains everything needed for a working system
- **Specific**: Tailored for a particular machine type
- **Imports**: Features + Modules + Profiles
- **Usage**: `nixos-rebuild switch --flake .#laptop`

### Examples
- `hosts/laptop/default.nix` - Complete laptop system
- `hosts/desktop/default.nix` - Complete desktop system
- `hosts/server/default.nix` - Complete server system

### Import Structure
```nix
# hosts/laptop/default.nix
{
  imports = [
    # Base features (common to all hosts)
    ../features/base.nix
    
    # Host-specific modules
    ../modules/bluetooth.nix
    ../modules/printing.nix
    ../modules/audio.nix
    
    # Host-specific features
    ../features/workstation.nix
    ../modules/hibernate.nix
    ../features/dev.nix
    ../modules/power.nix
    
    # Hardware configuration
    ./personal/hardware-configuration.nix
  ];
}
```

## Tier 2: Features (Functional Capabilities)

### Purpose
High-level functional capabilities that provide complete functionality for specific use cases.

### Characteristics
- **High-level**: Complete functional capabilities
- **Context-specific**: Designed for specific use cases
- **Reusable**: Can be used across multiple hosts
- **Bundled**: Contains multiple related configurations

### Base Features
- `features/base.nix` - Common functionality for ALL hosts
  - Locale, timezone, keyboard
  - Networking (NetworkManager)
  - User management

### Specific Features
- `features/workstation.nix` - Desktop environment (KDE Plasma)
- `features/dev.nix` - Development environment (Docker + Python)
- `features/server.nix` - Server functionality (SSH + nginx)
- `features/db.nix` - Database services
- `features/gaming.nix` - Gaming tools
- `features/k3s.nix` - Kubernetes

### Example
```nix
# features/dev.nix
{
  # Docker development environment
  virtualisation.docker.enable = true;
  
  # Python toolchain
  environment.systemPackages = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.setuptools
    python3Packages.wheel
  ];
}
```

## Tier 3: Modules (Individual Services)

### Purpose
Low-level individual system services and components with single responsibility.

### Characteristics
- **Low-level**: Individual system services
- **Single responsibility**: One module = one service
- **Highly reusable**: Can be used across any host
- **Minimal dependencies**: Self-contained

### Examples
- `modules/audio.nix` - PipeWire audio stack
- `modules/bluetooth.nix` - Bluetooth support
- `modules/printing.nix` - CUPS printing
- `modules/fonts.nix` - Font configuration
- `modules/power.nix` - Power management
- `modules/hibernate.nix` - Hibernation support

### Example
```nix
# modules/audio.nix
{
  # PipeWire + WirePlumber audio stack
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
```

## Import Hierarchy

### Host Import Pattern
```nix
# Every host follows this pattern:
{
  imports = [
    # 1. Base features (common to all)
    ../features/base.nix
    
    # 2. Host-specific modules (individual services)
    ../modules/bluetooth.nix
    ../modules/printing.nix
    ../modules/audio.nix
    
    # 3. Host-specific features (functional capabilities)
    ../features/workstation.nix
    ../features/dev.nix
    
    # 4. Hardware configuration
    ./personal/hardware-configuration.nix
  ];
}
```

### Feature Import Pattern
```nix
# Features can import modules when needed
{
  imports = [
    ../modules/fonts.nix
    ../modules/power.nix
  ];
  
  # Feature-specific configuration
  services.xserver.enable = true;
  # ... more configuration
}
```

## Usage Examples

### Building Configurations
```bash
# Base configurations (core functionality only)
nixos-rebuild switch --flake .#laptop
nixos-rebuild switch --flake .#desktop
nixos-rebuild switch --flake .#server

# Personal configurations (base + personal overrides)
nixos-rebuild switch --flake .#laptop@personal
nixos-rebuild switch --flake .#vm@personal
```

### Adding New Hosts
1. Create `hosts/{hostname}/default.nix`
2. Add to `hostTree` in `flake.nix`
3. Import `../features/base.nix` and host-specific features/modules

### Adding New Features
1. Create `features/{featurename}.nix`
2. Import in relevant hosts
3. Can import modules if needed

### Adding New Modules
1. Create `modules/{modulename}.nix`
2. Import in relevant hosts or features
3. Keep single responsibility principle

## Benefits

### 1. **Clear Hierarchy**
- Hosts → Features → Modules
- Easy to understand and navigate
- Clear separation of concerns

### 2. **Reusability**
- Features can be reused across hosts
- Modules can be reused across features and hosts
- Base features provide common functionality

### 3. **Maintainability**
- Single responsibility principle
- Easy to locate and modify specific functionality
- Clear import dependencies

### 4. **Scalability**
- Easy to add new hosts, features, or modules
- Hierarchical structure scales well
- Clear patterns for extension

## Naming Conventions

### Hosts
- **Type-based**: `laptop`, `desktop`, `server`, `vm`, `cloud`
- **Purpose**: Complete system configurations

### Features
- **Functional**: `workstation`, `dev`, `server`, `gaming`
- **Purpose**: Complete functional capabilities

### Modules
- **Service-based**: `audio`, `bluetooth`, `printing`, `fonts`
- **Purpose**: Individual system services

This hierarchy provides a clean, maintainable, and scalable foundation for managing complex NixOS configurations across multiple hosts and use cases.
