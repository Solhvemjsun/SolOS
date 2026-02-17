{ ... }:

{
  users.users.Sol = {
    isNormalUser = true;
    extraGroups = [
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
