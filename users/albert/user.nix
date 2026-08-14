{ ... }:

{
  users.users.albert = {
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
}
