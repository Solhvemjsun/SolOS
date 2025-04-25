{ pkgs, ...}:

{
  users.users.Sol = { extraGroups = [ "openrazer" ]; };

  hardware.openrazer.enable = true;

  environment.systemPackages = with pkgs; [
    openrazer-daemon
    polychromatic
  ];
}
