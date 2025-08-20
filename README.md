# SolOS

Fiat Lux!

## About

This is my NixOS configurations for multiple computers includes user space, server and dev boards.

For now, I'm trying to combine the blazing fast & smooth experience of window managers and the power of BMI EEG sensor, to cover all the basic operations in OS interaction, Gaming and even more.

## Default System & Desktop environment

- System & Kernel: NixOS & Linux Zen
- Terminal: Kitty & Fish
- Window Manager: Niri & Astal shell
- App Launcher: Fuzzel
- Editor: Nixvim & Code

## Installation

1. Download & install [NixOS](https://nixos.org/download/) on your machine, minimal ISO image preferred if you are familliar with linux CLI

2. Clone this and get in the repo:
```console
$ git clone https://github.com/Solhvemjsun/SolOS
$ cd SolOS
```

3. Copy the template folder in /devices for your device, user, and cusomization settings
```console
$ cp -r ./devices//template ./devices/<hostName>
$ cp /etc/nixos/hardware-configuration.nix ./devices/<hostName>/hardware-configuration.nix
```

4. Add the entry of your device with the required modules in the flake.nix using the simmilar format as other entries
```console
$ nvim fake.nix
```

5. Switch to the SolOS config
```console
$ sudo nixos-rebuild switch --flake .#DarkSol
```

6. Or install with the config you need in flake.nix:
```console
$ sudo nixos-install --root /mnt --flake .#<hostName>
```

## Update

```console
$ cd SolOS
$ make
```

For nix-on-droid app:
```console
$ cd SolOS
$ nix-on-droid switch --flake .
```

## Wallpaper

### NixOS

<figure>
    <img src="./assets/nixos.png" alt="NixOS" width=100%>
    <figcaption>
        <p>
            Classical and minimalist NixOS logo.
        </p>
    </figcaption>
</figure>

## Future steps

### Brain-Machine-Interface

OpenBCI interaction for niri window manager

### EZ deploy & use

Clear structure and i18n documentation;

Modularize, multiple DE/WM support, customization modules;

### Blackhole Wallpaper

Use Real-time-simulated Blackhole as wallpaper
