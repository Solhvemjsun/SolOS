{ lib, pkgs, ... }:

{
  stylix = {
    enable = lib.mkForce true;
    polarity = lib.mkForce "dark";
    icons = {
      enable = lib.mkForce true;
      package = lib.mkForce pkgs.adwaita-icon-theme;
      dark = lib.mkForce "Adwaita";
      light = lib.mkForce "Adwaita";
    };
    base16Scheme = lib.mkForce {
      system = "base24";
      name = "Adwaita Neutral";
      author = "szy";
      variant = "dark";
      base00 = "1e1e1e";
      base01 = "242424";
      base02 = "303030";
      base03 = "5e5e5e";
      base04 = "c0bfbc";
      base05 = "deddda";
      base06 = "f6f5f4";
      base07 = "ffffff";
      base08 = "c01c28";
      base09 = "e66100";
      base0A = "f5c211";
      base0B = "2ec27e";
      base0C = "33c7de";
      base0D = "3584e4";
      base0E = "9141ac";
      base0F = "986a44";
      base10 = "171717";
      base11 = "101010";
      base12 = "ed333b";
      base13 = "f6d32d";
      base14 = "57e389";
      base15 = "5bc8e7";
      base16 = "62a0ea";
      base17 = "c061cb";
    };
  };
  boot.plymouth.enable = lib.mkForce false;

  environment.systemPackages = with pkgs; [
    dconf-editor
    gnome-tweaks
  ];

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      source-han-sans
      source-han-serif
      sarasa-gothic
      wqy_microhei
      wqy_zenhei
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [
          "Noto Sans CJK SC"
          "Source Han Sans SC"
          "WenQuanYi Micro Hei"
        ];
        serif = [
          "Noto Serif CJK SC"
          "Source Han Serif SC"
        ];
        monospace = [
          "Sarasa Mono SC"
          "Noto Sans Mono CJK SC"
          "JetBrains Mono"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
