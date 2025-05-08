{ pkgs, ... }:

{
  ##########
  ## GRUB ##
  ##########

  boot = {
    loader.grub = {
      useOSProber = true;
      gfxmodeEfi = "1920x1080";
      minegrub-theme = {
        enable = true;
        splash = "Fiat Lux!";
        boot-options-count = 7;
      };
    };
    
    plymouth = {
      enable = true;
      theme = "dna";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "dna" ];
        })
      ];
    };

    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    supportedFilesystems = [ "ntfs" ];
  };

  ##############
  ## PACKAGES ##
  ##############

  environment.systemPackages = with pkgs; [
    amberol
    udiskie
    firefox
    gparted
    google-chrome
    haruna
    kiwix
    libsForQt5.kamoso
    mediainfo-gui
    neovide
    nextcloud-client
    nautilus
    nautilus-open-any-terminal
    ntfs3g
    onlyoffice-desktopeditors
    kdePackages.okular
    remmina
    samba
  ];

  #############
  ## FLATPAK ##
  #############

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  ##################
  ## INPUT METHOD ##
  ##################

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-rime
      fcitx5-mozc
      rime-ls
      rime-data
      rime-zhwiki
      rime-japanese
    ];
  };

}

