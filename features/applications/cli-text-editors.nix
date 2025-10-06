{ config, lib, pkgs, ... }:

{
  # CLI text editors
  environment.systemPackages = with pkgs; [
    vim
    nano
    emacs
    neovim
  ];
}
