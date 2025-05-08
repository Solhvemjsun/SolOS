{ pkgs, ... }:

{
  ##########
  ## SDDM ##
  ##########

  services.xserver.enable = true; # optional
  services.displayManager.sddm = {
    enable = true;
    extraPackages = [
      pkgs.kdePackages.qt5compat
    ];
    wayland.enable = true;
    theme = "where_is_my_sddm_theme";
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
    kdePackages.bluedevil
    kdePackages.konsole
    kdePackages.okular
    where-is-my-sddm-theme
  ];

  ##################
  ## HOME MANAGER ##
  ##################

  home-manager.sharedModules = [ ./home.nix ];
}
