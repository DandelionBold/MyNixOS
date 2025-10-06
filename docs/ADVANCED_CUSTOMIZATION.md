# MyNixOS: Advanced Customization Guide

For users who want to go beyond basic configuration.

## Table of Contents
1. [Custom Themes](#custom-themes)
2. [Hardware Configuration](#hardware-configuration)
3. [User Management](#user-management)
4. [Secrets Management](#secrets-management)
5. [Development Environments](#development-environments)
6. [Performance Tuning](#performance-tuning)
7. [Security Hardening](#security-hardening)
8. [Custom Packages](#custom-packages)
9. [Overlays and Overrides](#overlays-and-overrides)
10. [Module Development](#module-development)

---

## Custom Themes

### Creating Custom Color Schemes

Create a new theme file in `features/system/themes/`:

```nix
# features/system/themes/custom-theme.nix
{ config, lib, pkgs, ... }:

{
  imports = [ ./themes.nix ];

  colorScheme = {
    name = "Custom Theme";
    colors = {
      base00 = "1a1a1a"; # Background
      base01 = "2a2a2a"; # Lighter background
      base02 = "3a3a3a"; # Selection background
      base03 = "4a4a4a"; # Comments
      base04 = "aaaaaa"; # Dark foreground
      base05 = "cccccc"; # Default foreground
      base06 = "eeeeee"; # Light foreground
      base07 = "ffffff"; # Lightest foreground
      base08 = "ff5555"; # Red
      base09 = "ffaa00"; # Orange
      base0A = "ffff55"; # Yellow
      base0B = "55ff55"; # Green
      base0C = "55ffff"; # Cyan
      base0D = "5555ff"; # Blue
      base0E = "ff55ff"; # Magenta
      base0F = "aa55ff"; # Brown
    };
  };

  # Custom GTK theme
  gtk.theme.name = "Custom-GTK-Theme";
  qt.style = "custom-qt-style";
}
```

### Custom Wallpapers

1. Add images to `features/system/themes/backgrounds/`
2. Configure in `backgrounds.nix`:

```nix
# features/system/themes/backgrounds/backgrounds.nix
{ config, lib, pkgs, ... }:

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

---

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

---

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

---

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

---

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

---

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

---

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

---

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

---

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

---

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

---

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
