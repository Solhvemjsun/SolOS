{
  config,
  lib,
  pkgs,
  ...
}:

{
  users.users.XuLab = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "networkmanager"
    ];
  };

  home-manager.users.XuLab = {
    programs.git = {
      enable = true;
      settings.user = {
        name = "Solhvemjsun";
        email = "solhvemjsun@github.com";
      };
    };
  };
}
