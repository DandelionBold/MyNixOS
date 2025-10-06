{ config, lib, pkgs, ... }:

{
  # Database services are off by default; enable per host as needed
  services.mysql.enable = lib.mkDefault false;
  services.redis.enable = lib.mkDefault false;

  # MSSQL server/tools (note: EULA). Keep disabled by default.
  services.mssql.enable = lib.mkDefault false;
}


