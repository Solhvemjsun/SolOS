{ pkgs, ... }:

{
  ###########
  ## SHELL ##
  ###########

  programs.starship = {
    enable = true;
    settings = {
      format = ''
        [┌───\(](blue)[$username@$hostname](bold white)[\)-\[](blue)[$directory](bold white)[\]](blue)$all[└─](blue)$character
      '';
      character = {
        format = "$symbol ";
        success_symbol = "[\\$](bold white)";
        error_symbol = "[\\$](bold red)";
      };
      username = {
        show_always = true;
        format = "[$user]($style)";
        style_root = "bold red";
        style_user = "bold white";
      };
      hostname = {
        ssh_only = false;
        format = "[$ssh_symbol$hostname]($style)";
        style = "bold white";
      };
      directory = {
        format = "[$path]($style)[$read_only]($read_only_style)";
        style = "bold white";
        read_only = "󰌾";
        read_only_style = "green";
        truncation_length = 0;
      };
      git_status = {
        style = "bold cyan";
      };
      git_branch = {
        format = " [$symbol$branch(:$remote_branch)]($style) ";
        style = "bold cyan";
      };
      add_newline = false;
      scan_timeout = 30;
    };
  };

  ##########
  ## YAZI ##
  ##########

  programs.yazi.settings.yazi.mgr.ratio = [
    1
    3
    4
  ];

  ##############
  ## LAUNCHER ##
  ##############

  programs.regreet.settings = {
    background = {
      path = "./assets/nixos.png";
      fit = "Cover";
      GTK = {
        application_prefer_dark_theme = true;
        font_name = "Noto Sans 11";
        theme_name = "Adwaita-dark";
      };
    };
  };

  ##########
  ## SDDM ##
  ##########

  environment.systemPackages = with pkgs; [
    (where-is-my-sddm-theme.override {
      themeConfig.General = {
        showSessionsByDefault = true;
      };
    })
  ];

  services.displayManager.sddm = {
    theme = "where_is_my_sddm_theme";
  };

  ############
  ## STYLIX ##
  ############

  stylix = {
    enable = true;
    targets = {
      grub.enable = false;
      nixvim.enable = false;
      plymouth.enable = false;
      fish.enable = false;
      kmscon.enable = false;

      regreet = {
        image.enable = true;
        imageScalingMode.enable = true;
        polarity.enable = true;
      };
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
  };

}
