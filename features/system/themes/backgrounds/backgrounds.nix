{ config, lib, pkgs, ... }:

{
  # Background images configuration
  # 
  # Usage:
  # 1. For internet images (default): Images are downloaded from URLs
  # 2. For local images: Place images in ./images/ folder and change source paths below
  
  # Download default wallpapers from the internet
  # These will be fetched during system build
  environment.systemPackages = with pkgs; [
    (pkgs.runCommand "nixos-wallpapers" {} ''
      mkdir -p $out/share/backgrounds
      
      # Download default wallpaper (NixOS blue/purple abstract)
      ${pkgs.curl}/bin/curl -L -o $out/share/backgrounds/default.jpg \
        https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nix-wallpaper-nineish-dark-gray.png || \
        ${pkgs.curl}/bin/curl -L -o $out/share/backgrounds/default.jpg \
        https://w.wallhaven.cc/full/pk/wallhaven-pkz3yy.jpg
      
      # Use same image for SDDM and GNOME for now
      cp $out/share/backgrounds/default.jpg $out/share/backgrounds/sddm.jpg
      cp $out/share/backgrounds/default.jpg $out/share/backgrounds/gnome.jpg
    '')
  ];

  # OPTION: To use local images instead:
  # 1. Create an "images/" folder here: features/system/themes/backgrounds/images/
  # 2. Add your images: default.jpg, sddm.jpg, gnome.jpg
  # 3. Uncomment this section and comment out the runCommand above:
  #
  # environment.etc = {
  #   "backgrounds" = {
  #     source = ./images;
  #     target = "backgrounds";
  #   };
  # };

  # KDE Plasma wallpaper configuration
  # Uses downloaded or local wallpaper
  services.desktopManager.plasma6 = lib.mkIf config.services.desktopManager.plasma6.enable {
    enable = true;
    # Wallpaper will be available at this path after build
    # Note: You may need to set this manually in KDE settings first time
  };

  # SDDM background configuration
  services.displayManager.sddm = lib.mkIf config.services.displayManager.sddm.enable {
    enable = true;
    settings = {
      Theme = {
        Current = "breeze";
        # Background image (if using local images, set to /etc/backgrounds/sddm.jpg)
      };
    };
  };

  # GNOME wallpaper (if using GNOME)
  services.xserver.desktopManager.gnome = lib.mkIf config.services.xserver.desktopManager.gnome.enable {
    enable = true;
    # Wallpaper can be set through GNOME settings
  };
}
