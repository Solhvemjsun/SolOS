# SolOS minimal graphical installer

The live ISO uses the NixOS GNOME Calamares image. SolOS patches the pinned
NixOS Calamares extension in two places: the desktop chooser offers Niri,
KDE Plasma and COSMIC, and the existing NixOS install job prepares a target
flake before calling `nixos-install --flake`.

The stock Calamares job still partitions and mounts the target, generates the
hardware and base NixOS configuration, and hands off password setup to its
`users` job. `prepare_target.py` copies the public SolOS source to
`/etc/nixos` on the target and places the generated configuration under
`installer/target/`. The selected desktop imports the matching
`mods/gui/*/launcher.nix`; the installed profile does not import personal
host files or all three desktop specialisations. The installed Niri profile
also drops the preset's developer-specific display names and uses a local
screenshots directory.

Build on Linux with Nix flakes enabled:

```sh
make iso
```

The ISO is under `result-iso/iso/`. After installation, update with:

```sh
sudo nixos-rebuild switch --flake /etc/nixos#SolOSInstalled
```

Current implementation targets x86_64 UEFI, ext4 and networked installation.
The upstream partitioning UI may offer additional layouts; they have not been
validated for SolOS. Offline installation is not included in this minimal
profile.

The ISO built successfully. Separate QEMU installations with 12 GiB RAM and
40 GiB disks completed for Niri, KDE Plasma and COSMIC. Each system booted from
its installed disk, accepted the selected user's password and displayed the
chosen desktop session. On the KDE installation, `nixos-rebuild switch --flake
/etc/nixos#SolOSInstalled` also completed successfully.

QEMU's 2D `virtio-vga` device left Niri with no usable renderer; with the 3D
`virtio-vga-gl` device and `egl-headless` backed by a host DRM render node,
Niri detected the virtual display and rendered a terminal window. Virtual
machine tests of Niri therefore need 3D acceleration. The KDE and COSMIC
installations were also checked with 3D acceleration.
