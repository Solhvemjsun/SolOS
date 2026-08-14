{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet -r --theme 'button=black;action=black;'--cmd niri";
        user = "greeter";
      };
    };
  };

  imports = [ ./default.nix ];
}
