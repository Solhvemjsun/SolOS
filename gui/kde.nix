{ pkgs, plasma-manager, ... }:

{
  ##########
  ## SDDM ##
  ##########

  # services.xserver.enable = true; # optional

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

    kdePackages.plasma-workspace
    kdePackages.plasma-desktop
    kdePackages.plasma-integration
    kdePackages.kdeplasma-addons
    kdePackages.kwallet-pam
    kdePackages.kmenuedit
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
    kdePackages.yakuake

    # Other tools
    kdePackages.partitionmanager
    kdePackages.plasma-systemmonitor
    kdePackages.plasma-browser-integration
  ];

  programs.kdeconnect.enable = true;

  ##################
  ## HOME MANAGER ##
  ##################

  home-manager.sharedModules = [ ./kdehome.nix ];
}
