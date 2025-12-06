{ pkgs, ... }:

{
  ###############
  ## EMULATION ##
  ###############

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  #############
  ## PACKAGE ##
  #############

  environment.systemPackages = with pkgs; [
    # Management
    github-desktop
    conda

    # Programming
    # Rust
    cargo
    rustc
    rust-analyzer
    rustfmt

    # LSP
    # pyright
    # nodePackages.typescript-language-server

    # Nix
    nixfmt-rfc-style
    nil

    # Octave
    # (octaveFull.withPackages (ps: with ps; [ video ]))

    # Video
    ffmpeg
    opencv

    # Art
    inkscape
    krita
    shotcut
    tree-sitter

    # Music
    helm
    ardour

    # Develop
    kicad
    blender
  ];
}
