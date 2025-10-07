# NixOS Settings - Centralized Configuration

This directory contains the **single source of truth** for users and hosts in the system.

## 📁 Structure

```
nixos-settings/
├── usersList.nix    # All user definitions (system + home-manager)
├── hostTree.nix     # Host hierarchy and variants
└── README.md        # This file
```

## 🎯 Purpose

This centralized approach ensures:
1. **Single Source of Truth**: All user data in one place
2. **Consistency**: System user config + Home Manager config together
3. **Dynamic Generation**: Hosts select users, system generates configs
4. **Scalability**: Easy to add new users and hosts

## 👤 User Management (`usersList.nix`)

### Structure

Each user definition contains:

```nix
rec {
  # === NixOS System User Configuration ===
  username = "casper";
  isNormalUser = true;
  description = "Casper - Main User";
  extraGroups = [ "wheel" "networkmanager" "docker" ];
  shell = pkgs.bashInteractive;
  homeDirectory = "/home/${username}";
  
  # === Home Manager Configuration ===
  bash = { ... };
  git = { ... };
  vim = { ... };
  zsh = { ... };  # optional
}
```

### Adding a New User

1. Open `usersList.nix`
2. Add new user to the `usersList` array:

```nix
rec {
  username = "alice";
  isNormalUser = true;
  description = "Alice - Developer";
  extraGroups = [ "wheel" "networkmanager" ];
  shell = pkgs.bashInteractive;
  homeDirectory = "/home/${username}";
  
  bash = {
    enable = true;
    shellAliases = { ll = "ls -la"; };
  };
  
  git = {
    enable = true;
    userName = "Alice";
    userEmail = "alice@example.com";
  };
}
```

3. Select the user in a host configuration (see below)

## 🖥️ Host Management (`hostTree.nix`)

### Structure

```nix
{
  hostTree = {
    laptop = [ "personal" ];  # Has variant
    desktop = [ ];             # No variant
    server = [ ];              # No variant
  };
}
```

### Adding a New Host

1. Open `hostTree.nix`
2. Add host to the tree:

```nix
{
  hostTree = {
    # ... existing hosts
    workstation = [ ];  # Add new host
  };
}
```

3. Create host directory: `hosts/workstation/default.nix`

### Adding a Host Variant

1. Add variant name to host in `hostTree.nix`:

```nix
{
  hostTree = {
    laptop = [ "personal" "work" ];  # Add "work" variant
  };
}
```

2. Create variant directory: `hosts/laptop/work/work.nix`

## 🔧 Using the System

### In Host Configuration

In your `hosts/<hostName>/default.nix`:

```nix
{
  imports = [ ../features/base.nix ];
  
  # Select which users to create on this host
  system.selectedUsers = [ "casper" "koko" ];
  
  networking.hostName = "laptop";
}
```

### Building Configurations

#### System Configuration

```bash
# Build base host
nixos-rebuild switch --flake .#laptop

# Build host variant
nixos-rebuild switch --flake .#laptop@personal
```

#### Home Manager Configuration

```bash
# Apply user configuration
home-manager switch --flake .#casper
home-manager switch --flake .#koko
```

## 🔄 How It Works

### 1. User Creation Flow

```
nixos-settings/usersList.nix (defines users)
        ↓
modules/users-manager.nix (reads list)
        ↓
host config specifies: system.selectedUsers = [ "casper" ]
        ↓
NixOS system users created dynamically
```

### 2. Home Manager Flow

```
nixos-settings/usersList.nix (defines users)
        ↓
modules/home-manager-generator.nix (reads list)
        ↓
Home Manager configs generated for ALL users
        ↓
User activates with: home-manager switch --flake .#casper
```

### 3. Host Generation Flow

```
nixos-settings/hostTree.nix (defines hosts)
        ↓
flake.nix (reads tree)
        ↓
NixOS configurations generated dynamically
        ↓
nixosConfigurations = { laptop, laptop@personal, desktop, ... }
```

## 📋 Examples

### Example: Adding User to Desktop

1. User already defined in `usersList.nix`
2. Edit `hosts/desktop/default.nix`:

```nix
{
  system.selectedUsers = [ "casper" "alice" ];  # Add alice
}
```

3. Build:

```bash
nixos-rebuild switch --flake .#desktop
home-manager switch --flake .#alice
```

### Example: Laptop with Different Users

```nix
# hosts/laptop/default.nix
system.selectedUsers = [ "casper" ];  # Only casper

# hosts/laptop/work/work.nix
system.selectedUsers = [ "alice" ];   # Only alice at work
```

## 🎯 Benefits

1. **Consistency**: User definition in ONE place
2. **No Duplication**: Don't repeat user configs
3. **Type Safety**: Same structure for all users
4. **Easy Maintenance**: Update once, applies everywhere
5. **Clear Separation**: System config vs Home Manager config clearly marked
6. **Scalability**: Add users/hosts easily

## 📝 Notes

- System users are created per host based on `selectedUsers`
- Home Manager configs are available for ALL users (activate per user)
- User data includes both system AND personal configurations
- Comments in `usersList.nix` clearly separate system from Home Manager config

## 🚀 Quick Reference

```bash
# Build system
nixos-rebuild switch --flake .#<hostName>
nixos-rebuild switch --flake .#<hostName>@<variant>

# Build user environment
home-manager switch --flake .#<username>

# Example
nixos-rebuild switch --flake .#laptop
home-manager switch --flake .#casper
```
