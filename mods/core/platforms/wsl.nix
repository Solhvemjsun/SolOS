{ pkgs, ... }:

{
  wsl = {
    enable = true;
    defaultUser = "blux";
    startMenuLaunchers = true;
    interop.register = true;
    wslConf = {
      network.hostname = "bluxos-wsl";
    };
    # useWindowsDriver = true;
  };
  networking.hostName = "bluxos-wsl";
  home-manager.sharedModules = [
    { 
      home.sessionVariables = {
        BROWSER = "wslview";
        QT_QPA_PLATFORM = "xcb";
      };
    }
  ];
}
