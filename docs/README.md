# MyNixOS: Complete Documentation (Beginner Friendly)

## Table of Contents
1. [Quick Start Guide](#quick-start-guide)
2. [Complete Beginner's Guide](#complete-beginners-guide)
3. [Troubleshooting Guide](#troubleshooting-guide)
4. [Advanced Customization Guide](#advanced-customization-guide)

---

# Quick Start Guide (Simple Path)

Follow this exactly. You can copy commands line-by-line.

## Prerequisites (what you need)
- A NixOS system installed (even minimal install is OK)
- Internet connection
- We will install Git as a first step

## Setup (step by step)

1. **Clone the repository:**
   ```bash
   git clone https://github.com/DandelionBold/MyNixOS.git
   cd MyNixOS
   ```

2. **See available configurations:**
   ```bash
   nix flake show
   ```
   Look for names like `laptop`, `desktop`, `vm`, or `laptop@personal`.

3. **Build a configuration:**
   ```bash
   # For laptop
   nixos-rebuild switch --flake .#laptop
   
   # For desktop
   nixos-rebuild switch --flake .#desktop
   
   # For personal laptop
   nixos-rebuild switch --flake .#laptop@personal
   ```

## Available Configurations (what these names mean)

| Configuration | Description |
|---------------|-------------|
| `laptop` | Base laptop configuration |
| `laptop@personal` | Laptop with personal customizations |
| `desktop` | Base desktop configuration |
| `server` | Server configuration |
| `vm` | Virtual machine configuration |
| `cloud` | Cloud server configuration |

## Key Features (what you get)

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

## Customization (change things safely)

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

### Creating a New Host (from zero)
1) Make a folder for your host:
```bash
mkdir -p hosts/my-host
```
2) Create the main file:
```bash
nano hosts/my-host/default.nix
```
3) Paste this template and edit the name:
```nix
{ config, pkgs, lib, ... }:
{
  imports = [
    ../features/base.nix
    ../features/desktop-environments/kde-plasma.nix
    ../features/applications/browsers.nix
  ];

  networking.hostName = "my-host";
  system.stateVersion = "25.05";

  # Choose the users for this machine
  system.selectedUsers = [ "casper" ];
}
```
4) Generate hardware config for THIS machine:
```bash
sudo nixos-generate-config --show-hardware-config > hosts/my-host/personal/hardware-configuration.nix
```
5) Build it:
```bash
sudo nixos-rebuild switch --flake .#my-host
```

### Creating a New Feature (your own app list)
1) Create a file:
```bash
nano features/applications/my-apps.nix
```
2) Paste this:
```nix
{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    curl
    htop
  ];
}
```
3) Import it in your host:
```nix
imports = [ ../features/applications/my-apps.nix ];
```

## Project Structure (map of the repo)

```
MyNixOS/
├── flake.nix                       # Main configuration (auto-discovers hosts)
├── nixos-settings/                 # Centralized configuration
│   ├── usersList.nix              # All user definitions (system + Home Manager)
│   └── README.md                  # User system documentation
├── hosts/                          # Host configurations (auto-discovered)
│   ├── laptop/
│   │   ├── default.nix            # Base laptop config
│   │   └── personal/
│   │       ├── personal.nix       # Personal variant
│   │       └── hardware-configuration.nix
│   ├── desktop/default.nix
│   ├── server/default.nix
│   ├── vm/default.nix
│   └── cloud/default.nix
├── features/                       # Reusable features
│   ├── base.nix                   # Base features (ALL hosts import this)
│   ├── gaming.nix                 # Gaming support
│   ├── applications/               # Apps by category (browsers, editors, etc.)
│   ├── development/                # Dev tools (ides, containers, languages)
│   ├── desktop-environments/       # Desktop UI (KDE Plasma 6)
│   ├── hardware/                   # Hardware features (audio, printing, ...)
│   └── system/                     # System features
│       ├── boot-loader.nix        # GRUB and boot behavior
│       ├── home-manager.nix       # Enable HM at system level
│       ├── locale.nix             # Timezone, locale, keyboard
│       ├── networking.nix         # NetworkManager
│       ├── filesystems-btrfs.nix  # Example storage config
│       ├── hibernate.nix          # Suspend/hibernate support
│       └── power.nix              # Power management defaults
│       └── secrets.nix            # Simple file-based secrets (demo)
└── modules/                        # Low-level system components
    ├── users-manager.nix          # Dynamic user creation (from usersList)
    ├── home-manager-generator.nix # Automatic HM configs from usersList
    ├── vm-manager.nix             # VM detection & guest tools
    ├── theme.nix                  # Per-user theme module (HM)
    ├── wallpaper.nix              # Per-user wallpaper (local or URL, KDE)
    ├── unfree-packages.nix        # Aggregate unfree allow-list
    ├── nginx.nix                  # Web server
    └── firewall-allowlist.nix     # Example firewall rules
```

## Commands (copy/paste)

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
- `unfree-packages.nix` - Aggregates per-feature unfree allow-list
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

### flake.nix — The main entry point

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

### features/system/home-manager.nix — Enable Home Manager system-wide

Turns on Home Manager integration for all hosts via the feature chain.

```nix
{ config, lib, pkgs, inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
}
```

### features/system/boot-loader.nix — Boot loader settings (GRUB)

Central place for GRUB and boot parameters.

```nix
{ config, lib, pkgs, ... }:
{
  boot.loader.grub = {
    enable = true;
    useOSProber = true;
    device = "/dev/sda"; # adjust per host
  };
}
```

### features/system/locale.nix — Language and region settings

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

### features/applications/browsers.nix — Browsers (Firefox, Brave, Chrome)

```nix
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
  };
}
```
**What this does**: Installs and enables Firefox web browser.

### features/development/dev.nix — Development environment aggregator

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

## How to Use This Project (current flow)

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

3. No change to `flake.nix` is needed — hosts are auto‑discovered from the `hosts/` folder.

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
# nixos-settings/usersList.nix (inside hm = { ... }; for a user)
theme = {
  enable       = true;                # Turn theme control ON for this user

  gtkThemeName = "adw-gtk3-dark";    # Window/button style (dark vs light). See "Modifying Themes" above
  # gtkThemePackage can be added if you install a different GTK theme package
  # gtkThemePackage = pkgs.adw-gtk3;

  iconName     = "Papirus-Dark";     # Icons style (files, folders, toolbar icons)
  # iconPackage = pkgs.papirus-icon-theme; # Optional: ensures the icon pack is installed

  cursorName   = "Bibata-Modern-Ice"; # Pointer theme (shape/color)
  # cursorPackage = pkgs.bibata-cursor-theme; # Optional: ensures cursor pack is installed

  cursorSize   = 24;                  # Pointer size (raise/lower if too small/large)
};
```

Each user can have their own theme preferences (dark/light, different themes, etc.).

#### What do these theme fields mean?

- `gtkThemeName`: How windows, buttons and menus look in most apps. Examples: `adw-gtk3-dark` (dark), `adw-gtk3` (light). This changes colors, shapes, and spacing.
- `iconName`: The style of icons for folders, files and toolbar buttons. Examples: `Papirus-Dark`, `Papirus`. This changes the icon artwork only, not window colors.
- `cursorName`: The mouse pointer theme (shape/color). Examples: `Bibata-Modern-Ice` (light cursor), `Bibata-Modern-Classic` (darker).
- `cursorSize`: Size of the mouse pointer in pixels. If the cursor feels too small/large, raise or lower this number.

These values are purely visual. They don’t change functionality — only appearance.

#### How do I find valid theme names?

1) Use the names we ship by default (already valid):
   - GTK: `adw-gtk3`, `adw-gtk3-dark`
   - Icons: `Papirus`, `Papirus-Dark`
   - Cursor: `Bibata-Modern-Ice`, `Bibata-Modern-Classic`

2) Search available themes in nixpkgs:
```bash
nix search nixpkgs adw-gtk3
nix search nixpkgs papirus-icon-theme
nix search nixpkgs bibata
```
Open the package page (e.g., on search.nixos.org) and look for the theme names it provides. Usually the `name` you set in Home Manager matches the visible theme name inside apps (e.g., `Papirus-Dark`).

3) Install extra themes if desired by adding them to user packages:
```nix
hm = {
  packages = with pkgs; [
    adw-gtk3            # GTK theme package
    papirus-icon-theme  # Icon theme package
    bibata-cursor-theme # Cursor theme package
  ];
};
```
Then set the names in `theme = { ... }` to match the installed theme’s display names.

#### Dark vs Light

- Dark: `adw-gtk3-dark` + `Papirus-Dark` + a light cursor like `Bibata-Modern-Ice`.
- Light: `adw-gtk3` + `Papirus` + a darker cursor like `Bibata-Modern-Classic`.

You can mix and match — for example dark GTK with light icons if you prefer.

#### Where is this applied?

- GTK apps (Firefox, Files, etc.) read from the Home Manager config and apply the theme on login.
- KDE apps may use their own theme controls, but icon/cursor themes still apply system‑wide.
- Environment variables are also set for consistency: `GTK_THEME`, `XCURSOR_THEME`, `XCURSOR_SIZE`.

#### Troubleshooting

- Theme doesn’t change after rebuild: log out and log back in (or reboot). Some apps cache theme settings.
- Cursor changes only in some apps: set `cursorSize` and ensure `bibata-cursor-theme` is installed; then log out/in.
- Icons look mixed: ensure only one icon theme is selected; remove extra icon packs from `packages` and rebuild.

### Adding Background Images

There are two ways: local files or an online image.

1) Local files (simple):
   - Put your desktop wallpaper at: `$HOME/Pictures/default.jpg`
   - Put your login-screen image at: `/etc/sddm/backgrounds/sddm.jpg`
   - KDE desktop (what this means): Open “System Settings → Appearance → Wallpapers”, click “Add Image…”, select your `default.jpg`, click “Apply”. That’s it.
   - SDDM login screen (what this code does): The snippet below tells NixOS to copy your image into `/etc/sddm/backgrounds/sddm.jpg` and make SDDM use it every boot. Paste this in a host file like `hosts/vm/personal/personal.nix`.
     ```nix
     # Example: set SDDM background system-wide
     services.displayManager.sddm = {
       enable = true;
       settings.Theme = {
         Background = "/etc/sddm/backgrounds/sddm.jpg";
       };
     };
     # This line copies your repo file into /etc at build time
     # Create an assets folder in the repo and point to your image there
     environment.etc."sddm/backgrounds/sddm.jpg".source = ./assets/wallpapers/sddm.jpg;
     ```

2) Online image (automatic): use `modules/wallpaper.nix` as shown below.

#### Use an online image as wallpaper (optional)

We provide a tiny module `modules/wallpaper.nix` that can fetch a remote image during the build and apply it for KDE Plasma users.

1) Add the module to your user via Home Manager (in `nixos-settings/usersList.nix`):
```nix
hm = {
  extraModules = [ ../modules/theme.nix ../modules/wallpaper.nix ];
  wallpaper = {
    enable = true;
    source = "url";  # or "local"
    url = "https://example.com/wallpaper.jpg";  # direct link to a jpg/png
    # sha256 = "sha256-...";  # optional: add for fully reproducible builds
  };
};
```
2) Rebuild system and re-login. The image is stored as `$HOME/.local/share/wallpaper.jpg` and applied at login.

Notes:
- About `sha256` (plain explanation): Nix requires a checksum to make sure the downloaded image never changes silently. The very first time, you can leave it out (or set to `null`). Nix will stop and show you the correct value to use. Copy the shown `sha256-…` into `wallpaper.sha256` and rebuild.
- Get the hash yourself (alternative):
  ```bash
  nix store prefetch-file https://example.com/wallpaper.jpg
  # Copy the SRI value that looks like: sha256-xxxxxxxx...
  ```
- For a local file instead: set `source = "local"; localPath = "/path/to/image.jpg";`.

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


## Zero → Working Install (From a fresh NixOS)

Follow these steps on a brand‑new NixOS install.

1) Enable flakes and install git temporarily
```bash
sudo nano /etc/nixos/configuration.nix
```
Add (before the final `}`):
```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
environment.systemPackages = with pkgs; [ git ];
```
Apply:
```bash
sudo nixos-rebuild switch
```

2) Get this repo
```bash
cd ~
git clone https://github.com/DandelionBold/MyNixOS.git
cd MyNixOS
```

3) Choose a host to build (see what exists)
```bash
nix flake show
```
Typical options: `laptop`, `desktop`, `vm`, `laptop@personal`.

4) Generate hardware config for YOUR machine/variant
```bash
# example for vm personal
sudo mkdir -p hosts/vm/personal
sudo nixos-generate-config --show-hardware-config > hosts/vm/personal/hardware-configuration.nix
```

5) Pick which users to create on this host
```bash
nano hosts/vm/personal/personal.nix
```
Find or add:
```nix
system.selectedUsers = [ "casper" ];
```

6) Build and apply
```bash
sudo nixos-rebuild switch --flake .#vm@personal
```

7) Optional: Apply Home Manager for your user
```bash
home-manager switch --flake .#casper
```

Done. You now have a working system driven by this repository.


## User Management Deep Dive (One place for all users)

All users live in `nixos-settings/usersList.nix`. Each user has two parts:
- System account (shell, groups, home)
- Home Manager settings (shell aliases, git, theme, etc.)

Example skeleton you can copy:
```nix
users = {
  myuser = {
    # System user
    username = "myuser";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.bashInteractive;
    homeDirectory = "/home/myuser";

    # Home Manager settings
    hm = {
      bash.enable = true;
      git = {
        enable = true;
        userName = "My Name";
        userEmail = "me@example.com";
      };
      theme.enable = true;  # see next section
    };
  };
};
```

Select users per host with:
```nix
system.selectedUsers = [ "myuser" ];
```
This creates only the users you list for that machine.


## Home Manager & Themes (Per‑user)

Themes are configured per user through a small module already included for you.

1) Make sure Home Manager is active (it is via `features/system/home-manager.nix`).
2) For a user in `usersList.nix`, set (with comments). See “Modifying Themes” above for what each field means and example names:
```nix
hm = {
  extraModules = [ ../modules/theme.nix ];
  theme = {
    enable       = true;                # Turn theme control ON for this user

    gtkThemeName = "adw-gtk3-dark";    # Window/button style (dark vs light)
    # gtkThemePackage = pkgs.adw-gtk3;  # Optional: install a different GTK theme

    iconName     = "Papirus-Dark";     # Icons style (files, folders, toolbar icons)
    # iconPackage = pkgs.papirus-icon-theme; # Optional: install the icon pack

    cursorName   = "Bibata-Modern-Ice"; # Pointer theme (shape/color)
    # cursorPackage = pkgs.bibata-cursor-theme; # Optional: install the cursor pack

    cursorSize   = 24;                  # Pointer size in pixels
  };
};
```
3) Apply Home Manager for that user:
```bash
home-manager switch --flake .#myuser
```

### Plasma wallpaper rotation (KDE slideshow)

Goal: cycle through a folder of images on a schedule.

- Easiest way (recommended):
  1) Open KDE “System Settings → Appearance → Wallpapers”.
  2) Select “Slideshow”.
  3) Click “Add Folder…”, choose your images folder, and set the interval.

- Make wallpapers available system‑wide (optional):
  Provide a read‑only folder for everyone, then point the slideshow to it in the GUI.
  ```nix
  { config, lib, pkgs, ... }:
  {
    # Put your images under ./assets/wallpapers in the repo
    environment.etc."backgrounds/wallpapers".source = ./assets/wallpapers;
    # You will pick /etc/backgrounds/wallpapers in the KDE Slideshow dialog
  }
  ```

Notes:
- The per‑user wallpaper module sets a single image; slideshow is best configured from the KDE dialog.
- If images don’t refresh immediately, log out/in or toggle the wallpaper engine once.

### modules/wallpaper.nix — Per-user wallpaper (KDE Plasma)

Lets a user set their wallpaper from a local path or a URL, applied automatically at login.

```nix
hm = {
  extraModules = [ ../modules/wallpaper.nix ];
  wallpaper = {
    enable = true;
    source = "local"; # or "url"
    localPath = "/etc/backgrounds/default.jpg";
    # url = "https://..."; sha256 = null;  # when using a remote image
  };
};
```


## Desktop Environment (KDE Plasma 6)

KDE Plasma 6 is provided as a feature. Include it in your host:
```nix
imports = [
  ../features/desktop-environments/kde-plasma.nix
];
```
Build and switch as usual.

## Common Tasks (Cheat‑Sheet)

These are the tasks you’ll do most often.

### Generate hardware config (per machine)
```bash
sudo nixos-generate-config --show-hardware-config > hosts/<host>/<variant>/hardware-configuration.nix
```

### Pick users for a host
```nix
# hosts/<host>/default.nix (or variant)
system.selectedUsers = [ "casper" "koko" ];
```

### Enable a feature
```nix
imports = [
  ../features/applications/browsers.nix
  ../features/development/dev.nix
];
```

### Add a system package
```nix
environment.systemPackages = with pkgs; [
  curl
  wget
];
```

### Build and apply
```bash
sudo nixos-rebuild switch --flake .#<host>
```

### Build a variant
```bash
sudo nixos-rebuild switch --flake .#<host>@<variant>
```

### Home Manager for a user
```bash
home-manager switch --flake .#<username>
```

---

# Advanced Customization Guide (Short)

For users who want to go beyond basics. See example feature files under `features/` and reuse the patterns.

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

### Custom Fonts

Add custom fonts (example):

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

### Simple example (this repo)

For demos and tests, we provide a tiny feature `features/system/secrets.nix` that copies example files from `secrets/` into predictable locations.

Enable it on a host:
```nix
{ config, pkgs, lib, ... }:
{
  imports = [ ../features/system/secrets.nix ];

  secrets.enable = true;
  secrets.files = {
    db_password.source = ../../secrets/db_password.example; # -> /run/secrets/db_password
    api_key.source     = ../../secrets/api_key.example;     # -> /run/secrets/api_key
  };
}
```

You can add more entries (e.g., `smtp_password`, `jwt_secret`) pointing to separate files under `secrets/`.

Production tip: Replace these with a real secret manager (sops-nix or agenix) later.

### Using sops‑nix (production)

1) Generate or place an Age key, and create an encrypted `secrets.yaml`.
2) Reference them in a feature; sops‑nix will decrypt at activation.

```nix
{
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/var/lib/sops-nix/key.txt";
    secrets = {
      db_password = {};  # becomes /run/secrets/db_password
      api_key     = {};  # becomes /run/secrets/api_key
    };
  };
}
```

### Using agenix (production)

Encrypt individual files and map them to paths:

```nix
{
  age.secrets = {
    db_password = { file = ./secrets/db_password.age; owner = "casper"; group = "casper"; };
    api_key     = { file = ./secrets/api_key.age;     owner = "casper"; group = "casper"; };
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
