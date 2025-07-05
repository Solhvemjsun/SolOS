{ lib, pkgs, ... }:

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

    # Write Image
    isoimagewriter

    # Programming
    # Rust
    cargo
    rustc
    rust-analyzer
    rustfmt

    # C
    gcc
    clang-tools

    # Blog

    # LSP
    # pyright
    nodePackages.typescript-language-server

    # Nix
    nixfmt-rfc-style
    nil

    # Octave
    (octaveFull.withPackages (ps: with ps; [ video ]))

    # Video
    ffmpeg
    opencv

    # Art
    inkscape
    krita

    tree-sitter

    # Music
    helm
    neothesia

    # Shader
    esshader

    # PCB
    kicad
  ];
}
