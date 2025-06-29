{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # wine 64bit version
    wine64

    # winetricks (all versions)
    winetricks

    # native wayland support (unstable)
    wineWowPackages.waylandFull
  ];
}
