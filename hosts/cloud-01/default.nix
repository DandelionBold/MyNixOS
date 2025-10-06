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

  # Example firewall allow-list (see docs/FIREWALL.md):
  # networking.firewall = {
  #   enable = true;
  #   allowedTCPPorts = [ 22 80 443 ];
  # };

  # Example: enable k3s server role (see docs/K3S.md):
  # services.k3s.enable = true;
  # services.k3s.role = "server";
}


