{ config, lib, pkgs, ... }:

{
  # Development environment - imports containers, programming languages, and databases
  imports = [
    ./containers.nix
    ./programming-languages.nix
    ./databases.nix
  ];
}


