{
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
      setSessionVariables = true;
      music = "${config.home.homeDirectory}/Nextcloud/Music";
      pictures = "${config.home.homeDirectory}/Nextcloud/Pictures";
      videos = "${config.home.homeDirectory}/Nextcloud/Videos";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      desktop = "${config.home.homeDirectory}/Desktop";
    };
  };

  ############
  ## STYLIX ##
  ############

  stylix = {
    enable = true;
    targets = {
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
