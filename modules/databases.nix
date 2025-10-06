{ config, lib, pkgs, ... }:

{
  # MySQL (MariaDB) off by default
  services.mysql = {
    enable = lib.mkDefault false;
    package = pkgs.mariadb;
  };

  # MSSQL off by default (requires EULA acceptance and extra channel)
  services.mssql.enable = lib.mkDefault false;

  # Redis off by default
  services.redis.enable = lib.mkDefault false;
}


