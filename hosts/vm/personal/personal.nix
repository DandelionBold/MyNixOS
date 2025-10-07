{ config, pkgs, lib, ... }:

{
  # Import the base VM configuration
  imports = [ 
    ../default.nix
    # Hardware configuration (auto-generated, specific to this VM)
    ./hardware-configuration.nix
    
    # Desktop Environment
    ../../../features/desktop-environments/desktop-environment.nix
    ../../../features/desktop-environments/kde-plasma.nix
    
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
    ../../../features/system/themes/themes.nix
    ../../../features/system/themes/dark-theme.nix
  ];
  
  # Personal overrides for VM
  _module.args.vmType = "virtualbox";
  
  # Personal VM-specific customizations
  # Enable services you need
  # services.nginx.enable = true;
  # services.mysql.enable = true;
}
