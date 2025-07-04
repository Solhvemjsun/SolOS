{
  lib,
  pkgs,
  ...
}:

{
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
    candy-icons
    gamescope
    hyprpaper
    imv
    kdePackages.polkit-kde-agent-1
    light
    mako
    pamixer
    playerctl
    seahorse
    selectdefaultapplication
    slurp
    waybar
    wayvnc
    wl-screenrec
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
}
