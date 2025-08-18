{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hmcl
    prismlauncher
    zulu8
    steam-run
    xorg.xrandr
  ];

  environment.variables = {
    JAVA_HOME = pkgs.jdk21;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

}
