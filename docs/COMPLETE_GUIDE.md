# MyNixOS: Complete Beginner's Guide

## Table of Contents
1. [What is This Project?](#what-is-this-project)
2. [Basic Computer Concepts](#basic-computer-concepts)
3. [What is NixOS?](#what-is-nixos)
4. [Project Structure Walkthrough](#project-structure-walkthrough)
5. [File-by-File Deep Dive](#file-by-file-deep-dive)
6. [How to Use This Project](#how-to-use-this-project)
7. [Customization Guide](#customization-guide)
8. [Troubleshooting](#troubleshooting)

---

## What is This Project?

This is a **NixOS configuration repository** - think of it as a recipe book for building a complete computer operating system. Just like a recipe tells you exactly what ingredients to use and how to combine them, this repository tells your computer exactly what software to install and how to configure it.

### Why This Exists
- **Consistency**: Every time you set up a computer, it will be identical
- **Reproducibility**: You can recreate your exact setup on any computer
- **Version Control**: Track changes to your system like code
- **Sharing**: Share your complete system setup with others

---

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

---

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

---

## Project Structure Walkthrough

Let's explore the project folder by folder:

```
MyNixOS/
├── flake.nix                    # Main recipe file
├── hosts/                       # Different computer types
├── features/                    # Reusable functionality
├── modules/                     # Basic system components
├── profiles/                    # Machine-specific settings
├── home/                        # User environments
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
- `user.nix` - User account management
- `vm.nix` - Virtual machine support
- `nginx.nix` - Web server
- `firewall-allowlist.nix` - Security rules

### profiles/ Folder
Contains machine-specific settings:
- `laptop.nix` - Laptop power management
- `desktop.nix` - Desktop optimizations
- `vm.nix` - Virtual machine optimizations

### home/ Folder
Contains user environment configurations:
- `casper/` - Personal settings for user "casper"

### docs/ Folder
Contains documentation files explaining how everything works.

---

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
      config = { allowUnfree = true; };
    };
```
**What this does**: Creates a package set for a specific system with unfree packages allowed (some software requires this).

```nix
    mkNixOSConfig = hostName: system: nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [ ./hosts/${hostName}/default.nix ];
    };
```
**What this does**: Helper function to create a NixOS configuration for a specific host.

```nix
    hostTree = {
      laptop = [ "personal" ];
      desktop = [ ];
      server = [ ];
      vm = [ "personal" ];
      wsl = [ ];
      cloud = [ ];
    };
```
**What this does**: Defines which hosts have personal variants (like `laptop@personal`).

```nix
    nixosConfigurations = {
      laptop = mkNixOSConfig "laptop" defaultSystem;
      desktop = mkNixOSConfig "desktop" defaultSystem;
      server = mkNixOSConfig "server" defaultSystem;
      vm = mkNixOSConfig "vm" defaultSystem;
      wsl = mkNixOSConfig "wsl" defaultSystem;
      cloud = mkNixOSConfig "cloud" defaultSystem;
      
      "laptop@personal" = mkNixOSConfig "laptop/personal" defaultSystem;
      "vm@personal" = mkNixOSConfig "vm/personal" defaultSystem;
    };
```
**What this does**: Creates all the system configurations. You can build any of these with commands like `nixos-rebuild switch --flake .#laptop`.

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
    ../modules/user.nix
  ];
}
```
**What this does**: Imports common features that all computers need:
- Locale settings (language, timezone)
- Networking (internet connection)
- User management

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

---

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

---

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

Edit `features/system/themes/themes.nix` to change:
- Color schemes
- Fonts
- Desktop themes
- Wallpapers

### Adding Background Images

1. Place images in `features/system/themes/backgrounds/`
2. Name them appropriately:
   - `default.jpg` - Desktop wallpaper
   - `sddm.jpg` - Login screen
3. The system will automatically use them

---

## Troubleshooting

### Common Errors

**Error: "file not found"**
- Check that the file path is correct
- Make sure the file exists

**Error: "attribute not found"**
- Check that the package name is correct
- Make sure the package is available in nixpkgs

**Error: "permission denied"**
- Run the command with `sudo` if needed
- Check file permissions

### Rolling Back Changes

To undo the last configuration:
```bash
nixos-rebuild switch --rollback
```

To see configuration history:
```bash
nix-env --list-generations --profile /nix/var/nix/profiles/system
```

### Getting Help

1. Check the NixOS manual: https://nixos.org/manual/nixos/
2. Search the NixOS wiki: https://nixos.wiki/
3. Ask on the NixOS forum: https://discourse.nixos.org/
4. Check package options: `nix search nixpkgs package-name`

### Debugging Configuration

To test a configuration without applying it:
```bash
nixos-rebuild build --flake .#laptop
```

To see what packages would be installed:
```bash
nixos-rebuild build --flake .#laptop --show-trace
```

---

## Conclusion

This project provides a complete, reproducible system configuration that can be easily customized and shared. By understanding the structure and following the patterns, you can create your own perfect computing environment.

Remember:
- Start small and build up
- Test changes before applying them
- Keep backups of working configurations
- Don't be afraid to experiment

Happy configuring!
