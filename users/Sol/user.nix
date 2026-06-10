{ ... }:

{
  users.users.Sol = {
    isNormalUser = true;
    extraGroups = [
      "i2c" # OpenRGB
      "input"
      "wheel"
      "dialout"
      "audio"
      "networkmanager"
    ];
  };

  home-manager.users.Sol = {
    programs.git = {
      enable = true;
      settings.user = {
        name = "Solhvemjsun";
        email = "solhvemjsun@github.com";
      };
    };
  };
}
