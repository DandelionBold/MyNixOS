{ config, pkgs, lib, ... }:

{
  # Desktop host type
  imports = [
    # Base features (common to all hosts)
    ../features/base.nix
    
    # Desktop-specific features
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
    ../features/system/fonts.nix
    ../features/system/power.nix
    # ../features/system/filesystems-btrfs.nix
  ];

  networking.hostName = "desktop";
  networking.firewall.enable = false;
}


