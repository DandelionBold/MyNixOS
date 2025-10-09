# MyNixOS

> **Professional, Multi-Host NixOS Configuration with Flakes & Home Manager**

A modern, declarative, and reproducible NixOS configuration system designed for flexibility, scalability, and ease of use. Manage multiple machines (laptops, desktops, servers, VMs, cloud instances) from a single, well-organized repository.

---

## 📑 Table of Contents

- [Features](#-features)
- [Quick Start](#-quick-start)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [First Build](#first-build)
- [Project Structure](#-project-structure)
- [Usage](#-usage)
  - [Building Configurations](#building-configurations)
  - [Managing Users](#managing-users)
  - [Adding Packages](#adding-packages)
- [Customization](#-customization)
  - [Creating New Hosts](#creating-new-hosts)
  - [Adding Features](#adding-features)
  - [Adding Users](#adding-users)
- [Documentation](#-documentation)
- [Architecture](#-architecture)
- [Contributing](#-contributing)
- [License](#-license)

---

## ✨ Features

### 🎯 Core Capabilities
- **Multi-Host Support**: Manage laptops, desktops, servers, VMs, and cloud instances from one repo
- **Automatic Discovery**: Hosts are auto-discovered - just create a folder and it's available
- **Variant System**: Create host variants (e.g., `laptop@personal`, `laptop@work`) with zero configuration
- **Centralized User Management**: Define all users once in `nixos-settings/usersList.nix`
- **Dynamic Configuration**: No manual lists - everything is discovered automatically

### 🖥️ Desktop Environment
- **KDE Plasma 6** with Wayland support
- **SDDM** display manager
- **Dark/Light** theme variants
- **Custom wallpapers** (internet or local)
- **Complete font stack** (Fira Code, Noto fonts)

### 📦 Applications
- **Browsers**: Firefox (default), Brave, Google Chrome
- **Terminals**: Alacritty, Kitty, GNOME Terminal, Konsole
- **File Managers**: Dolphin, Thunar, Ranger, Nautilus
- **Text Editors**: Vim, Emacs, Neovim, Kate, Gedit
- **Media Tools**: VLC, GIMP, Krita, Audacity, FFmpeg
- **Office Suite**: LibreOffice, OnlyOffice, Calibre
- **System Tools**: btop, htop, neofetch, wireshark, and more

### 💻 Development
- **Languages**: Python (extensible to others)
- **Containers**: Docker, Kubernetes (k3s)
- **Databases**: MySQL, Redis
- **IDEs**: VSCode
- **Version Control**: Git, GitHub CLI

### 🔧 System Features
- **Audio**: PipeWire with WirePlumber
- **Bluetooth**: Full support
- **Printing**: CUPS + SANE scanning
- **Power Management**: Laptop optimizations
- **Hibernation**: Suspend-to-disk support
- **Networking**: NetworkManager
- **Firewall**: Configurable per-host rules

---

## 🚀 Quick Start

### Prerequisites

- **NixOS** installed on your system (minimal installation is fine)
- Basic understanding of Nix and flakes (this guide will walk you through)

### Step 1: Enable Flakes (Required First!)

Before you can use this configuration, you need to enable flakes in NixOS.

1. **Open the configuration file with nano (text editor):**
   ```bash
   sudo nano /etc/nixos/configuration.nix
   ```

2. **Find the line that looks like `}` at the end of the file.** Scroll down using arrow keys until you see it.

3. **Add the flakes line BEFORE the final `}`:**
   ```nix
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
   ```

4. **Add git to existing systemPackages** (if you see `environment.systemPackages` already exists):
   - Find the line that looks like `environment.systemPackages = with pkgs; [ ... ];`
   - Add `git` to the list inside the brackets: `environment.systemPackages = with pkgs; [ ... git ];`
   
   **If you DON'T see `environment.systemPackages` anywhere, add this line:**
   ```nix
   environment.systemPackages = with pkgs; [ git ];
   ```
   
   **Example of what it should look like:**
   ```nix
   { config, pkgs, ... }:
   {
     # ... other configurations ...
     
     nix.settings.experimental-features = [ "nix-command" "flakes" ];
     environment.systemPackages = with pkgs; [ git ];  # Add this if not present
     # OR add 'git' to existing systemPackages list
   }
   ```

5. **Save and exit nano:**
   - Press `Ctrl + O` (WriteOut) to save
   - Press `Enter` to confirm the filename
   - Press `Ctrl + X` to exit

6. **Enable Faster Downloads (Optional but Recommended)**

   This configuration includes **optimized binary caches** for much faster package downloads. When you use this flake, it automatically configures:

   - **`cache.nixos.org`** - Official NixOS binary cache
   - **`hydra.nixos.org`** - Full nixpkgs ecosystem cache

   **What this means for you:**
   - ✅ **10x faster builds** - Downloads pre-built packages instead of compiling from source
   - ✅ **Lower bandwidth usage** - Only downloads what you don't have
   - ✅ **Automatic verification** - Cryptographically signed packages ensure security
   - ✅ **Zero configuration** - Works automatically when you use this flake

   **How to manually add these to your `/etc/nixos/configuration.nix`:**
   ```nix
   nix.settings = {
     experimental-features = [ "nix-command" "flakes" ];
     # Prefer well-known binary caches for faster builds
     substituters = [
       "https://cache.nixos.org/"
       "https://hydra.nixos.org"
     ];
     trusted-public-keys = [
       "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
       "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
     ];
   };
   ```

   **No additional setup needed!** These optimizations are built into the flake configuration and activate automatically when you build your system.

7. **Apply the change to your system:**
   ```bash
   sudo nixos-rebuild switch
   ```
   
   **Important:** Wait for this to complete successfully before proceeding. This enables flakes and installs git.

### Step 2: Clone This Repository (Beginner path)

> **Important:** With flakes, your configuration does NOT need to be in `/etc/nixos/`. You can keep it anywhere (like your home directory) and point to it with the `--flake` flag. This guide uses `~/MyNixOS`.

1. **Choose where to put the configuration** (recommendation: your home directory):
   ```bash
   cd ~
   ```

2. **Clone the repository (note the exact capitalization):**
   ```bash
   git clone https://github.com/DandelionBold/MyNixOS.git
   ```
   
   This creates a folder called `MyNixOS` in your current directory (e.g., `/home/yourusername/MyNixOS`).

3. **Enter the directory:**
   ```bash
   cd MyNixOS
   ```

**Optional: Link to `/etc/nixos/` (if you want to use `nixos-rebuild` without `--flake` flag)**

If you prefer to have your configuration in the traditional location:

```bash
sudo rm -rf /etc/nixos
sudo ln -s ~/MyNixOS /etc/nixos
```

Then you can use `sudo nixos-rebuild switch` instead of `sudo nixos-rebuild switch --flake .#laptop`.

### Step 3: Customize for Your System

1. **See what configurations are available:**
   ```bash
   nix flake show
   ```
   
   You'll see options like `laptop`, `laptop@personal`, `desktop`, `server`, `vm`, etc.

2. **Edit the user list** (if you want to add yourself):
   ```bash
   nano nixos-settings/usersList.nix
   ```
   
   Follow the pattern you see there. Press `Ctrl + X` to exit after making changes.

3. **Generate hardware configuration** (IMPORTANT - do this first!):
   ```bash
   # For laptop
   sudo nixos-generate-config --show-hardware-config > hosts/laptop/personal/hardware-configuration.nix
   
   # For desktop
   sudo nixos-generate-config --show-hardware-config > hosts/desktop/personal/hardware-configuration.nix
   
   # For VM
   sudo nixos-generate-config --show-hardware-config > hosts/vm/personal/hardware-configuration.nix
   ```
   
   **This is crucial!** Each person's hardware is different, so you MUST generate your own hardware configuration.

4. **Choose which host configuration to use.** For example, if you have a laptop:
   ```bash
   nano hosts/laptop/default.nix
   ```
   
   Change the line `system.selectedUsers = [ "casper" ];` to use your username.

5. **Set your timezone and locale:**
   ```bash
   nano features/system/locale.nix
   ```
   
   Edit the timezone and keyboard layout as needed.

### Step 5: Build and Apply

1. **Test the build first** (doesn't make any changes yet):
   ```bash
   nixos-rebuild build --flake .#laptop
   ```
   
   > **Note:** If you see prompts asking about configuration settings, here's what each one does:
   > 
   > **1. Experimental Features:**
   > - `do you want to allow configuration setting 'experimental-features'...` → Type `y` and press Enter
   > - **What it does:** Enables flakes (modern Nix configuration system) and nix-command (unified CLI)
   > - **Why needed:** Required to use this flake-based configuration
   > 
   > **2. Trust Experimental Features:**
   > - `do you want to permanently mark this value as trusted...` → Type `y` and press Enter
   > - **What it does:** Saves the experimental features setting permanently
   > - **Why needed:** Prevents this prompt from appearing again in future builds
   > 
   > **3. Binary Cache (Substituters):**
   > - `do you want to allow configuration setting 'substituters'...` → Type `y` and press Enter
   > - **What it does:** Enables downloading pre-built packages instead of compiling from source
   > - **Why needed:** Makes builds 10x faster by using cached binaries
   > 
   > **4. Trust Binary Cache:**
   > - `do you want to permanently mark this value as trusted...` → Type `y` and press Enter
   > - **What it does:** Saves the binary cache setting permanently
   > - **Why needed:** Prevents this prompt from appearing again in future builds
   > 
   > **5. Trusted Public Keys:**
   > - `do you want to allow configuration setting 'trusted-public-keys'...` → Type `y` and press Enter
   > - **What it does:** Trusts the cryptographic key used to verify binary cache packages
   > - **Why needed:** Ensures downloaded packages are authentic and haven't been tampered with
   > 
   > **6. Trust Public Keys Permanently:**
   > - `do you want to permanently mark this value as trusted...` → Type `y` and press Enter
   > - **What it does:** Saves the trusted public keys setting permanently
   > - **Why needed:** Prevents this prompt from appearing again in future builds
   > 
   > All prompts are normal on first use and make your NixOS experience much better!
   
   Replace `laptop` with your chosen configuration (`desktop`, `server`, `vm`, etc.)
   
   If you see errors, fix them before proceeding.

2. **Apply the configuration to your system:**
   ```bash
   sudo nixos-rebuild switch --flake .#laptop
   ```
   
   This will:
   - Install all packages
   - Configure your system
   - Create users
   - Set up desktop environment (if applicable)
   
   **This may take 10-30 minutes on first run!**

3. **Reboot your system** (recommended after first build):
   ```bash
   sudo reboot
   ```

### Step 6: Home Manager (Optional - User Environment)

Home Manager manages user-specific configurations (like dotfiles, shell aliases).

1. **After logging in, activate Home Manager for your user:**
   ```bash
   home-manager switch --flake ~/MyNixOS#yourusername
   ```
   
   Replace `yourusername` with your actual username (e.g., `casper`).

### Making Future Changes

Whenever you want to update your configuration:

1. **Edit the files** in `~/MyNixOS/` using nano or your preferred editor
2. **Rebuild and apply:**
   ```bash
   cd ~/MyNixOS
   sudo nixos-rebuild switch --flake .#laptop
   ```
3. **For Home Manager updates:**
   ```bash
   home-manager switch --flake ~/MyNixOS#yourusername
   ```

**Available Hosts:**
- `laptop` - Laptop configuration with power management
- `laptop@personal` - Personal laptop variant
- `desktop` - Desktop configuration
- `server` - Headless server
- `vm` - Virtual machine
- `vm@personal` - Personal VM variant
- `cloud` - Cloud instance

---

## 📁 Project Structure

```
MyNixOS/
├── flake.nix                      # Main flake configuration (auto-discovers hosts)
├── flake.lock                     # Lock file for reproducible builds
├── LICENSE                        # MIT License
├── README.md                      # This file
├── ROADMAP.md                     # Project roadmap and milestones
│
├── nixos-settings/                # Centralized configuration management
│   ├── usersList.nix             # Single source of truth for ALL users
│   └── README.md                 # User system documentation
│
├── hosts/                         # Host configurations (auto-discovered!)
│   ├── laptop/
│   │   ├── default.nix           # Base laptop configuration
│   │   └── personal/
│   │       ├── personal.nix      # Personal variant
│   │       └── hardware-configuration.nix
│   ├── desktop/default.nix
│   ├── server/default.nix
│   ├── vm/default.nix
│   └── cloud/default.nix
│
├── features/                      # Reusable feature modules
│   ├── base.nix                  # Base features (ALL hosts import this)
│   ├── gaming.nix                # Gaming support (Steam, Proton)
│   ├── applications/              # Application configurations
│   │   ├── browsers.nix
│   │   ├── terminals.nix
│   │   ├── file-managers.nix
│   │   ├── gui-text-editors.nix
│   │   ├── cli-text-editors.nix
│   │   ├── screenshot-tools.nix
│   │   ├── media-tools.nix
│   │   ├── office-suite.nix
│   │   ├── system-tools.nix
│   │   └── other-applications.nix
│   ├── desktop-environments/      # Desktop environment configs
│   │   ├── desktop-environment.nix
│   │   └── kde-plasma.nix
│   ├── development/               # Development tools
│   │   ├── dev.nix
│   │   ├── containers.nix        # Docker, k3s
│   │   ├── databases.nix         # MySQL, Redis
│   │   ├── programming-languages.nix
│   │   ├── ides.nix              # VSCode, etc.
│   │   └── version-control.nix   # Git
│   ├── hardware/                  # Hardware-related features
│   │   ├── audio.nix             # PipeWire
│   │   ├── bluetooth.nix
│   │   └── printing.nix          # CUPS + SANE
│   └── system/                    # System-level features
│       ├── boot-loader.nix       # GRUB and boot behavior
│       ├── home-manager.nix      # Enable HM at system level
│       ├── locale.nix            # Timezone, language, keyboard
│       ├── networking.nix        # NetworkManager
│       ├── filesystems-btrfs.nix # Example storage config
│       ├── hibernate.nix         # Suspend/hibernate support
│       ├── power.nix             # Power management defaults
│       └── secrets.nix           # Simple file-based secrets (demo)
│
├── modules/                       # Low-level system modules
│   ├── users-manager.nix         # Dynamic user creation
│   ├── home-manager-generator.nix # Automatic HM config generation
│   ├── vm-manager.nix            # VM detection and shared optimizations
│   ├── theme.nix                 # Per-user theme module (HM)
│   ├── unfree-packages.nix       # Aggregate unfree allow-list
│   ├── nginx.nix                 # Web server
│   └── firewall-allowlist.nix    # Firewall rules
│
├── docs/                          # Documentation
│   └── README.md                 # Complete beginner's guide
│
├── overlays/                      # Nixpkgs overlays (placeholder)
│   └── README.md
│
└── secrets/                       # Secrets management (placeholder)
    └── README.md
```

---

## 💻 Usage

### Building Configurations

#### Build and Apply System Configuration

```bash
# Test build without applying (safe)
nixos-rebuild build --flake .#laptop

# Apply configuration (requires sudo)
sudo nixos-rebuild switch --flake .#laptop

# Build with variant
sudo nixos-rebuild switch --flake .#laptop@personal

# Update flake inputs and rebuild
nix flake update
sudo nixos-rebuild switch --flake .#laptop
```

#### Build Home Manager Configuration

```bash
# Apply Home Manager for a user
home-manager switch --flake .#casper

# Build without applying
home-manager build --flake .#casper
```

### Common Commands

```bash
# Show all available configurations
nix flake show

# Check flake for errors
nix flake check

# Update specific input
nix flake lock --update-input nixpkgs

# List system generations
nix-env --list-generations --profile /nix/var/nix/profiles/system

# Rollback to previous generation
sudo nixos-rebuild switch --rollback

# Garbage collection (free space)
sudo nix-collect-garbage -d

# Optimize nix store
sudo nix-store --optimise
```

### Managing Users

#### Select Users for a Host

```nix
# hosts/laptop/default.nix
{
  system.selectedUsers = [ "casper" "alice" ];
}
```

#### Define New User

```nix
# nixos-settings/usersList.nix
rec {
  username = "alice";
  isNormalUser = true;
  extraGroups = [ "wheel" "networkmanager" ];
  shell = pkgs.bashInteractive;
  homeDirectory = "/home/${username}";
  
  # Home Manager config
  bash = { ... };
  git = { ... };
}
```

### Adding Packages

#### System-Wide Packages

```nix
# features/applications/other-applications.nix
environment.systemPackages = with pkgs; [
  my-new-package
];
```

#### User-Specific Packages (Home Manager)

```nix
# nixos-settings/usersList.nix (in user definition)
bash = {
  packages = with pkgs; [ my-user-package ];
};
```

---

## 🎨 Customization

### Creating New Hosts

#### 1. Create Host Directory and Configuration

```bash
# Create new host folder
mkdir -p hosts/workstation

# Create configuration file
touch hosts/workstation/default.nix
```

#### 2. Configure the Host

```nix
# hosts/workstation/default.nix
{ config, pkgs, lib, ... }:

{
  imports = [
    ../features/base.nix
    ../features/desktop-environments/kde-plasma.nix
    ../features/applications/browsers.nix
    # Add more features as needed
  ];

  networking.hostName = "workstation";
  networking.firewall.enable = false;
  
  # NixOS state version
  system.stateVersion = "25.05";
  
  # Select users for this host
  system.selectedUsers = [ "casper" ];
}
```

#### 3. Build It

```bash
# No need to modify flake.nix - auto-discovered!
sudo nixos-rebuild switch --flake .#workstation
```

### Creating Host Variants

#### 1. Create Variant Directory

```bash
# Create variant folder
mkdir -p hosts/laptop/work
```

#### 2. Create Variant Configuration

```nix
# hosts/laptop/work/work.nix
{ config, pkgs, lib, ... }:

{
  # Import base laptop configuration
  imports = [ ../default.nix ];
  
  # Override or add work-specific settings
  services.nginx.enable = true;
  
  # Different users for work laptop
  system.selectedUsers = [ "alice" ];
}
```

#### 3. Build It

```bash
# Auto-discovered! No flake.nix changes needed
sudo nixos-rebuild switch --flake .#laptop@work
```

### Adding Features

#### 1. Create Feature File

```bash
# Create in appropriate category
touch features/applications/my-app.nix
```

#### 2. Configure the Feature

```nix
# features/applications/my-app.nix
{ config, lib, pkgs, ... }:

{
  # Install packages
  environment.systemPackages = with pkgs; [
    my-application
  ];
  
  # Configure the application (if needed)
  programs.my-application = {
    enable = true;
    # settings...
  };
}
```

#### 3. Import in Host

```nix
# hosts/laptop/default.nix
{
  imports = [
    ../features/applications/my-app.nix  # Add this line
  ];
}
```

### Adding Users

#### 1. Edit Users List

```nix
# nixos-settings/usersList.nix
   {
     users = {
       # ... existing users
       
       # Add new user
       bob = {
         # === NixOS System User Configuration ===
         username = "bob";
         isNormalUser = true;
         description = "Bob - Developer";
         extraGroups = [ "wheel" "networkmanager" "docker" ];
         shell = pkgs.bashInteractive;
         homeDirectory = "/home/bob";
         
         # === Home Manager Configuration ===
         hm = {
           bash = {
             enable = true;
             shellAliases = {
               ll = "ls -la";
               gs = "git status";
             };
           };
           
           git = {
             enable = true;
             userName = "Bob";
             userEmail = "bob@example.com";
           };
           
           theme = {
             enable = true;
             gtkThemeName = "adw-gtk3";
             iconName = "Papirus";
           };
         };
       };
     };
   }
```

#### 2. Select User in Host

```nix
# hosts/desktop/default.nix
{
  system.selectedUsers = [ "casper" "bob" ];  # Add bob
}
```

#### 3. Build

```bash
# Build system (creates user)
sudo nixos-rebuild switch --flake .#desktop

# Build Home Manager for bob
home-manager switch --flake .#bob
```

### Secrets (optional)

For demos/tests you can keep secrets in separate files under `secrets/` and let a simple feature copy them into `/run/secrets/*`.

```nix
# hosts/<host>/default.nix (or variant)
{
  imports = [
    ../features/system/secrets.nix
  ];

  secrets.enable = true;
  secrets.files = {
    db_password.source = ../../secrets/db_password.example; # -> /run/secrets/db_password
    api_key.source     = ../../secrets/api_key.example;     # -> /run/secrets/api_key
  };
}
```

When you move to production, replace this with `sops-nix` or `agenix` (see docs/README.md for examples).

---

## 🏗️ Architecture

### System Overview

```mermaid
graph TB
    A[flake.nix] --> B[Auto-Discovery]
    B --> C[Scan hosts/ directory]
    B --> D[Import nixos-settings/]
    
    C --> E[Generate nixosConfigurations]
    D --> F[Generate homeConfigurations]
    
    E --> G[laptop]
    E --> H[laptop&#64;personal]
    E --> I[desktop]
    E --> J[server]
    
    F --> K[casper]
    F --> L[koko]
    
    style A fill:#5277c3,color:#000
    style B fill:#7ebae4,color:#000
    style E fill:#a3be8c,color:#000
    style F fill:#ebcb8b,color:#000
```

### Configuration Flow

```mermaid
flowchart LR
    A[nixos-settings/usersList.nix] --> B[modules/users-manager.nix]
    A --> C[modules/home-manager-generator.nix]
    
    B --> D[NixOS System Users]
    C --> E[Home Manager Configs]
    
    F[hosts/laptop/default.nix] --> G[system.selectedUsers]
    G --> B
    
    H[features/base.nix] --> I[All Hosts]
    J[features/applications/] --> I
    K[features/development/] --> I
    
    style A fill:#bf616a,color:#000
    style D fill:#a3be8c,color:#000
    style E fill:#ebcb8b,color:#000
    style I fill:#5277c3,color:#000
```

### Host Hierarchy

```mermaid
graph TD
    A[hosts/] --> B[laptop/]
    A --> C[desktop/]
    A --> D[server/]
    A --> E[vm/]
    A --> F[cloud/]
    
    B --> B1[default.nix]
    B --> B2[personal/]
    B2 --> B3[personal.nix]
    B2 --> B4[hardware-configuration.nix]
    
    C --> C1[default.nix]
    D --> D1[default.nix]
    E --> E1[default.nix]
    E --> E2[personal/]
    F --> F1[default.nix]
    
    style A fill:#5277c3,color:#000
    style B fill:#a3be8c,color:#000
    style B2 fill:#ebcb8b,color:#000
    style E2 fill:#ebcb8b,color:#000
```

### User Management Flow

```mermaid
sequenceDiagram
    participant U as nixos-settings/usersList.nix
    participant H as Host Config
    participant M as users-manager.nix
    participant S as NixOS System
    participant HM as Home Manager
    
    U->>M: Define users (casper, koko)
    H->>M: selectedUsers = ["casper"]
    M->>S: Create system user "casper"
    U->>HM: Generate HM config for all users
    HM->>S: Apply dotfiles for "casper"
    
    Note over U,HM: Single source of truth ensures consistency
```

### Feature Organization

```
features/
├── base.nix (imported by ALL hosts)
│   ├── locale.nix
│   ├── networking.nix
│   └── users-manager.nix
│
├── applications/ (user apps)
├── desktop-environments/ (UI)
├── development/ (dev tools)
├── hardware/ (audio, bluetooth, printing)
└── system/ (locale, power)
```

---

## 📚 Documentation

Comprehensive documentation is available in the `docs/` directory (beginner-first):

- **[Complete Guide](docs/README.md)** - Zero→Working Install, detailed User Management, Home Manager & Themes, cheat‑sheets

Unfree packages policy (for VS Code, Brave, Chrome) is handled per‑feature via an allow-list; see the Unfree section in `docs/README.md`.
  
- **[Features Documentation](features/README.md)** - Detailed feature organization and usage

- **[User Management](nixos-settings/README.md)** - Centralized user system documentation

- **[ROADMAP](ROADMAP.md)** - Project roadmap and implementation status

### Key Concepts

| Concept | Description |
|---------|-------------|
| **Hosts** | Individual machine configurations (laptop, desktop, server, etc.) |
| **Variants** | Host-specific customizations (e.g., `laptop@personal`, `laptop@work`) |
| **Features** | Reusable configuration modules organized by category |
| **Modules** | Low-level system components used by features |
| **Users** | Centrally defined in `usersList.nix`, selected per host |

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

### Reporting Issues

1. **Check existing issues** to avoid duplicates
2. **Provide details**:
   - What you tried to do
   - What happened (error messages, logs)
   - What you expected to happen
   - Your NixOS version and system info

### Submitting Changes

1. **Fork the repository**
2. **Create a feature branch**:
   ```bash
   git checkout -b feature/my-improvement
   ```
3. **Make your changes**:
   - Follow the existing code style
   - Add comments explaining complex logic
   - Test your changes thoroughly
4. **Commit with clear messages**:
   ```bash
   git commit -m "feat: add support for XYZ"
   ```
5. **Push and create PR**:
   ```bash
   git push origin feature/my-improvement
   ```

### Guidelines

- **Features**: Place in appropriate `features/` subfolder
- **Documentation**: Update relevant docs when changing behavior
- **Comments**: Explain WHY, not just WHAT
- **Testing**: Test on a VM before submitting
- **Compatibility**: Ensure changes work across host types

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- [NixOS](https://nixos.org/) - The purely functional Linux distribution
- [Home Manager](https://github.com/nix-community/home-manager) - Declarative user environment management
- [nixy themes](https://github.com/anotherhadi/nixy/tree/main/themes) - Theme system inspiration
- The NixOS community for excellent documentation and support

---

## ⭐ Star History

If you find this project useful, please consider giving it a star! ⭐

---

**Built with ❤️ using NixOS**