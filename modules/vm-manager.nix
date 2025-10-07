{ config, lib, pkgs, ... }:

let
  inherit (lib) mkIf mkMerge;
  vmType = config._module.args.vmType or "virtualbox";
in
{
  # VM Manager - provides VM detection and shared VM optimizations
  # Note: VM-specific settings (audio, printing, etc.) are in hosts/vm/default.nix

  virtualisation = mkMerge [
    (mkIf (vmType == "virtualbox") { virtualbox.guest.enable = true; })
    (mkIf (vmType == "vmware")     { vmware.guest.enable   = true; })
    (mkIf (vmType == "docker")     { docker.enable         = true; })
  ];

  services = mkMerge [
    (mkIf (vmType == "qemu") { qemuGuest.enable = true; })
  ];

  # VM-optimized hardware settings
  hardware = {
    # Disable Bluetooth in VMs
    bluetooth.enable = lib.mkDefault false;
  };
}
