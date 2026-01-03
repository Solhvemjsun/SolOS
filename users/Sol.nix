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
}
