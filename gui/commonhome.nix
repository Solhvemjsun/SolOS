{
  pkgs,
  config,
  ...
}:

{
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
        "x-terminal-emulator" = [ "kitty.desktop" ];
        "video/mp4" = "org.kde.haruna.desktop";
        "video/x-matroska" = "org.kde.haruna.desktop";
        "video/avi" = "org.kde.haruna.desktop";
      };
    };
  };

  ############
  ## STYLIX ##
  ############

  stylix = {
    enable = true;
    polarity = "dark";
    image = ../assets/nixos.png;
    imageScalingMode = "fit";
    cursor = {
      package = (pkgs.callPackage ../pkgs/hatsune-miku-cursors/package.nix { });
      name = "miku-cursor";
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
      kde.enable = false;
      kitty.enable = false;
      mako.enable = false;
      wofi.enable = false;
      hyprlock.enable = false;
      nixvim.enable = false;
      hyprpaper.enable = false;
    };
  };

  ##############
  ## Programs ##
  ##############

  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
    };
  };
}
