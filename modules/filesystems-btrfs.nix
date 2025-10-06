{ config, lib, pkgs, ... }:

{
  # BTRFS defaults (example structure; adjust per host as needed)
  # Snapper skeleton can be added later.
  # Mount options: zstd compression, noatime, SSD optimizations.
  fileSystems."/".options = [ "compress=zstd" "noatime" ];
}


