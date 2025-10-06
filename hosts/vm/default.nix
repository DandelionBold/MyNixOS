{ config, pkgs, lib, ... }:

{
  # VM host type
  imports = [
    # Base features (common to all hosts)
    ../features/base.nix
    
    # VM-specific modules
    ../modules/vm.nix

    # Hardware configuration (auto-generated)
    ./personal/hardware-configuration.nix
  ];

  networking.hostName = "vm";
  networking.firewall.enable = false;

  # VM profile: minimal services for virtual machines
  # Disable unnecessary services for VM environments
  
  # Disable power management in VMs
  powerManagement.enable = false;
  
  # Disable audio in VMs (usually not needed)
  hardware.pulseaudio.enable = false;
  services.pipewire.enable = false;
  
  # Disable printing in VMs
  services.printing.enable = false;
  hardware.sane.enable = false;
  
  # Disable Bluetooth in VMs
  hardware.bluetooth.enable = false;
  
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
}


