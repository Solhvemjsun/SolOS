{ ... }:

{
  home-manager.users.albert = {
    imports = [
      ../../mods/themes/darksol/homewide.nix
    ];

    programs.git = {
      enable = false;
      settings.user = {
        name = "Albertyogur";
        email = "Albertyogur@gmail.com";
      };
    };

    services.nextcloud-client = {
      enable = true;
      startInBackground = true;
    };
  };
}
