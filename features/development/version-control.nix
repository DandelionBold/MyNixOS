{ config, lib, pkgs, ... }:

{
  # Version control tools
  environment.systemPackages = with pkgs; [
    git
    git-lfs
    git-crypt
    gh  # GitHub CLI
  ];
}
