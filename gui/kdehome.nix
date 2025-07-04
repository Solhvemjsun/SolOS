{ config, pkgs, name, ... }:

{
  ##########
  ## HOME ##
  ##########

  programs.plasma = {
    enable = true;
    # workspace = {
    #   wallpaper = {
    #     picture = "nixos.png";
    #   };
    # };
  };

  programs.okular.enable = true;

  home = {
    username = name;
    homeDirectory = "/home/${config.home.username}";
  };

  ###########
  ## SHELL ##
  ###########

  programs.zsh = {
    enable = true;
    autocd = true;
  };

  programs.ranger = {
    enable = true;
    extraPackages = [ pkgs.ueberzugpp ];
    settings = {
      show_hidden = true;
      preview_images_method = "ueberzug";
    };
  };

  #############
  ## DEVELOP ##
  #############

  programs.git = {
    enable = true;
    userName = "Solhvemjsun";
    userEmail = "solhvemjsun@gmail.com";
  };

}
