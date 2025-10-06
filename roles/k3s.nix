{ config, lib, pkgs, ... }:

{
  # K3s role (server by default)
  imports = [ ../modules/k3s.nix ];
  services.k3s.enable = true;
  services.k3s.role = lib.mkDefault "server";
}


