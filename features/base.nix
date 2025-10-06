{ config, pkgs, lib, ... }:

{
  # Base modules that ALL hosts should have
  imports = [
    ./locale.nix
    ./networking.nix
    ./user.nix
    # Add other common modules here that every host needs
  ];
}
