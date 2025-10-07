{ config, lib, pkgs, ... }:

{
  # Shell configuration
  
  # Bash configuration (system-wide)
  programs.bash = {
    enable = true;
    enableCompletion = true;
    
    # Shell aliases available for all users
    shellAliases = {
      ll = "ls -la";
      la = "ls -A";
      l = "ls -CF";
      ".." = "cd ..";
      "..." = "cd ../..";
      
      # Git aliases
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline";
      
      # NixOS aliases
      rebuild = "sudo nixos-rebuild switch --flake .";
      update = "nix flake update";
    };
    
    # Bash initialization for all users
    shellInit = ''
      # Custom prompt
      PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    '';
  };

  # Zsh configuration (optional)
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    
    # Zsh aliases
    shellAliases = {
      ll = "ls -la";
      la = "ls -A";
      l = "ls -CF";
      ".." = "cd ..";
      "..." = "cd ../..";
      
      # Git aliases
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline";
      
      # NixOS aliases
      rebuild = "sudo nixos-rebuild switch --flake .";
      update = "nix flake update";
    };
  };
}
