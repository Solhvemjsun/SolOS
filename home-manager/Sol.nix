{
  home-manager = {
    extraSpecialArgs = { username = "Sol"; };
    backupFileExtension = "backup";
  };
  home-manager.users.Sol = import ./hyprland/home.nix;
}
