{ config, pkgs, lib, ... }:

{
  # Server host type
  imports = [
    # Base modules (common to all hosts)
    ../modules/base.nix
    
    # Server-specific modules
    ../modules/databases.nix
    ../modules/nginx.nix
    ../modules/firewall-allowlist.nix

    # Server-specific features
    ../features/server.nix
  ];

  networking.hostName = "server";
  networking.firewall.enable = false;
}


