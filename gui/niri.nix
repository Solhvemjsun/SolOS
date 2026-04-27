{
  pkgs,
  ...
}:

{
  #############
  ## GREETER ##
  #############

  services.displayManager.defaultSession = "niri";

  ##################
  ## HOME MANAGER ##
  ##################

  home-manager.sharedModules = [
    ./nirihome.nix
  ];

  ##############
  ## PACKAGES ##
  ##############

  # nixpkgs.overlays = [ niri.overlays.niri ];
  environment.systemPackages = with pkgs; [
    brightnessctl
    gamescope
    grim
    imv
    kdePackages.polkit-kde-agent-1
    mako
    nautilus
    networkmanagerapplet
    pamixer
    pavucontrol
    playerctl
    seahorse
    selectdefaultapplication
    slurp
    swaybg
    wl-clipboard-rs
    xwayland-satellite
    zathura
  ];

  ##########
  ## NIRI ##
  ##########

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  ################
  ## SCREENCAST ##
  ################

  security.rtkit.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
    ];
    config.common.default = "*";
  };

}
