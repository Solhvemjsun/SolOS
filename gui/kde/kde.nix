{ pkgs, ... }:

{
  ##########
  ## SDDM ##
  ##########

  services.xserver.enable = true; # optional
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    settings = {
      General.DisplayServer = "wayland";
    };
  };

  ##############
  ## PLASMA 6 ##
  ##############

  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
  ];

  ##############
  ## PACKAGES ##
  ##############

  environment.systemPackages = with pkgs; [
    kdePackages.okular
  ];
}
