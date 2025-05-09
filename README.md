# SolOS

Fiat Lux!

## About

This is my NixOS configurations for multiple computers includes my server and dev boards.

## User environment

- Shell: Zsh
- WM: Hyprland

## Installation

Clone the repo and go to the folder:
```console
$ git clone https://github.com/Solhvemjsun/SolOS
$ cd SolOS
```

Edit if needed, then install with the config you need in flake.nix:
```console
$ sudo nixos-install --root /mnt --flake .#<hostName>
```

If already have installation on the device, e.g the standard aarch64 nixos on Raspberry pi:
```console
$ sudo nixos-rebuild switch --flake .#DarkSol
```

## Update

In the folder:
```console
$ make
```

For nix-on-droid app:
```console
$ nix-on-droid switch --flake .
```

## Wallpaper

### NixOS

<figure>
    <img src="./gui/hyprland/nixos.png" alt="NixOS" width=100%>
    <figcaption>
        <p>
            Classical and minimalist NixOS logo.
        </p>
    </figcaption>
</figure>
