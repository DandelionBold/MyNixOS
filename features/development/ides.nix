{ config, lib, pkgs, ... }:

{
  # VSCode IDE
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
  };
}
