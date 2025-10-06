{ config, lib, pkgs, ... }:

{
  # Terminal applications
  environment.systemPackages = with pkgs; [
    alacritty
    kitty
    gnome.gnome-terminal
    konsole
    xterm
  ];
}
