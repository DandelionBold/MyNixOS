{ config, lib, pkgs, ... }:

let
  vmType = config._module.args.vmType or "virtualbox";
in {
  # VM-specific configurations based on _module.args.vmType
  virtualisation = {
    # VirtualBox guest additions
    virtualbox.guest.enable = lib.mkIf (vmType == "virtualbox") true;
    
    # VMware guest additions
    vmware.guest.enable = lib.mkIf (vmType == "vmware") true;
    
    # QEMU/KVM guest optimizations
    qemu.guestAgent.enable = lib.mkIf (vmType == "qemu") true;
    
    # Hyper-V guest services
    hypervGuest.enable = lib.mkIf (vmType == "hyperv") true;
    
    # Docker-in-Docker support (for containerized VMs)
    docker.enable = lib.mkIf (vmType == "docker") true;
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
    qemuGuest.enable = lib.mkIf (vmType == "qemu") true;
    
    # VMware tools
    open-vm-tools.enable = lib.mkIf (vmType == "vmware") true;
  };

  # VM-optimized hardware settings
  hardware = {
    # Disable Bluetooth in VMs
    bluetooth.enable = lib.mkDefault false;
  };
  
  # Disable audio services in VMs by default (can be overridden)
  services.pipewire.enable = lib.mkDefault false;
}
