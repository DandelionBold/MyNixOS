{ config, pkgs, lib, ... }:

{
  # Cloud host example (headless)
  imports = [
    ../../modules/locale.nix
    ../../modules/networking.nix
    ../../roles/server.nix
  ];

  networking.hostName = "cloud-01";
  networking.firewall.enable = false;

  # cloud-init friendliness and metadata services can be configured later.
}


