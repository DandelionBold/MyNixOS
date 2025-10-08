{ config, lib, pkgs, ... }:

{
  # VSCode IDE (declare once, reuse for unfree allow-list)
  let
    vscodePkg = pkgs.vscode;
  in
  {
    programs.vscode = {
      enable = true;
      package = vscodePkg;
    };

    # Allow unfree for exactly what we use
    my.allowedUnfreePackages = [ (lib.getName vscodePkg) "vscode-with-extensions" ];
  }
}
