{ config, pkgs, lib, ... }:

{
  # VM host type
  imports = [
    # Base features (common to all hosts)
    ../../features/base.nix
    
    # VM-specific modules
    ../../modules/vm-manager.nix
  ];

  networking.hostName = "vm";
  networking.firewall.enable = false;

  # NixOS state version (for compatibility)
  system.stateVersion = "25.05";

  # Select which users to create on this host
  system.selectedUsers = [ "casper" ];

  # VM profile: minimal services for virtual machines
  # Disable unnecessary services for VM environments
  
  # Disable power management in VMs
  powerManagement.enable = false;
  
  # === VM-SPECIFIC SETTINGS (centralized here) ===
  
  # Disable audio in VMs (can be overridden in personal variants)
  services.pipewire.enable = lib.mkDefault false;
  
  # Disable printing in VMs (can be overridden in personal variants)
  services.printing.enable = lib.mkDefault false;
  hardware.sane.enable = lib.mkDefault false;
  
  # Disable Bluetooth in VMs (can be overridden in personal variants)
  hardware.bluetooth.enable = lib.mkDefault false;
  
  # Optimize for VM performance
  boot.kernelParams = [ "console=ttyS0" ];
  
  # Enable SSH for remote access
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # Default filesystem configuration for VM (can be overridden by hardware-configuration.nix)
  fileSystems."/" = lib.mkDefault {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
}


