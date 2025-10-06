{ config, lib, pkgs, ... }:

{
  # IDEs and development editors (excluding VSCode)
  environment.systemPackages = with pkgs; [
    # JetBrains IDEs
    jetbrains.idea-community
    jetbrains.pycharm-community
    jetbrains.webstorm
    jetbrains.clion
    jetbrains.goland
    
    # Other IDEs
    eclipse-jee
    netbeans
    
    # Advanced text editors
    neovim
    emacs
    sublime4
    
    # Database tools
    dbeaver
    mysql-workbench
    
    # API testing
    postman
    insomnia
    
    # Version control GUI
    gitkraken
    sourcetree
    
    # Docker GUI
    docker-compose
    lazydocker
  ];
}
