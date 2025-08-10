{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    any-nix-shell
    eza
    television
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

  programs.starship = {
    enable = true;
    settings = {
      format = ''
        [┌───\(](blue)[$username@$hostname](bold white)[\)-\[](blue)[$directory](bold white)[\]](blue)$all[└─](blue)$character
      '';
      character = {
        format = "$symbol ";
        success_symbol = "[\\$](bold white)";
        error_symbol = "[\\$](bold red)";
      };
      username = {
        show_always = true;
        format = "[$user]($style)";
        style_root = "bold red";
        style_user = "bold white";
      };
      hostname = {
        ssh_only = false;
        format = "[$ssh_symbol$hostname]($style)";
        style = "bold white";
      };
      directory = {
        format = "[$path]($style)[$read_only]($read_only_style)";
        style = "bold white";
        read_only = "󰌾";
        read_only_style = "green";
        truncation_length = 0;
      };
      git_status = {
        style = "bold cyan";
      };
      git_branch = {
        format = " [$symbol$branch(:$remote_branch)]($style) ";
        style = "bold cyan";
      };
      add_newline = false;
      scan_timeout = 30;
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
