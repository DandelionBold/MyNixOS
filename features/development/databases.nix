{ config, lib, pkgs, ... }:

{
  # Database services - enabled via this feature; override per-host with mkDefault if needed
  
  # MySQL (MariaDB)
  services.mysql = {
    enable = lib.mkDefault true;
    package = pkgs.mariadb;
  };

  # Redis
  services.redis.enable = lib.mkDefault true;

  # MSSQL via Docker container (SQL Server 2022)
  virtualisation.oci-containers = {
    backend = "docker";
    containers.mssql = {
      image = "mcr.microsoft.com/mssql/server:2022-latest";
      ports = [ "1433:1433" ];
      environment = {
        ACCEPT_EULA = "Y";
        MSSQL_SA_PASSWORD = "ChangeMe123!"; # change me or wire via secrets
      };
      extraOptions = [ "--restart=unless-stopped" ];
    };
  };
}


