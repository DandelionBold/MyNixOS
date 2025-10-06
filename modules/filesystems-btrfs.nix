{ config, lib, pkgs, ... }:

{
  # BTRFS configuration with subvolumes and compression
  # Example subvolume structure: @, @home, @nix, @log, @cache
  # Adjust per host as needed
  
  fileSystems."/".options = [ 
    "compress=zstd" 
    "noatime" 
    "ssd" 
    "space_cache=v2" 
  ];

  # Snapper configuration skeleton (disabled by default)
  services.snapper = {
    enable = lib.mkDefault false;
    configs = lib.mkIf config.services.snapper.enable {
      root = {
        subvolume = "/";
        extraConfig = ''
          ALLOW_USERS="casper"
          TIMELINE_CREATE=yes
          TIMELINE_CLEANUP=yes
          TIMELINE_LIMIT_HOURLY=5
          TIMELINE_LIMIT_DAILY=7
          TIMELINE_LIMIT_WEEKLY=3
          TIMELINE_LIMIT_MONTHLY=2
          TIMELINE_LIMIT_YEARLY=1
        '';
      };
    };
  };
}


