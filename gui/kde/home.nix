{ config, pkgs, lib, name, ... }:

{
  ##########
  ## HOME ##
  ##########

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
    # mimeApps = {
    #   enable = true;
    #   defaultApplications = {
    #     "x-terminal-emulator" = ["kitty.desktop"];
    #   };
    # };
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

  ############
  ## STYLIX ##
  ############

  stylix = {
    enable = false;
    polarity = "dark";
    image = ./nixos.png;
    imageScalingMode = "fit";
    cursor = {
      package = (pkgs.callPackage ../../pkgs/breeze-hacked-cursor-theme-hyprcursor/package.nix {});
      name = "Breeze_Hacked";
      size = 64;
    };
    iconTheme = {
      enable = true;
      dark = "Sweet-Rainbow";
      light = "Sweet-Rainbow";
    };
    base16Scheme = {
      system = "base24";
      name = "Eclipse";
      author = "Sol";
      variant = "dark";
      base00 = "000000";
      base01 = "131313";
      base02 = "2a3141";
      base03 = "343d50";
      base04 = "d6dae4";
      base05 = "c1c8d7";
      base06 = "e3e6ed";
      base07 = "ffffff";
      base08 = "f71118";
      base09 = "ecb90f";
      base0A = "0f80d5";
      base0B = "2cc55d";
      base0C = "0f80d5";
      base0D = "2a84d2";
      base0E = "4e59b7";
      base0F = "7b080c";
      base10 = "0a0a0a";
      base11 = "060606";
      base12 = "ff0000";
      base13 = "ffff00";
      base14 = "00ff00";
      base15 = "00ffff";
      base16 = "0000ff";
      base17 = "ff00ff";
    };
    targets = {
      kitty.enable = false;
      mako.enable = false;
      wofi.enable = false;
      hyprland.enable = false;
      hyprlock.enable = false;
      nixvim.enable = false;
    };
  };

}
