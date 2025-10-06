{ config, lib, pkgs, ... }:

{
  # Other general applications
  environment.systemPackages = with pkgs; [
    # Add general applications that don't fit other categories here
  ];
}
