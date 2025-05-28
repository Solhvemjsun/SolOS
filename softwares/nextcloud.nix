{ pkgs, ... }:

{
  home-manager.sharedModules = [
    {
      services.nextcloud-client = {
        enable = true;
        startInBackground = true;
      };
    }
  ];
}
