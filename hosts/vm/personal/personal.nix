{ config, pkgs, lib, ... }:

{
  # Import the base VM configuration
  imports = [ 
    ../default.nix
    # Hardware configuration (auto-generated, specific to this VM)
    ./hardware-configuration.nix
    
    # Desktop Environment
    ../../../features/desktop-environments/desktop-environment.nix
    
    # Development Tools
    ../../../features/development/dev.nix
    ../../../features/development/containers.nix
    ../../../features/development/databases.nix
    
    # Applications
    ../../../features/applications/browsers.nix
    ../../../features/applications/terminals.nix
    ../../../features/applications/file-managers.nix
    ../../../features/applications/gui-text-editors.nix
    ../../../features/applications/cli-text-editors.nix
    ../../../features/applications/screenshot-tools.nix
    ../../../features/applications/media-tools.nix
    ../../../features/applications/office-suite.nix
    ../../../features/applications/system-tools.nix
    ../../../features/applications/other-applications.nix
    
    # Hardware Support
    ../../../features/hardware/bluetooth.nix
    ../../../features/hardware/printing.nix
    ../../../features/hardware/audio.nix
    
   # System Features
   ../../../features/system/hibernate.nix
   ../../../features/system/power.nix
  ];
  
  # Personal overrides for VM
  _module.args.vmType = "virtualbox";
  
  # Personal VM-specific customizations
  # Enable services you need
  # services.nginx.enable = true;
  # services.mysql.enable = true;

  # Databases
  services.mysql.enable = true;
  services.redis.enable = true;

  # MSSQL via Docker (SQL Server 2022)
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
