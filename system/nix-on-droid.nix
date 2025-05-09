{ config, lib, pkgs, ... }:

{
  # packages
  # environment.packages = with pkgs; [
  #   vim
  # ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";
  home-manager.config = { config, lib, pkgs, ... }:
  {
    home.stateVersion = "24.05";
  };
}
