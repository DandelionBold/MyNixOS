{ config, pkgs, lib, ... }:

{
  # Server host type
  imports = [
    ../modules/locale.nix
    ../modules/networking.nix
    ../modules/user.nix
    ../modules/databases.nix
    ../modules/nginx.nix
    ../modules/firewall-allowlist.nix

    ../roles/server.nix
  ];

  networking.hostName = "server";
  networking.firewall.enable = false;
}


