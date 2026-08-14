{ pkgs, ... }:

{
  ##########
  ## ICON ##
  ##########

  home.packages = with pkgs; [
    candy-icons
    sweet-folders
  ];

  ############
  ## STYLIX ##
  ############

  stylix = {
    enable = true;
    polarity = "dark";
    image = ./assets/nixos.png;
    imageScalingMode = "fill";
    cursor = {
      package = (pkgs.callPackage ./pkgs/hatsune-miku-cursors/package.nix { });
      name = "miku-cursor";
      size = 64;
    };
    icons = {
      enable = true;
      package = pkgs.sweet-folders;
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
      gnome.enable = true;
      kitty.enable = false;
      mako.enable = false;
      wofi.enable = false;
      hyprlock.enable = false;
      nixvim.enable = false;
      hyprpaper.enable = false;
    };
  };

  ##########
  ## NIRI ##
  ##########

  programs.niri.settings = {
    cursor.theme = "miku-cursor";
    spawn-at-startup = [
      {
        command = [
          "${pkgs.swaybg}/bin/swaybg"
          "-m"
          "center"
          "-i"
          "${./assets/nixos.png}"
        ];
      }
    ];
  };

  ##############
  ## hyprlock ##
  ##############

  programs.hyprlock = {
    settings = {
      general = {
        hide_cursor = true;
      };

      background = [
        {
          color = "rgb(0, 0, 0)";
        }
      ];

      input-field = {
        size = "1000, 400";
        position = "0, 0";
        monitor = "";
        dots_center = true;
        dots_size = 0.5;
        dots_text_format = "*";
        rounding = 0;
        font_color = "rgb(255, 255, 255)";
        inner_color = "rgba(0, 0, 0, 0)";
        check_color = "rgba(0, 191, 191, 0)";
        fade_on_empty = false;
        placeholder_text = "I";
        fail_text = "Authentication Failed";
        fail_timeout = "2000";
        fail_transition = "5000";
        outline_thickness = 0;
        swap_font_color = true;
      };
    };
  };

  ###############
  ## FASTFETCH ##
  ###############

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

}
