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
- **Browsers**: Firefox (default), Brave
- **Terminals**: Alacritty, Kitty, GNOME Terminal, Konsole
- **File Managers**: Dolphin, Thunar, Ranger, Nautilus
- **Text Editors**: Vim, Emacs, Neovim, Kate, Gedit
- **Media Tools**: VLC, GIMP, Krita, Audacity, FFmpeg
- **Office Suite**: LibreOffice, OnlyOffice, Calibre
- **System Tools**: btop, htop, neofetch, wireshark, and more

### 💻 Development
- **Languages**: Python (extensible to others)
- **Containers**: Docker, Kubernetes (k3s)
- **Databases**: MySQL, MSSQL, Redis
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

- **NixOS** installed on your machine
- **Git** for cloning the repository
- Basic understanding of Nix and flakes
- **Enable flakes** in your NixOS configuration:
  ```nix
  # /etc/nixos/configuration.nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  ```

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/DandelionBold/MyNixOS.git
   cd MyNixOS
   ```

2. **Review available configurations:**
   ```bash
   nix flake show
   ```

3. **Customize for your needs:**
   - Edit `nixos-settings/usersList.nix` to add/modify users
   - Choose which features to enable in `hosts/<hostname>/default.nix`
   - Set your timezone/locale in `features/system/locale.nix`

### First Build

1. **Test build (doesn't apply changes):**
   ```bash
   nixos-rebuild build --flake .#laptop
   ```

2. **Apply configuration:**
   ```bash
   sudo nixos-rebuild switch --flake .#laptop
   ```

3. **Build Home Manager configuration (optional):**
   ```bash
   home-manager switch --flake .#casper
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