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

  nixpkgs.config.allowUnfree = true;
  
  home.stateVersion = "24.11";

  home = {
    username = name;
    homeDirectory = "/home/${config.home.username}";
  };

  #########
  ## XDG ##
  #########

  xdg = {
    userDirs = {
      enable = true;
      music = "${config.home.homeDirectory}/Nextcloud/Music";
      pictures = "${config.home.homeDirectory}/Nextcloud/Pictures";
      videos = "${config.home.homeDirectory}/Nextcloud/Videos";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      desktop = "${config.home.homeDirectory}/Desktop";
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-terminal-emulator" = ["kitty.desktop"];
      };
    };
  };

  ###########
  ## SHELL ##
  ###########

  programs.zsh = {
    enable = true;
    autocd = true;
  };

  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetch;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "display"
        "brightness"
        "sound"
        "de"
        "wm"
        "cpu"
        "gpu"
        "disk"
        "memory"
        "swap"
        "wifi"
        "bluetooth"
        "localip"
        "battery"
        "poweradapter"
        "datetime"
      ];
    };
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
