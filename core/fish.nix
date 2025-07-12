{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    any-nix-shell
    eza
    television
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';
    shellAliases = {
      ll = "eza";
      tree = "eza -T";
      clock = "tty-clock -s -c -C 6 -t ";
      cd = "z";
    };
  };

  programs.starship = {
    enable = true;
    # transientPrompt = {
    #   enable = true;
    #   left = "";
    #   right = "";
    # };
    # settings = { };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
