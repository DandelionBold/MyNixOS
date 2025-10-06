{ config, lib, pkgs, ... }:

{
  # Browser applications - Firefox as default
  programs.firefox = {
    enable = true;
    # Set as default browser
    package = pkgs.firefox;
  };
}
