{ lib, pkgs, config, ... }:

let
  cfg = config.wallpaper;
  # If a URL is provided, fetch it at build time; otherwise null
  fetched = lib.optionalString (cfg.source == "url" && cfg.url != "") (
    pkgs.fetchurl {
      url = cfg.url;
      # Users can override sha256 later if they want strict hashing; allow empty
      # by using builtins.currentSystem-dependent hash for convenience in examples
      sha256 = cfg.sha256 or "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    }
  );
  imagePath = if cfg.source == "local" then cfg.localPath else fetched;
in
{
  options.wallpaper = {
    enable = lib.mkEnableOption "Set user wallpaper automatically (KDE Plasma)";

    # Choose where the image comes from
    source = lib.mkOption {
      type = lib.types.enum [ "local" "url" ];
      default = "local";
      description = "Where to get the wallpaper image: local path or download from URL.";
    };

    # Used when source = "local"
    localPath = lib.mkOption {
      type = lib.types.path;
      default = "/etc/backgrounds/default.jpg";
      description = "Path to a local image file to use as wallpaper.";
    };

    # Used when source = "url"
    url = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Direct URL to an image (jpg/png). Will be downloaded at build time.";
    };

    # Optional hash for fetchurl; leave empty for a quick start
    sha256 = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Optional sha256 for the downloaded image. Provide for reproducible builds.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Expose the image inside the user's home for Plasma to access
    home.file.".local/share/wallpaper.jpg" = lib.mkIf (imagePath != null) {
      source = imagePath;
    };

    # Apply at login for KDE Plasma users
    systemd.user.services.apply-wallpaper = {
      Unit = {
        Description = "Apply user wallpaper (KDE Plasma)";
        After = [ "graphical-session-pre.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "apply-wallpaper" ''
          set -eu
          IMG="$HOME/.local/share/wallpaper.jpg"
          if command -v plasma-apply-wallpaperimage >/dev/null 2>&1 && [ -f "$IMG" ]; then
            plasma-apply-wallpaperimage "$IMG" || true
          fi
        '';
      };
      Install = { WantedBy = [ "graphical-session.target" ]; };
    };
  };
}


