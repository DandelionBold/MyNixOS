# MyNixOS: Complete Documentation

## Table of Contents
1. [Quick Start Guide](#quick-start-guide)
2. [Complete Beginner's Guide](#complete-beginners-guide)
3. [Troubleshooting Guide](#troubleshooting-guide)
4. [Advanced Customization Guide](#advanced-customization-guide)

---

# Quick Start Guide

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
- **Databases**: MySQL, Redis
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
2. Add host-specific settings directly in the file
3. Add to `flake.nix` nixosConfigurations
4. Import desired features

### Creating New Feature
1. Create file in appropriate `features/` subfolder
2. Import in host configuration

## Project Structure

```
MyNixOS/
├── flake.nix                    # Main configuration (auto-discovers hosts)
├── nixos-settings/              # Centralized configuration
│   ├── usersList.nix           # All user definitions (system + Home Manager)
│   └── README.md               # User system documentation
├── hosts/                       # Host configurations (auto-discovered)
│   ├── laptop/
│   │   ├── default.nix         # Base laptop config
│   │   └── personal/
│   │       ├── personal.nix    # Personal variant
│   │       └── hardware-configuration.nix
│   ├── desktop/default.nix
│   ├── server/default.nix
│   ├── vm/default.nix
│   └── cloud/default.nix
├── features/                    # Reusable features
│   ├── base.nix                # Base features (ALL hosts import this)
│   ├── gaming.nix              # Gaming support
│   ├── applications/            # Apps by category
│   ├── development/             # Dev tools
│   ├── desktop-environments/    # Desktop UI
│   ├── hardware/                # Hardware features
│   └── system/                  # System features
└── modules/                     # Low-level system components
    ├── users-manager.nix       # Dynamic user creation
    ├── home-manager-generator.nix  # Automatic HM configs
    ├── vm-manager.nix
    ├── nginx.nix
    └── firewall-allowlist.nix
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

---

# Complete Beginner's Guide

## What is This Project?

This is a **NixOS configuration repository** - think of it as a recipe book for building a complete computer operating system. Just like a recipe tells you exactly what ingredients to use and how to combine them, this repository tells your computer exactly what software to install and how to configure it.

### Why This Exists
- **Consistency**: Every time you set up a computer, it will be identical
- **Reproducibility**: You can recreate your exact setup on any computer
- **Version Control**: Track changes to your system like code
- **Sharing**: Share your complete system setup with others

## Basic Computer Concepts

### Operating System (OS)
An operating system is the software that manages your computer's hardware and provides a platform for other programs to run. Examples include Windows, macOS, and Linux.

### Packages
Packages are software programs (like web browsers, text editors, games) that you can install on your computer.

### Configuration
Configuration is the process of setting up software to work the way you want it to. For example, changing your desktop wallpaper or setting up a web server.

### Files and Folders
- **Files**: Contain information (like documents, programs, settings)
- **Folders**: Contain files and other folders (like organizing documents in folders)

### Command Line
The command line is a text-based way to interact with your computer, where you type commands instead of clicking with a mouse.

## What is NixOS?

NixOS is a Linux operating system that is **declarative** and **reproducible**.

### Declarative
Instead of installing software one by one and configuring it manually, you write a configuration file that describes what you want your system to look like, and NixOS makes it happen.

### Reproducible
The same configuration file will always produce the same result, no matter when or where you run it.

### Flakes
Flakes are a way to organize NixOS configurations. Think of them as a recipe book with:
- **Ingredients** (inputs): What external resources you need
- **Instructions** (outputs): What your system should look like
- **Dependencies**: What other recipes you need

### Home Manager
Home Manager manages your personal user environment (your desktop, applications, settings) separately from the system configuration.

## Project Structure Walkthrough

Let's explore the project folder by folder:

```
MyNixOS/
├── flake.nix                    # Main recipe file
├── nixos-settings/              # Centralized configuration
│   ├── usersList.nix           # All user definitions
│   └── README.md               # User management documentation
├── hosts/                       # Different computer types
├── features/                    # Reusable functionality
├── modules/                     # Basic system components
└── docs/                        # Documentation
```

### Root Directory
The root directory is the main folder of the project. It contains the most important file: `flake.nix`.

### hosts/ Folder
Contains configurations for different types of computers:
- `laptop/` - Configuration for laptop computers
- `desktop/` - Configuration for desktop computers
- `server/` - Configuration for server computers
- `vm/` - Configuration for virtual machines
- `cloud/` - Configuration for cloud servers

Each host folder contains:
- `default.nix` - Main configuration for that computer type
- `personal/` - Personal customizations for specific users

### features/ Folder
Contains reusable functionality organized by category:
- `applications/` - Software applications
- `development/` - Development tools
- `desktop-environments/` - Desktop interfaces
- `hardware/` - Hardware-related features
- `system/` - System-level features

### modules/ Folder
Contains basic system components that are used by features:
- `users-manager.nix` - Dynamic user creation from usersList
- `home-manager-generator.nix` - Automatic Home Manager config generation
- `vm-manager.nix` - VM detection and shared optimizations
- `theme.nix` - Home Manager theme module (GTK, icons, cursor)
- `nginx.nix` - Web server
- `firewall-allowlist.nix` - Security rules

### nixos-settings/ Folder
**Centralized configuration management**:
- `usersList.nix` - Single source of truth for ALL users (system + Home Manager)
- `README.md` - Documentation for the centralized user system
- All user data in ONE place for consistency
- **Note**: Hosts are auto-discovered from the `hosts/` directory - no manual configuration needed!

### profiles/ Folder
~~Contains machine-specific settings~~ **REMOVED** - All profile settings have been moved directly into their corresponding host `default.nix` files for better organization and clarity.

### home/ Folder
~~Contains user environment configurations~~ **REMOVED** - User configurations are now centrally managed in `nixos-settings/usersList.nix` with automatic Home Manager generation.

### docs/ Folder
Contains documentation files explaining how everything works.

## File-by-File Deep Dive

### flake.nix - The Main Recipe

This is the most important file. Let's break it down:

```nix
{
  description = "MyNixOS: Professional, multi-host NixOS config with flakes + Home Manager (standalone)";
```
**What this does**: Gives the project a name and description.

```nix
  nixConfig = {
    substituters = [ "https://cache.nixos.org/" ];
    trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    experimental-features = [ "nix-command" "flakes" ];
  };
```
**What this does**: 
- `substituters`: Where to download pre-built packages (faster than building from source)
- `trusted-public-keys`: Security keys to verify packages are legitimate
- `experimental-features`: Enables new Nix features

```nix
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
```
**What this does**:
- `nixpkgs`: The main package collection (like an app store)
- `home-manager`: Tool for managing user environments
- `follows`: Ensures both use the same nixpkgs version

```nix
  outputs = inputs: let
    inherit (inputs) nixpkgs home-manager;
    
    systems = [ "x86_64-linux" "aarch64-linux" ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
    defaultSystem = "x86_64-linux";
```
**What this does**:
- `outputs`: Defines what this flake produces
- `systems`: Supported computer architectures (Intel/AMD and ARM)
- `forAllSystems`: Helper to create configurations for all systems
- `defaultSystem`: Default architecture (Intel/AMD)

```nix
    forSystem = system: import nixpkgs {
      inherit system;
      # Unfree is no longer set globally. It is aggregated via
      # modules/unfree-packages.nix from feature modules using
      # `my.allowedUnfreePackages`.
      config = {};
    };
```
**What this does**: Creates a package set for a specific system. Unfree packages are no longer enabled globally; instead, feature modules add the specific package names to `my.allowedUnfreePackages`, which is aggregated by `modules/unfree-packages.nix`.

```nix
    mkNixOSConfig = configName: system:
      let
        # Parse configName to extract host and optional variant
        parts = nixpkgs.lib.splitString "@" configName;
        hostName = builtins.head parts;
        hasVariant = builtins.length parts > 1;
        variantName = if hasVariant then builtins.elemAt parts 1 else null;
        
        # Generate path based on whether variant exists
        configPath = if hasVariant
          then ./hosts/${hostName}/${variantName}/${variantName}.nix
          else ./hosts/${hostName}/default.nix;
      in
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ configPath ];
      };
```
**What this does**: 
- Smart helper function that parses host names with optional variants
- `"laptop"` → loads `hosts/laptop/default.nix`
- `"laptop@personal"` → loads `hosts/laptop/personal/personal.nix`
- Works with ANY variant name automatically!

```nix
    nixosConfigurations = 
      let
        # Automatically scan hosts/ directory
        hostDirs = builtins.attrNames (builtins.readDir ./hosts);
        
        # Create base configs for each host
        baseConfigs = ... # laptop, desktop, vm, etc.
        
        # Automatically discover variants
        variantConfigs = ... # laptop@personal, vm@personal, etc.
      in
      baseConfigs // variantConfigs;
```
**What this does**: 
- **Automatically discovers** all hosts by scanning `hosts/` directory
- No manual configuration needed!
- Just create `hosts/my-host/default.nix` and it appears as `#my-host`
- Create `hosts/my-host/work/work.nix` and it appears as `#my-host@work`
- Build with commands like: `nixos-rebuild switch --flake .#laptop`

### hosts/laptop/default.nix - Laptop Configuration

```nix
{ config, pkgs, lib, ... }:
```
**What this does**: Defines the function parameters:
- `config`: Current system configuration
- `pkgs`: Available packages
- `lib`: Utility functions

```nix
{
  imports = [
    ../features/base.nix
    # ... more imports
  ];
```
**What this does**: Imports other configuration files. This is like including other recipes in your main recipe.

```nix
  networking.hostName = "laptop";
  networking.firewall.enable = false;
}
```
**What this does**: Sets the computer's name to "laptop" and disables the firewall.

### features/base.nix - Base System Features

```nix
{
  imports = [
    ./system/locale.nix
    ./system/networking.nix
    ../modules/users-manager.nix
  ];
}
```
**What this does**: Imports common features that ALL computers need:
- Locale settings (language, timezone, keyboard)
- Networking (NetworkManager for internet connection)
- Dynamic user management (creates users based on `system.selectedUsers`)

### features/system/locale.nix - Language and Region Settings

```nix
{
  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "ar_EG.UTF-8/UTF-8" ];
  services.xserver.xkb = {
    layout = "us,ara";
    variant = "";
    options = "grp:alt_shift_toggle";
  };
}
```
**What this does**:
- Sets timezone to Cairo, Egypt
- Sets default language to English
- Supports both English and Arabic
- Sets keyboard layout to US and Arabic, with Alt+Shift to switch

### features/applications/browsers.nix - Web Browser

```nix
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
  };
}
```
**What this does**: Installs and enables Firefox web browser.

### features/development/dev.nix - Development Environment

```nix
{
  imports = [
    ./containers.nix
    ./programming-languages.nix
    ./databases.nix
    ./ides.nix
    ./version-control.nix
  ];
}
```
**What this does**: Imports all development-related features:
- Docker containers
- Programming languages (Python, etc.)
- Databases (MySQL, Redis, etc.)
- Code editors (VSCode)
- Version control (Git)

## How to Use This Project

### Prerequisites
1. A computer running NixOS
2. Basic command line knowledge
3. This repository cloned to your computer

### Building a Configuration

To build a laptop configuration:
```bash
nixos-rebuild switch --flake .#laptop
```

To build a desktop configuration:
```bash
nixos-rebuild switch --flake .#desktop
```

To build a personal laptop configuration:
```bash
nixos-rebuild switch --flake .#laptop@personal
```

### What Happens When You Build
1. NixOS reads your configuration
2. Downloads all required packages
3. Configures all services
4. Applies the configuration to your system
5. Reboots if necessary

### Adding New Packages

To add a new package, edit the relevant feature file:

```nix
environment.systemPackages = with pkgs; [
  existing-package
  new-package  # Add this line
];
```

### Adding New Services

To add a new service, edit the relevant feature file:

```nix
services.new-service = {
  enable = true;
  # configuration options
};
```

## Customization Guide

### Creating a New Host

1. Create a new folder in `hosts/`:
   ```bash
   mkdir hosts/my-computer
   ```

2. Create `hosts/my-computer/default.nix`:
   ```nix
   { config, pkgs, lib, ... }:
   
   {
     imports = [
       ../features/base.nix
       # Add other features you want
     ];
   
     networking.hostName = "my-computer";
     
     # Add host-specific settings here
     # (previously in profiles/)
   }
   ```

3. Add to `flake.nix`:
   ```nix
   nixosConfigurations = {
     # ... existing configurations
     "my-computer" = mkNixOSConfig "my-computer" defaultSystem;
   };
   ```

### Creating a New Feature

1. Create a new file in the appropriate `features/` subfolder:
   ```bash
   touch features/applications/my-app.nix
   ```

2. Add the feature configuration:
   ```nix
   { config, lib, pkgs, ... }:
   
   {
     environment.systemPackages = with pkgs; [
       my-application
     ];
   }
   ```

3. Import it in your host configuration:
   ```nix
   imports = [
     ../features/applications/my-app.nix
   ];
   ```

### Modifying Themes

**Theming is now handled per-user via Home Manager:**

Edit `nixos-settings/usersList.nix` to configure themes for each user:

```nix
theme = {
  enable       = true;
  gtkThemeName = "adw-gtk3-dark";
  iconName     = "Papirus-Dark";
  cursorName   = "Bibata-Modern-Ice";
  cursorSize   = 24;
};
```

Each user can have their own theme preferences (dark/light, different themes, etc.).

### Adding Background Images

1. Place images in user's home directory or use system-wide wallpapers
2. Configure via desktop environment settings:
   - `default.jpg` - Desktop wallpaper
   - `sddm.jpg` - Login screen
3. The system will automatically use them

---

## Unfree Packages Policy (VS Code, Brave, Google Chrome)

Some software (like VS Code, Brave, and Google Chrome) is distributed under an unfree license. Instead of enabling unfree packages globally, this project uses a safe, modular approach:

- A tiny aggregator module at `modules/unfree-packages.nix` sets `nixpkgs.config.allowUnfreePredicate` based on an accumulated list called `my.allowedUnfreePackages`.
- Any feature can append the packages it needs to that list. Lists are merged automatically by NixOS options.
- This keeps the policy explicit, discoverable, and easy to turn off.

### Where it’s configured

- Aggregator: `modules/unfree-packages.nix`
- Imported by: `features/base.nix` (so it applies to all hosts)
- Feature declarations:
  - `features/development/ides.nix` (VS Code)
  - `features/applications/browsers.nix` (Brave, Google Chrome)

### How features request unfree packages

Example: VS Code in `features/development/ides.nix`

```nix
{ config, lib, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
  };

  # Tell the aggregator which unfree package names to allow
  my.allowedUnfreePackages = [ "vscode" "vscode-with-extensions" ];
}
```

Example: Browsers in `features/applications/browsers.nix`

```nix
{ config, lib, pkgs, ... }:
{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    brave
    google-chrome
    chromium
  ];

  # Allow unfree for exactly what we use
  my.allowedUnfreePackages = [ "brave" "google-chrome" ];
}
```

### How to disable unfree globally (temporary or per host)

- Temporary, one-off build (shell only):
  ```bash
  export NIXPKGS_ALLOW_UNFREE=1
  nixos-rebuild build --flake .#laptop --impure
  ```
  This is mainly for emergency builds; we prefer the declarative approach above.

- Per host, hard-disable unfree (overrides aggregator):
  ```nix
  # hosts/my-host/default.nix
  nixpkgs.config.allowUnfreePredicate = pkg: false;  # Disallow all unfree here
  ```

### Troubleshooting: “unfree license” error

If you see an error like:

```
error: Package <name> has an unfree license, refusing to evaluate.
```

Do one of the following:

1) Preferred: Add the package name to `my.allowedUnfreePackages` in the relevant feature and rebuild.
2) Temporary: Use the environment variable method above for a single build.

This keeps unfree usage explicit and tightly scoped.


# Troubleshooting Guide

## Build Errors

### "file not found" Error
**Problem**: Configuration file cannot be found.

**Solution**:
1. Check the file path is correct
2. Ensure the file exists
3. Verify the file is in the right location

**Example**:
```bash
# Wrong
imports = [ ../features/nonexistent.nix ];

# Correct
imports = [ ../features/applications/browsers.nix ];
```

### "attribute not found" Error
**Problem**: Package or service name doesn't exist.

**Solution**:
1. Check the package name is correct
2. Search for the correct name: `nix search nixpkgs package-name`
3. Check if the package is available in your nixpkgs version

**Example**:
```bash
# Search for a package
nix search nixpkgs firefox

# Check if package exists
nix-env -qaP | grep firefox
```

### "permission denied" Error
**Problem**: Insufficient permissions to modify system.

**Solution**:
1. Run with sudo if needed
2. Check file permissions
3. Ensure you're in the right directory

**Example**:
```bash
# Run with sudo
sudo nixos-rebuild switch --flake .#laptop

# Check permissions
ls -la hosts/laptop/default.nix
```

### "flake not found" Error
**Problem**: Flake configuration cannot be found.

**Solution**:
1. Ensure you're in the project directory
2. Check that `flake.nix` exists
3. Verify the flake is properly formatted

**Example**:
```bash
# Check current directory
pwd

# List files
ls -la

# Check flake syntax
nix flake check
```

## Configuration Issues

### Service Won't Start
**Problem**: A service fails to start after configuration.

**Solution**:
1. Check service logs: `journalctl -u service-name`
2. Verify service configuration
3. Check dependencies are installed

**Example**:
```bash
# Check service status
systemctl status nginx

# View logs
journalctl -u nginx -f

# Restart service
sudo systemctl restart nginx
```

### Package Not Installed
**Problem**: Package is not available after configuration.

**Solution**:
1. Check if package is in the correct feature file
2. Verify the feature is imported
3. Rebuild the configuration

**Example**:
```bash
# Check if package is installed
which firefox

# Rebuild configuration
nixos-rebuild switch --flake .#laptop

# Check package in store
nix-store --query --references /run/current-system
```

### Theme Not Applied
**Problem**: Desktop theme doesn't change.

**Solution**:
1. Check if desktop environment is enabled
2. Verify theme files are imported
3. Restart desktop environment

**Example**:
```bash
# Check KDE is enabled
systemctl status sddm

# Restart desktop
sudo systemctl restart display-manager
```

## System Issues

### Boot Problems
**Problem**: System won't boot after configuration.

**Solution**:
1. Boot from previous generation
2. Check configuration syntax
3. Use emergency mode

**Example**:
```bash
# Boot from previous generation
nixos-rebuild switch --rollback

# Emergency mode
# Add "single" to kernel parameters in GRUB
```

### Network Issues
**Problem**: Network connection not working.

**Solution**:
1. Check NetworkManager status
2. Verify network configuration
3. Check hardware drivers

**Example**:
```bash
# Check NetworkManager
systemctl status NetworkManager

# Restart network
sudo systemctl restart NetworkManager

# Check network interfaces
ip addr show
```

### Audio Issues
**Problem**: Audio not working.

**Solution**:
1. Check PipeWire status
2. Verify audio configuration
3. Check hardware support

**Example**:
```bash
# Check PipeWire
systemctl --user status pipewire

# Restart audio
systemctl --user restart pipewire

# Check audio devices
pactl list short sinks
```

## Performance Issues

### Slow Boot
**Problem**: System takes too long to boot.

**Solution**:
1. Check for failed services
2. Optimize configuration
3. Use systemd-analyze

**Example**:
```bash
# Analyze boot time
systemd-analyze

# Check for slow services
systemd-analyze blame

# Check failed services
systemctl --failed
```

### High Memory Usage
**Problem**: System uses too much memory.

**Solution**:
1. Check running processes
2. Optimize services
3. Check for memory leaks

**Example**:
```bash
# Check memory usage
free -h

# Check top processes
top -o %MEM

# Check systemd services
systemctl list-units --state=running
```

## Development Issues

### Docker Not Working
**Problem**: Docker containers won't start.

**Solution**:
1. Check Docker service status
2. Verify user permissions
3. Check Docker configuration

**Example**:
```bash
# Check Docker status
systemctl status docker

# Add user to docker group
sudo usermod -aG docker $USER

# Restart Docker
sudo systemctl restart docker
```

### Git Not Working
**Problem**: Git commands fail.

**Solution**:
1. Check Git is installed
2. Verify configuration
3. Check permissions

**Example**:
```bash
# Check Git version
git --version

# Configure Git
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## Recovery Procedures

### Rollback to Previous Configuration
```bash
# List available generations
nix-env --list-generations --profile /nix/var/nix/profiles/system

# Rollback to previous
nixos-rebuild switch --rollback

# Rollback to specific generation
nixos-rebuild switch --rollback 3
```

### Reset to Default Configuration
```bash
# Switch to default NixOS configuration
nixos-rebuild switch --flake nixpkgs#nixos

# Or use a minimal configuration
nixos-rebuild switch --flake nixpkgs#nixos --option system-profiles minimal
```

### Emergency Mode
1. Boot from GRUB menu
2. Select "NixOS - all configurations"
3. Choose previous working generation
4. Boot and fix configuration

## Getting Help

### Check Logs
```bash
# System logs
journalctl -f

# Service logs
journalctl -u service-name -f

# Boot logs
journalctl -b

# Kernel logs
dmesg
```

### Debug Configuration
```bash
# Test configuration without applying
nixos-rebuild build --flake .#laptop

# Show configuration trace
nixos-rebuild build --flake .#laptop --show-trace

# Check flake
nix flake check
```

### Online Resources
- [NixOS Manual](https://nixos.org/manual/nixos/)
- [NixOS Wiki](https://nixos.wiki/)
- [NixOS Discourse](https://discourse.nixos.org/)
- [NixOS Reddit](https://www.reddit.com/r/NixOS/)

### Community Support
- Ask on NixOS Discourse
- Join NixOS IRC channel
- Check GitHub issues
- Search existing solutions

## Prevention

### Best Practices
1. **Test configurations** before applying
2. **Keep backups** of working configurations
3. **Use version control** for all changes
4. **Document changes** you make
5. **Start small** and build up

### Regular Maintenance
```bash
# Update system
nixos-rebuild switch --upgrade

# Clean old generations
nix-collect-garbage -d

# Update flake inputs
nix flake update
```

### Backup Strategy
1. Keep configuration in Git
2. Backup important data
3. Document custom changes
4. Test restore procedures

Remember: When in doubt, rollback to a working configuration and debug from there!

---

# Advanced Customization Guide

For users who want to go beyond basic configuration.

## Custom Themes

### Creating Custom User Themes

Themes are now configured per-user in `nixos-settings/usersList.nix`:

```nix
# In usersList.nix
theme = {
  enable = true;
  gtkThemeName = "Custom-Theme";
  gtkThemePackage = pkgs.my-custom-theme;
  iconName = "Custom-Icons";
  iconPackage = pkgs.my-icon-theme;
  cursorName = "Custom-Cursor";
  cursorPackage = pkgs.my-cursor-theme;
  cursorSize = 32;
};
```

### Custom Wallpapers

1. Place wallpapers in `/usr/share/backgrounds/` or user's home directory
2. Configure via desktop environment settings:

{
  environment.etc = {
    "backgrounds" = {
      source = ./backgrounds;
      target = "backgrounds";
    };
  };

  # Custom wallpaper rotation
  services.desktopManager.plasma6 = lib.mkIf config.services.desktopManager.plasma6.enable {
    enable = true;
    wallpaper = "/etc/backgrounds/rotating-wallpaper.jpg";
  };
}
```

### Custom Fonts

Add custom fonts to `themes.nix`:

```nix
fonts = {
  packages = with pkgs; [
    # Custom fonts
    (pkgs.callPackage ./custom-fonts.nix { })
    # System fonts
    noto-fonts
    fira-code
  ];
  fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Custom Serif" "Noto Serif" ];
      sansSerif = [ "Custom Sans" "Noto Sans" ];
      monospace = [ "Custom Mono" "Fira Code" ];
    };
  };
};
```

## Hardware Configuration

### GPU Configuration

#### NVIDIA
```nix
# features/hardware/nvidia.nix
{ config, lib, pkgs, ... }:

{
  # Enable NVIDIA drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false; # Use proprietary drivers
  };

  # Enable CUDA if needed
  hardware.nvidia.cuda.enable = true;
}
```

#### AMD
```nix
# features/hardware/amd.nix
{ config, lib, pkgs, ... }:

{
  # Enable AMD drivers
  services.xserver.videoDrivers = [ "amdgpu" ];
  
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
```

### Audio Configuration

```nix
# features/hardware/audio-advanced.nix
{ config, lib, pkgs, ... }:

{
  # Advanced PipeWire configuration
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
    
    # Custom configuration
    config.pipewire = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 32;
      };
    };
  };

  # JACK configuration
  services.jack = {
    jackd.enable = true;
    jackd.extraOptions = [ "-R" "-P75" ];
  };
}
```

### Storage Configuration

```nix
# features/system/storage.nix
{ config, lib, pkgs, ... }:

{
  # BTRFS with advanced features
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/your-uuid";
    fsType = "btrfs";
    options = [ "subvol=root" "compress=zstd" "noatime" ];
  };

  # Snapper for snapshots
  services.snapper = {
    enable = true;
    configs = {
      root = {
        subvolume = "/";
        fstype = "btrfs";
        extraConfig = ''
          ALLOW_USERS="casper"
          TIMELINE_CREATE=yes
          TIMELINE_CLEANUP=yes
        '';
      };
    };
  };
}
```

## User Management

### Multiple Users

Create user-specific configurations:

```nix
# features/system/users.nix
{ config, lib, pkgs, ... }:

{
  users.users = {
    casper = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "docker" ];
      shell = pkgs.bashInteractive;
    };
    
    alice = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      shell = pkgs.zsh;
    };
  };
}
```

### User-Specific Home Manager

```nix
# home/alice/default.nix
{ config, pkgs, ... }:

{
  home.username = "alice";
  home.homeDirectory = "/home/alice";
  
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
    };
  };
}
```

## Secrets Management

### Using sops-nix

1. Install sops-nix:
```nix
# features/system/secrets.nix
{ config, lib, pkgs, ... }:

{
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/var/lib/sops-nix/key.txt";
    secrets = {
      "db_password" = {};
      "api_key" = {};
    };
  };
}
```

2. Create secrets file:
```yaml
# secrets.yaml
db_password: ENC[AES256_GCM,data:...]
api_key: ENC[AES256_GCM,data:...]
```

### Using agenix

1. Generate age key:
```bash
nix run nixpkgs#agenix -- -i
```

2. Create secrets:
```nix
# features/system/secrets.nix
{ config, lib, pkgs, ... }:

{
  age.secrets = {
    "db_password" = {
      file = ./secrets/db_password.age;
      owner = "casper";
      group = "casper";
    };
  };
}
```

## Development Environments

### Language-Specific Environments

#### Python Development
```nix
# features/development/python.nix
{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.virtualenv
    python3Packages.poetry
    python3Packages.pytest
    python3Packages.black
    python3Packages.flake8
  ];

  # Python environment
  programs.python3 = {
    enable = true;
    package = pkgs.python3;
  };
}
```

#### Node.js Development
```nix
# features/development/nodejs.nix
{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodejs
    nodePackages.npm
    nodePackages.yarn
    nodePackages.pnpm
    nodePackages.typescript
    nodePackages.eslint
  ];
}
```

#### Rust Development
```nix
# features/development/rust.nix
{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rustc
    cargo
    rust-analyzer
    rustfmt
    clippy
  ];
}
```

### Docker Development

```nix
# features/development/docker-advanced.nix
{ config, lib, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
    daemon.settings = {
      data-root = "/var/lib/docker";
      log-driver = "json-file";
      log-opts = {
        max-size = "10m";
        max-file = "3";
      };
    };
  };

  # Docker Compose
  environment.systemPackages = with pkgs; [
    docker-compose
    docker-buildx
  ];
}
```

## Performance Tuning

### Kernel Optimization

```nix
# features/system/kernel.nix
{ config, lib, pkgs, ... }:

{
  boot.kernelParams = [
    "quiet"
    "splash"
    "mitigations=off"
    "preempt=full"
  ];

  boot.kernel.sysctl = {
    "kernel.sched_rt_runtime_us" = "-1";
    "kernel.sched_rt_period_us" = "1000000";
  };
}
```

### Memory Management

```nix
# features/system/memory.nix
{ config, lib, pkgs, ... }:

{
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_ratio" = 15;
    "vm.dirty_background_ratio" = 5;
  };
}
```

### CPU Optimization

```nix
# features/system/cpu.nix
{ config, lib, pkgs, ... }:

{
  powerManagement.cpuFreqGovernor = "performance";
  
  boot.kernel.sysctl = {
    "kernel.sched_migration_cost_ns" = "5000000";
    "kernel.sched_rt_runtime_us" = "-1";
  };
}
```

## Security Hardening

### Firewall Configuration

```nix
# features/system/firewall.nix
{ config, lib, pkgs, ... }:

{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 ];
    allowedUDPPorts = [ 53 67 68 ];
    extraCommands = ''
      iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -m recent --set
      iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -m recent --update --seconds 60 --hitcount 4 -j DROP
    '';
  };
}
```

### SSH Hardening

```nix
# features/system/ssh.nix
{ config, lib, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      PubkeyAuthentication = true;
      MaxAuthTries = 3;
      ClientAliveInterval = 300;
      ClientAliveCountMax = 2;
    };
  };
}
```

### AppArmor

```nix
# features/system/apparmor.nix
{ config, lib, pkgs, ... }:

{
  security.apparmor = {
    enable = true;
    enableKernelModules = true;
  };
}
```

## Custom Packages

### Building Custom Packages

```nix
# features/packages/custom-package.nix
{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (pkgs.callPackage ./custom-package.nix { })
  ];
}
```

### Package Overrides

```nix
# features/packages/overrides.nix
{ config, lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      custom-package = super.callPackage ./custom-package.nix { };
    })
  ];
}
```

## Overlays and Overrides

### Adding Overlays

```nix
# flake.nix
inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  nur.url = "github:nix-community/NUR";
};

outputs = inputs: let
  pkgs = import inputs.nixpkgs {
    overlays = [
      inputs.nur.overlay
    ];
  };
in {
  # ... rest of configuration
};
```

### Package Overrides

```nix
# features/packages/overrides.nix
{ config, lib, pkgs, ... }:

{
  nixpkgs.config = {
    packageOverrides = pkgs: {
      custom-package = pkgs.callPackage ./custom-package.nix { };
    };
  };
}
```

## Module Development

### Creating Custom Modules

```nix
# features/custom/my-module.nix
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.my-service;
in
{
  options.services.my-service = {
    enable = mkEnableOption "My custom service";
    port = mkOption {
      type = types.int;
      default = 8080;
      description = "Port to listen on";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.my-service = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.my-package}/bin/my-service --port ${toString cfg.port}";
        Restart = "always";
      };
    };
  };
}
```

### Module Options

```nix
# features/custom/options.nix
{ config, lib, pkgs, ... }:

with lib;

{
  options.my-config = {
    enable = mkEnableOption "My configuration";
    value = mkOption {
      type = types.str;
      default = "default";
      description = "Configuration value";
    };
  };
}
```

## Best Practices

### Configuration Organization
1. **Keep related configurations together**
2. **Use descriptive names**
3. **Document complex configurations**
4. **Test changes incrementally**

### Performance
1. **Use lazy evaluation**
2. **Avoid unnecessary rebuilds**
3. **Optimize imports**
4. **Use appropriate data types**

### Security
1. **Principle of least privilege**
2. **Regular updates**
3. **Secure defaults**
4. **Audit configurations**

### Maintenance
1. **Version control everything**
2. **Regular backups**
3. **Document changes**
4. **Test rollbacks**

This guide provides the foundation for advanced customization while maintaining the clean, organized structure of the MyNixOS project.

---

## Conclusion

This project provides a complete, reproducible system configuration that can be easily customized and shared. By understanding the structure and following the patterns, you can create your own perfect computing environment.

Remember:
- Start small and build up
- Test changes before applying them
- Keep backups of working configurations
- Don't be afraid to experiment

Happy configuring!
