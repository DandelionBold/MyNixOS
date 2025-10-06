{ config, lib, pkgs, ... }:

{
  services.nginx = {
    enable = lib.mkDefault false; # enable per host/role
    virtualHosts = {
      # Example vhost; keep disabled until used
      # "example.local" = {
      #   root = "/var/www/example";
      #   enableACME = false; # set true when using ACME
      #   forceSSL = false;
      # };
    };
  };
}


