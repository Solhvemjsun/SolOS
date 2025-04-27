{
  home-manager.users.Sol = {
    import ../hyprland/home.nix;
    extraSpecialArgs = { username = "Sol"; };
    backupFileExtension = "backup";
  };
}
