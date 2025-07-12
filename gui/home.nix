{ config, name, lib, pkgs, ... }:

{
  ##########
  ## HOME ##
  ##########

  home = {
    stateVersion = "24.05";
    username = lib.mkDefault name;
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    packages = with pkgs; [
      any-nix-shell
    ];
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

  # programs.git = {
  #   enable = true;
  #   userName = "Solhvemjsun";
  #   userEmail = "solhvemjsun@gmail.com";
  # };

}
