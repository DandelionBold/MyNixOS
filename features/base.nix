{ config, pkgs, lib, ... }:

{
  # Base modules that ALL hosts should have
  imports = [
    ./system/locale.nix
    ./system/networking.nix
    ./system/boot-loader.nix
    ./system/home-manager.nix
    ../modules/unfree-packages.nix
    ../modules/users-manager.nix
    # Add other common modules here that every host needs
  ];

  # Enable Nix experimental features system-wide
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Enable Nix substituters for faster downloads
  nix.settings.substituters = [ "https://cache.nixos.org/" ];

  # Install Home Manager CLI for all hosts
  environment.systemPackages = with pkgs; [
    home-manager
  ];

}
