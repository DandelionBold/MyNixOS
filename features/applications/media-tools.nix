{ config, lib, pkgs, ... }:

{
  # Media tools and players
  environment.systemPackages = with pkgs; [
    vlc
    gimp
    krita
    audacity
    ffmpeg
    imagemagick
  ];
}
