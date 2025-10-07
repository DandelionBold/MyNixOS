{ config, pkgs, lib, ... }:

{
  # Base modules that ALL hosts should have
  imports = [
    ./system/locale.nix
    ./system/networking.nix
    ../modules/users-manager.nix
    # Add other common modules here that every host needs
  ];
}
