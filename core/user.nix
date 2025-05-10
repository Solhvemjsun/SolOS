{ config, name, ... }:

{
  home-manager.sharedModules = [
    ./home.nix
    {  
      home = {
        username = name;
        homeDirectory = "/home/${config.home.username}";
      };
    }
  ];
}
