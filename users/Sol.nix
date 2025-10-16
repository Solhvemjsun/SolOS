{ ... }:

{
  users.users.Sol = {
    isNormalUser = true;
    extraGroups = [
      "input"
      "wheel"
      "audio"
      "networkmanager"
    ];
  };
}
