{ config, lib, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    hmcl
    jdk8
    # retroarch
    ruffle
    # shadps4
    steam-run
    xorg.xrandr
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

}
