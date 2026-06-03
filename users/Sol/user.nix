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
      userName = "Solhvemjsun";
      userEmail = "solhvemjsun@github.com";
    };
  };
}
