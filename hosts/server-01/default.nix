{ config, pkgs, lib, ... }:

{
  # Headless server host example
  imports = [
    ../../modules/locale.nix
    ../../modules/networking.nix
    ../../modules/databases.nix
    ../../modules/nginx.nix
    ../../modules/firewall-allowlist.nix

    ../../roles/server.nix
    # ../../roles/db.nix   # enable if this server should host DBs
    # ../../roles/k3s.nix  # enable for k3s server role
  ];

  networking.hostName = "server-01";

  # Explicitly keep firewall disabled unless this host needs allow-lists
  networking.firewall.enable = false;

  # Example: to open ports, enable firewall and set allow-lists
  # networking.firewall = {
  #   enable = true;
  #   allowedTCPPorts = [ 22 80 443 ];
  # };
  # See docs/FIREWALL.md for more presets and tips.

  # Example: enable nginx with a simple HTTP site
  # services.nginx = {
  #   enable = true;
  #   virtualHosts = {
  #     "server-01.local" = {
  #       root = "/var/www/server-01";
  #       locations."/".extraConfig = "autoindex on;";
  #     };
  #   };
  # };

  # Example: enable MySQL (MariaDB) server
  # services.mysql.enable = true;
  # services.mysql.package = pkgs.mariadb;

  # Example: enable Redis server
  # services.redis.enable = true;

  # Example: enable MSSQL server (EULA; additional channel required)
  # services.mssql.enable = true;
}


