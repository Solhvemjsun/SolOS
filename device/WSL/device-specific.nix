{ ... }:

{
  # https://nix-community.github.io/NixOS-WSL/options.html

  networking.hostName = "SolOS_WSL";
  wsl ={
    defaultUser = "Sol";
    startMenuLaunchers = true;
    # usbip.enable = true;
    useWindowsDriver = true;
  };
}
