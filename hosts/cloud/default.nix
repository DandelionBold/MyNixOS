{ config, pkgs, lib, ... }:

{
  # Cloud host type
  imports = [
    # Base features (common to all hosts)
    ../features/base.nix
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

  networking.hostName = "cloud";
  networking.firewall.enable = false;
}


