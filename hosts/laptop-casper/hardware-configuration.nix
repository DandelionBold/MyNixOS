# Placeholder hardware-configuration.nix
# This file is typically generated on the target machine by `nixos-generate-config`.
# Keep this as a reminder to copy the generated file into this path when setting up the host.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
}


