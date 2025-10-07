{ config, lib, pkgs, ... }:

with lib;

let
  # Import the users list from nixos-settings
  usersData = import ../nixos-settings/usersList.nix { inherit pkgs; };
  usersList = usersData.usersList;
  
  # Get selected users from host configuration (default to empty list)
  selectedUsers = config.system.selectedUsers or [];
  
  # Filter users based on selection
  enabledUsers = filter (user: elem user.username selectedUsers) usersList;
  
  # Helper to convert user data to NixOS user config
  toNixOSUser = user: {
    name = user.username;
    value = {
      isNormalUser = user.isNormalUser;
      description = user.description or user.username;
      extraGroups = user.extraGroups;
      shell = user.shell;
      home = user.homeDirectory;
    };
  };
  
in
{
  # ============================================================================
  # Users Manager - Dynamic User Creation
  # ============================================================================
  # This module:
  # 1. Reads usersList from nixos-settings/usersList.nix
  # 2. Reads selectedUsers from host configuration
  # 3. Creates NixOS system users for selected users
  # 4. Generates Home Manager configurations for selected users
  #
  # Usage in host config:
  #   system.selectedUsers = [ "casper" "koko" ];
  # ============================================================================

  options.system.selectedUsers = mkOption {
    type = types.listOf types.str;
    default = [];
    description = ''
      List of usernames to enable on this host.
      Users must be defined in nixos-settings/usersList.nix
    '';
    example = [ "casper" "koko" ];
  };

  config = mkIf (length selectedUsers > 0) {
    # Create NixOS system users for all selected users
    users.users = listToAttrs (map toNixOSUser enabledUsers);
    
    # Enable zsh if any user uses it
    programs.zsh.enable = mkIf 
      (any (user: user.shell == pkgs.zsh) enabledUsers) 
      true;
    
    # Enable bash (always, it's the default)
    programs.bash.enable = true;
  };
}
