{ config, lib, pkgs, ... }:

{
  # Development environment - imports containers, programming languages, databases, and IDEs
  imports = [
    ./containers.nix
    ./programming-languages.nix
    ./databases.nix
    ./ides.nix
  ];
}


