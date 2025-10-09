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

  # MSSQL via Docker container (SQL Server 2022) - COMMENTED OUT DUE TO STARTUP ISSUES
  # virtualisation.oci-containers = {
  #   backend = "docker";
  #   containers.mssql = {
  #     image = "mcr.microsoft.com/mssql/server:2022-latest";
  #     ports = [ "11433:1433" ];  # host:container (changed host port)
  #     environment = {
  #       ACCEPT_EULA = "Y";
  #       MSSQL_SA_PASSWORD = "ChangeMe123!"; # pick your own
  #       MSSQL_PID = "Developer";
  #     };
  #     volumes = [ "/var/lib/mssql:/var/opt/mssql" ];
  #     extraOptions = [ "--restart=unless-stopped" ];
  #   };
  # };
  # # make sure the volume exists
  # systemd.tmpfiles.rules = [ "d /var/lib/mssql 0750 root root -" ];
}


