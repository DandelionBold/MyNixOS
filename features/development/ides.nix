{ config, lib, pkgs, ... }:

{
  # VSCode IDE
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
  };

  # Allow unfree for exactly what we use
  my.allowedUnfreePackages = [ "vscode" "vscode-with-extensions" ];
}
