{ lib, config, ... }:

let
  cfg = config.my;
in
{
  options.my.allowedUnfreePackages = lib.mkOption {
    type = with lib.types; listOf str;
    default = [];
    description = "List of package names allowed to be unfree. Aggregated across features.";
  };

  config.nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) cfg.allowedUnfreePackages;
}

 