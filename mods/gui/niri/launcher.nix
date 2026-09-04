{ pkgs, ... }:

{
  services.displayManager.regreet = {
    enable = true;
    settings = {
      #   commands = {
      #     reboot = [
      #       "systemctl"
      #       "reboot"
      #     ];
      #     poweroff = [
      #       "systemctl"
      #       "poweroff"
      #     ];
      #   };
    };
  };

  services.displayManager.sessionPackages = [ pkgs.niri ];

  imports = [ ./default.nix ];
}
