{ config, lib, pkgs, ... }:

{
  # Enable k3s server by default for this role; override per host as needed
  imports = [ ../modules/k3s.nix ];
  services.k3s.enable = true;
  services.k3s.role = lib.mkDefault "server";
}


