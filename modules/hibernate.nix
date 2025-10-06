{ config, lib, pkgs, ... }:

{
  # Hibernation scaffolding for laptops.
  # NOTE: You must set a valid resume device and have swap >= RAM.
  # Example (uncomment and adjust per host):
  # swapDevices = [ { device = "/swapfile"; size = 8192; } ];
  # boot.resumeDevice = "/dev/disk/by-uuid/REPLACE_WITH_SWAP_OR_ENCRYPTED_ROOT_UUID";

  # Enable the hibernate target by default for laptop profile; safe if resume is unset
  systemd.targets.hibernate.enable = lib.mkDefault true;
}


