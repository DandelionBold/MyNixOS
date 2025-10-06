{ config, pkgs, lib, ... }:

{
  # Laptop host type
  imports = [
    # Base features (common to all hosts)
    ../features/base.nix
    
    # Laptop-specific features
    ../features/desktop-environments/desktop-environment.nix
    ../features/applications/browsers.nix
    ../features/applications/terminals.nix
    ../features/applications/file-managers.nix
    ../features/applications/gui-text-editors.nix
    ../features/applications/cli-text-editors.nix
    ../features/applications/screenshot-tools.nix
    ../features/applications/media-tools.nix
    ../features/applications/office-suite.nix
    ../features/applications/system-tools.nix
    ../features/applications/other-applications.nix
    ../features/hardware/bluetooth.nix
    ../features/hardware/printing.nix
    ../features/hardware/audio.nix
    ../features/system/hibernate.nix
    ../features/development/dev.nix
    ../features/system/power.nix
    ../features/system/themes/themes.nix
    ../features/system/themes/dark-theme.nix
    # ../features/system/filesystems-btrfs.nix  # enable after disk layout is finalized

    # Hardware configuration (auto-generated)
    ./personal/hardware-configuration.nix
  ];

  networking.hostName = "laptop";
  networking.firewall.enable = false;

  # Laptop profile: power tweaks and hibernation toggle
  powerManagement.powertop.enable = true;
  services.power-profiles-daemon.enable = true;

  # Hibernate support (requires swap and resume configured per host)
  systemd.targets.hibernate.enable = lib.mkDefault true;
}


