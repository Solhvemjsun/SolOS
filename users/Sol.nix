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

  #############
  ## DEVELOP ##
  #############

  # programs.git = {
  #   enable = true;
  #   userName = "Solhvemjsun";
  #   userEmail = "solhvemjsun@gmail.com";
  # };

}
