{ config, lib, pkgs, ... }:

{
  # Development environment - imports containers, programming languages, and databases
  imports = [
    ../features/containers.nix
    ../features/programming-languages.nix
    ../modules/databases.nix
  ];
}


