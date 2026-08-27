{ pkgs, ... }:

{
  ################
  ## BOOTLOADER ##
  ################

  boot = {
    loader.grub = {
      gfxmodeEfi = "1920x1080";
      minegrub-theme = {
        enable = true;
        splash = "Fiat Lux!";
        boot-options-count = 7;
      };
    };

    plymouth = {
      enable = true;
      theme = "green_blocks";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override { selected_themes = [ "green_blocks" ]; })
      ];
    };
  };
}
