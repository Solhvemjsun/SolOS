{ ... }:

{
  # https://nix-community.github.io/NixOS-WSL/options.html

  networking.hostName = "SolOS";
  wsl ={
    defaultUser = "Sol";
    startMenuLaunchers = true;
    # usbip.enable = true;
    useWindowsDriver = true;
    wslConf = {
      boot.command = "fastfetch";
      network.hostName = "SolOS";
    };

  };
}
