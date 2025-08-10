{ config, lib, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    hmcl
    jdk8
    # retroarch
    # ruffle
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
