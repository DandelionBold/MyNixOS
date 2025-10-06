{ config, pkgs, lib, ... }:

{
  # Base features that ALL hosts should have
  imports = [
    ../modules/locale.nix
    ../modules/networking.nix
    ../modules/user.nix
    # Add other common modules here that every host needs
  ];
}
