{ config, lib, pkgs, ... }:

{
  # Docker containerization
  virtualisation.docker.enable = true;
  
  # Kubernetes (k3s) - disabled by default
  services.k3s = {
    enable = lib.mkDefault false;
    role = "server";
  };
}
