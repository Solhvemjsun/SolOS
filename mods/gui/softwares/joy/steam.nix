{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    steam-run
    xrandr
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

}
