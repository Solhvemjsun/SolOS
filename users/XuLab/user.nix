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
      userName = "Solhvemjsun";
      userEmail = "solhvemjsun@github.com";
    };
  };
}
