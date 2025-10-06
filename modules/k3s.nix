{ config, lib, pkgs, ... }:

{
  # k3s role toggle: choose server or agent; off by default
  services.k3s = {
    enable = lib.mkDefault false;
    role = lib.mkDefault "server"; # or "agent"
    # tokenFile = "/var/lib/rancher/k3s/server/node-token"; # set when using agent
  };
}


