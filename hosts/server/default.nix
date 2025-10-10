{ config, pkgs, lib, ... }:

{
  # Server host type
  imports = [
    # Base features (common to all hosts)
    ../../features/base.nix
    
    # Server-specific modules
    ../../features/development/databases.nix
    ../../modules/nginx.nix
    ../../modules/firewall-allowlist.nix
  ];

  # Headless server defaults
  services.xserver.enable = false;

  # SSH hardened defaults
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # nginx baseline (disabled by default; enable per host)
  services.nginx.enable = lib.mkDefault false;

  networking.hostName = "server";
  networking.firewall.enable = false;

  # NixOS state version (for compatibility)
  system.stateVersion = "25.05";

  # Select which users to create on this host
  system.selectedUsers = [ "casper" ];

  # Default filesystem configuration for server (can be overridden by hardware-configuration.nix)
  fileSystems."/" = lib.mkDefault {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
}


