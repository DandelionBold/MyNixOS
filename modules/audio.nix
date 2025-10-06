{ config, lib, pkgs, ... }:

{
  # PipeWire + WirePlumber audio stack
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };
}


