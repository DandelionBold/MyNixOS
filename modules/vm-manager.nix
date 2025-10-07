{ config, lib, pkgs, ... }:

let
  vmType = config._module.args.vmType or "virtualbox";
in {
  # VM Manager - provides VM detection and shared VM optimizations
  # Note: VM-specific settings (audio, printing, etc.) are in hosts/vm/default.nix
  
  # VM-specific configurations based on _module.args.vmType
  virtualisation = {
    # VirtualBox guest additions
    virtualbox.guest.enable = (vmType == "virtualbox");
    virtualbox.guest.x11 = (vmType == "virtualbox");
    
    # VMware guest additions
    vmware.guest.enable = (vmType == "vmware");

    # Docker-in-Docker support (for containerized VMs)
    docker.enable = (vmType == "docker");
  };

  # VM-optimized settings regardless of type
  boot = {
    # Faster boot for VMs
    kernelParams = [ "quiet" "splash" ];
    # Reduce console verbosity
    consoleLogLevel = 3;
  };

  # VM-specific services
  services = {
    # Enable qemu-guest-agent for better VM integration
    qemuGuest.enable = (vmType == "qemu");
    
    # Hyper-V
    hyperv-daemons.enable = (vmType == "hyperv");
  };

  # VM-optimized hardware settings
  hardware = {
    # Disable Bluetooth in VMs
    bluetooth.enable = lib.mkDefault false;
  };
}
