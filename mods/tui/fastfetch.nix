{ pkgs, ... }:

{
  home-manager.sharedModules = [
    {
      programs.fastfetch = {
        enable = true;
        package = pkgs.fastfetch;
        settings = {
          "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
          modules = [
            "title"
            "separator"
            "os"
            "host"
            "kernel"
            "uptime"
            "packages"
            "display"
            "brightness"
            "sound"
            "de"
            "wm"
            "cpu"
            "gpu"
            "disk"
            "memory"
            "swap"
            "wifi"
            "bluetooth"
            "localip"
            "battery"
            "poweradapter"
            "datetime"
          ];
        };
      };
    }
  ];
}
