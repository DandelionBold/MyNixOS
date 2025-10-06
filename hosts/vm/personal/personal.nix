{ config, pkgs, lib, ... }:

{
  # User selection for this host
  _module.args.user = "casper";
  
  # VM type selection (virtualbox, vmware, qemu, hyperv, docker)
  _module.args.vmType = "virtualbox";
}
