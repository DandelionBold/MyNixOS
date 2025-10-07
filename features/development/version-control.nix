{ config, lib, pkgs, ... }:

{
  # Version control tools
  environment.systemPackages = with pkgs; [
    git
  ];

  # Git configuration (system-wide)
  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
      # Users can override these with their own ~/.gitconfig
      # or set them per-user in the user.nix module
    };
  };
}
