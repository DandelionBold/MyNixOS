nix.settings = {
  experimental-features = [ "nix-command" "flakes" ];
  # Prefer well-known binary caches for faster builds
  substituters = [
    "https://cache.nixos.org/"
    "https://hydra.nixos.org"
  ];
  trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
  ];
};
