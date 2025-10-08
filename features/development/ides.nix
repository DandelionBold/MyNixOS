{ config, lib, pkgs, ... }:

{
  # VSCode IDE (use VSCodium by default to avoid unfree)
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };
}
