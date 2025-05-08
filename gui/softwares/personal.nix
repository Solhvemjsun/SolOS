{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    clash-verge-rev
    discord
    element-desktop
    nextcloud-talk-desktop
    qq
    telegram-desktop
  ];

  home-manager.sharedModules = [
    {
      services.nextcloud-client = {
        enable = true;
        startInBackground = true;
      };
    }
  ];
}
