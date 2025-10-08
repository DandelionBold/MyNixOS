{ config, pkgs, lib, ... }:

{
  # Base modules that ALL hosts should have
  imports = [
    ./system/locale.nix
    ./system/networking.nix
    ./system/boot-loader.nix
    ./system/home-manager.nix
    ../modules/users-manager.nix
    # Add other common modules here that every host needs
  ];

  # Enable Nix experimental features system-wide
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Enable Nix substituters for faster downloads
  nix.settings.substituters = [ "https://cache.nixos.org/" ];
  nix.settings.trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X43100gWypbMrAURkbJ16ZPMQFGspcDSh.jY=" ];

  # Allow specific unfree packages used by this configuration
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vscode"
    "vscode-with-extensions"
    "brave"
    "google-chrome"
  ];
}
