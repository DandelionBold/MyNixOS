{ config, pkgs, lib, ... }:

{
  # Home Manager Integration Feature
  # This feature enables Home Manager system-wide integration
  
  # Enable Home Manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  
  # Initialize empty users (will be populated by users-manager.nix)
  home-manager.users = {};
  
  # Ensure Home Manager is properly integrated with the system
  home-manager.backupFileExtension = "backup";
}
