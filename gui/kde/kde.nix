{ pkgs, ... }:

{
  ##########
  ## SDDM ##
  ##########

  services.xserver.enable = true; # optional
  services.displayManager = {
    defaultSession = "plasma";
    sddm = {
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
    kdePackages.okular
    where-is-my-sddm-theme

    kdePackages.kdeApplications

    kdePackages.plasma-workspace
    kdePackages.plasma-desktop
    kdePackages.plasma-integration
    kdePackages.kdeplasma-addons
    kdePackages.kwallet-pam
    kdePackages.knewstuff
    kdePackages.sddm-kcm

    # Common apps
    kdePackages.dolphin
    kdePackages.kate
    kdePackages.konsole
    kdePackages.ark
    kdePackages.gwenview
    kdePackages.okular
    kdePackages.spectacle
    kdePackages.kcalc
    kdePackages.filelight
    kdePackages.kdenlive
    kdePackages.kdeconnect-kde

    # Other tools
    kdePackages.partitionmanager
    kdePackages.plasma-systemmonitor
    kdePackages.plasma-browser-integration
  ];

  programs.kdeconnect.enable = true;

  ##################
  ## HOME MANAGER ##
  ##################

  # home-manager.sharedModules = [ ./home.nix ];
}
