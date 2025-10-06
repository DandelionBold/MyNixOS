{ config, pkgs, lib, ... }:

{
  # Entry module for host laptop-casper.
  # This will import shared modules/roles once they exist.

  networking.hostName = "laptop-casper";

  # Desktop role (KDE Plasma + SDDM) and workstation features will be wired later
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Network defaults per roadmap
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  # Audio: PipeWire stack per roadmap
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Printing/Scanning defaults
  services.printing.enable = true;
  hardware.sane.enable = true;

  # User baseline (to be moved into shared users module later)
  users.users.casper = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.bashInteractive; # default shell
  };

  # Unfree allowed globally per flake; keep here for clarity if we later split configs
  nixpkgs.config.allowUnfree = true;

  # Locale, time, keyboard per your preferences
  time.timeZone = "Africa/Cairo";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "ar_EG.UTF-8/UTF-8" ];
  services.xserver.xkb = {
    layout = "us,ara";
    variant = "";
    options = "grp;alt_shift_toggle";
  };

  # Browser
  programs.firefox.enable = true;

  # Docker (from dev role; will move to roles later)
  virtualisation.docker.enable = true;

  # Firewall off globally as per roadmap; per-host allowed ports will be templated later
  networking.firewall.enable = false;
}


