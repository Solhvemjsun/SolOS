{
  lib,
  pkgs,
  ...
}:

{
  ####################
  ## PLASMA MANAGER ##
  ####################

  home-manager.sharedModules = [ ./home.nix ];

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
    shared-mime-info
    kdePackages.kdegraphics-thumbnailers
    kdePackages.kio-extras
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
    kdePackages.kdeconnect-kde
    kdePackages.yakuake

    # Other tools
    kdePackages.partitionmanager
    kdePackages.plasma-systemmonitor
    kdePackages.plasma-browser-integration
  ];

  programs.kdeconnect.enable = true;
}
