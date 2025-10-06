{ config, lib, pkgs, ... }:

{
  # Database services (disabled by default; enable per host)
  services.mysql.enable = lib.mkDefault false;
  services.redis.enable = lib.mkDefault false;
  services.mssql.enable = lib.mkDefault false;
}


