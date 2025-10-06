{ config, lib, pkgs, ... }:

{
  # Fonts: Inter (UI) + JetBrainsMono Nerd Font (dev)
  fonts.packages = with pkgs; [
    inter
    jetbrains-mono
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
