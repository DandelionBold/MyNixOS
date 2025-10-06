{ config, lib, pkgs, ... }:

let
  userName = config._module.args.user or "casper";
in {
  # Generic system user module driven by `_module.args.user`.
  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.bashInteractive;
  };
}


