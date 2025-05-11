{ config, lib, pkgs, ... }:

{
  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  time.timeZone = "America/Los_Angeles";

  environment = {
    motd = ''
      Fiat Nix!
    '';
    etcBackupExtension = ".bak"; 
    packages = with pkgs; [
      vim
      zsh
      nyancat
      neovim
      git
      gnumake
      openssh
      fastfetch
      aircrack-ng
      any-nix-shell

      #procps
      #killall
      #diffutils
      #findutils
      #utillinux
      #tzdata
      #hostname
      #man
      #gnugrep
      #gnupg
      #gnused
      #gnutar
      #bzip2
      #gzip
      #xz
      #zip
      #unzip
    ];
  };

  user.shell = "${pkgs.zsh}/bin/zsh";

  home-manager = {
    config = { pkgs, ... }:
    {
      imports = [
        ./home.nix
        ../terminal/nixvim.nix
      ];
    };
    backupFileExtension = "backup";
    useGlobalPkgs = true;
  };

}
