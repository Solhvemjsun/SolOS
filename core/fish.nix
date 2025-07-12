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
    settings = {
      format = ''
        [┌───\(](bold blue)[$username$hostname](bold white)[\)-\[](bold blue)[$directory](bold white)[\]](bold blue)
        [└─](bold blue)[\$](bold white)
      '';
      # format = ''
      #   [┌───────────────────(](bold green)
      #   [│](bold green)$directory$rust$package
      #   [└─\$](bold green) '';
      add_newline = false;
      scan_timeout = 30;
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
