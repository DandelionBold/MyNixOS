{ config, lib, pkgs, ... }:

{
  # Boot loader configuration
  boot.loader = {
    # GRUB bootloader
    grub = {
      enable = true;
      device = "/dev/sda";  # Change this to your actual boot device
      useOSProber = true;   # Detect other operating systems
      
      # Additional GRUB settings
      configurationName = "NixOS";
      timeoutStyle = "menu";
      extraConfig = ''
        # Custom GRUB configuration can be added here
      '';
    };
    
    # Alternative: systemd-boot (uncomment if preferred over GRUB)
    # systemd-boot = {
    #   enable = true;
    #   editor = false;  # Disable editor for security
    # };
    
    # Alternative: EFI boot (uncomment if using UEFI)
    # efi = {
    #   canTouchEfiVariables = true;
    #   efiSysMountPoint = "/boot/efi";
    # };
  };
  
  # Boot kernel parameters
  boot.kernelParams = [
    # Add any custom kernel parameters here
    # "quiet"           # Reduce boot messages
    # "splash"          # Show splash screen
    # "nomodeset"       # Disable KMS (if having graphics issues)
  ];
  
  # Boot timeout
  boot.loader.timeout = 5;  # 5 seconds timeout
}
