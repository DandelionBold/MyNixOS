{
  # ============================================================================
  # Host Tree - Defines All Hosts and Their Variants
  # ============================================================================
  # This file defines the structure of all hosts in the system.
  # 
  # Structure:
  # hostName = [ "variant1" "variant2" ... ];
  #
  # - If a host has NO variants, use empty list: []
  # - If a host has variants, list them: [ "personal" "work" ]
  #
  # Variants are located in: hosts/<hostName>/<variantName>/
  # Base configs are located in: hosts/<hostName>/default.nix
  #
  # Build commands:
  # - Base:    nixos-rebuild switch --flake .#laptop
  # - Variant: nixos-rebuild switch --flake .#laptop@personal
  # ============================================================================

  hostTree = {
    # Laptop configurations
    laptop = [ "personal" ];
    
    # Desktop configurations  
    desktop = [ ];
    
    # Server configurations
    server = [ ];
    
    # Virtual machine configurations
    vm = [ "personal" ];
    
    # WSL (Windows Subsystem for Linux) configurations
    wsl = [ ];
    
    # Cloud server configurations
    cloud = [ ];
    
    # Add more hosts here following the same pattern
  };
}
