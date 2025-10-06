{ config, pkgs, lib, ... }:

{
  # WSL host specifics (to be refined when deploying)
  imports = [
    ../../modules/locale.nix
    ../../modules/networking.nix
  ];

  networking.hostName = "wsl";

  # Note: WSL has its own networking/journal quirks; we will adjust later.
}


