{
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    any-nix-shell
    eza
    tty-clock
  ];
  users.defaultUserShell = lib.mkForce pkgs.fish;
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      set fish_greeting ""
    '';
    shellAliases = {
      ll = "eza";
      tree = "eza -T";
      clock = "tty-clock -s -c -C 6 -t ";
      cd = "z";
    };
  };

  programs.direnv = {
    enable = true;
    silent = false;
    loadInNixShell = true;
    nix-direnv.enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
