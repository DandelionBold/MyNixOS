{ config, lib, pkgs, ... }:

{
  # Development environment - imports containers, programming languages, databases, IDEs, and version control
  imports = [
    ./containers.nix
    ./programming-languages.nix
    ./databases.nix
    ./ides.nix
    ./version-control.nix
  ];
}


