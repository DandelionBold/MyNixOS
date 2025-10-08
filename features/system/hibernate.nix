{ config, lib, pkgs, ... }:

{
  # Hibernation support for laptops
  # NOTE: You must set a valid resume device and have swap >= RAM.
  # Example (uncomment and adjust per host):
  # swapDevices = [ { device = "/swapfile"; size = 8192; } ];
  # boot.resumeDevice = "/dev/disk/by-uuid/REPLACE_WITH_SWAP_OR_ENCRYPTED_ROOT_UUID";

  # Enable hibernate target and power management
  systemd.targets.hibernate.enable = lib.mkDefault true;
  systemd.targets.suspend-then-hibernate.enable = lib.mkDefault true;
  
  # Power management for hibernation (can be overridden by hosts)
  powerManagement = {
    enable = lib.mkDefault true;
    cpuFreqGovernor = lib.mkDefault "powersave";
  };
}


