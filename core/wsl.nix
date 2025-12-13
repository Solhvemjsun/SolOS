{ pkgs, ... }:

{
  wsl = {
    enable = true;
    defaultUser = "Sol";
    startMenuLaunchers = true;
    interop.register = true;
    wslConf = {
      network.hostname = "SolOS-WSL";
    };
    # useWindowsDriver = true;
  };
  networking.hostName = "SolOS-WSL";
  home-manager.sharedModules = [
    { home.sessionVariables = {BROWSER = "wslview"; }; }
  ];
}
