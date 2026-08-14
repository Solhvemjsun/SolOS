{ ... }:

{
  home-manager.users.Sol = {

    imports = [
      ../../mods/themes/darksol/homewide.nix
    ];
    programs.git = {
      enable = false;
      settings.user = {
        name = "Solhvemjsun";
        email = "solhvemjsun@gmail.com";
      };
    };

    services.nextcloud-client = {
      enable = true;
      startInBackground = true;
    };

    xdg = {
      userDirs = {
        enable = true;
        setSessionVariables = true;
        music = "/home/sol/Nextcloud/Music";
        pictures = "/home/sol/Nextcloud/Pictures";
        videos = "/home/sol/Nextcloud/Videos";
        documents = "/home/sol/Documents";
        download = "/home/sol/Downloads";
        desktop = "/home/sol/Desktop";
      };
    };
  };
}
