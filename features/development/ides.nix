{ config, lib, pkgs, ... }:

{
  # VSCode IDE
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
  };

  # Allow unfree VSCode for this feature
  my.allowedUnfreePackages = [ "vscode" "vscode-with-extensions" ];
}
