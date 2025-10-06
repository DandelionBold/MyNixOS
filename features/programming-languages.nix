{ config, lib, pkgs, ... }:

{
  # Programming languages and toolchains
  environment.systemPackages = with pkgs; [
    # Python toolchain
    python3
    python3Packages.pip
    python3Packages.setuptools
    python3Packages.wheel
    
    # Add more languages here as needed
    # nodejs
    # go
    # rust
    # java
  ];
}
