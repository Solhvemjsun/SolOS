{ pkgs, lib, config, ... }:

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
    # mimeApps = {
    #   enable = true;
    #   defaultApplications = {
    #     "x-terminal-emulator" = ["kitty.desktop"];
    #   };
    # };
  };
}
