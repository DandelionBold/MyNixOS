{ config, lib, pkgs, ... }:

{
  # VSCode IDE (declare once and derive unfree allow-list from packages)
  let
    vscodePkg = pkgs.vscode;
    unfreePkgs = [ vscodePkg ];
    unfreeNames = (map (p: lib.getName p) unfreePkgs) ++ [ "vscode-with-extensions" ];
  in
  {
    programs.vscode = {
      enable = true;
      package = vscodePkg;
    };

    # Allow unfree for exactly what we use
    my.allowedUnfreePackages = unfreeNames;
  }
}
