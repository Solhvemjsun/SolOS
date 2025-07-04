{
  config,
  pkgs,
  name,
  ...
}:

{
  programs.plasma = {
    enable = true;

    ###########
    ## THEME ##
    ###########

    workspace = {
      clickItemTo = "open";
      lookAndFeel = "org.kde.breezedark.desktop"; # The Plasma Global Theme. Run `plasma-apply-lookandfeel --list` for valid options.
      cursor = {
        theme = "miku-cursor";
        size = 64;
      };
      iconTheme = "Sweet-Rainbow";
      # wallpaper = "";
    };

    #############
    ## HOTKEYS ##
    #############

    hotkeys.commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Meta+T";
      command = "konsole";
    };

    shortcuts = {
      ksmserver = {
        "Lock Session" = [
          "Screensaver"
          "Meta+Ctrl+Alt+L"
        ];
      };

      kwin = {
        "Expose" = "Meta+,";
        "Switch Window Down" = "Meta+S";
        "Switch Window Left" = "Meta+A";
        "Switch Window Right" = "Meta+D";
        "Switch Window Up" = "Meta+W";
      };
    };

  };

}
