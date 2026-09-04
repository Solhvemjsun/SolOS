{
  description = "NixOS based OS for delivering stable development and research enviroment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    nixos-avf.url = "github:nix-community/nixos-avf/trunk";
    nixos-avf.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
    minegrub-theme.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";

    nixos-vscode-server.url = "github:nix-community/nixos-vscode-server";
    nixos-vscode-server.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";

    astal-shell.url = "github:knoopx/astal-shell";
    astal-shell.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nix-minecraft.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-parts,
      nixos-wsl,
      home-manager,
      minegrub-theme,
      nixvim,
      nixos-vscode-server,
      stylix,
      niri,
      astal-shell,
      plasma-manager,
      nix-minecraft,
      ...
    }:
    let
      coreModules = [
        ./mods/core/platforms/nixos.nix
        ./mods/core/locales/california/timezone.nix
        ./mods/core/nix/default.nix
        ./mods/core/drivers/network/networkmanager.nix
      ];
      tuiModules = coreModules ++ [
        stylix.nixosModules.stylix
        nixvim.nixosModules.nixvim
        ./mods/softwares/shell/fish.nix
        ./mods/softwares/filemanager/yazi.nix
        ./mods/softwares/tui/softwares.nix
        ./mods/softwares/develop/git.nix
        ./mods/softwares/develop/nixvim.nix
      ];
      guiModules = tuiModules ++ [
        minegrub-theme.nixosModules.default
        home-manager.nixosModules.home-manager
        ./mods/core/homemanager/default.nix
        ./mods/gui/common.nix
        ./mods/core/drivers/filesystems/ntfs.nix
      ];
      kdeDesktop = [
        { home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ]; }
        ./mods/gui/kde/specialisation.nix
      ];
      gnomeDesktop = [
        ./mods/gui/gnome/specialization.nix
      ];
      niriDesktop = [
        ./mods/gui/niri/specialisation.nix
        {
          nixpkgs.overlays = [
            niri.overlays.niri
            astal-shell.overlays.default
          ];
          home-manager.sharedModules = [
            niri.homeModules.niri
            astal-shell.homeManagerModules.default
          ];
        }
      ];
      chinaModules = [
        ./mods/core/locales/china/timezone.nix
        ./mods/core/locales/china/mirrors.nix
      ];
      basicSoftwares = [
        ./mods/softwares/streaming/obs.nix
        ./mods/softwares/internet/chat.nix
        ./mods/softwares/office/collabora.nix
        ./mods/softwares/internet/firefox.nix
        ./mods/softwares/net/remote.nix
      ];
      createSoftwares = basicSoftwares ++ [
        ./mods/softwares/art/drawing.nix
        ./mods/softwares/art/music.nix
        ./mods/softwares/art/video.nix
        ./mods/softwares/engineering/blender.nix
        ./mods/softwares/engineering/pcb.nix
        ./mods/softwares/develop/godot.nix
      ];
      personalSoftwares = createSoftwares ++ [
        ./mods/softwares/internet/spotify.nix
        ./mods/softwares/gaming/minecraft.nix
        ./mods/softwares/gaming/steam.nix
      ];
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      flake = {
        nixosConfigurations = {
          "SolXPS26" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules =
              guiModules
              ++ niriDesktop
              ++ kdeDesktop
              ++ createSoftwares
              ++ personalSoftwares
              ++ [
                ./hosts/SolXPS26/device-specific.nix
                ./users/Sol/user.nix
                ./users/Sol/home.nix
                ./mods/core/drivers/usb/bolt.nix
                ./mods/core/drivers/firmwares/closed.nix
                ./mods/core/drivers/filesystems/ntfs.nix
                ./mods/core/drivers/zramswap/default.nix
                ./mods/gui/niri/launcher.nix
                ./mods/themes/darksol/oswide.nix
                ./mods/themes/darksol/launcher.nix
                ./mods/services/tailscale/default.nix
                ./mods/softwares/net/clash.nix
              ];
          };

          "SolZ13" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules =
              guiModules
              ++ niriDesktop
              ++ kdeDesktop
              ++ gnomeDesktop
              ++ createSoftwares
              ++ personalSoftwares
              ++ [
                ./hosts/ROG_Z13/device-specific.nix
                ./users/Sol/user.nix
                ./users/Sol/home.nix
                ./mods/core/drivers/amdgpu/amdgpu.nix
                ./mods/core/drivers/usb/bolt.nix
                ./mods/core/drivers/firmwares/closed.nix
                ./mods/core/drivers/filesystems/ntfs.nix
                ./mods/gui/niri/launcher.nix
                ./mods/themes/darksol/oswide.nix
                ./mods/themes/darksol/launcher.nix
                ./mods/services/tailscale/default.nix
                ./mods/softwares/net/clash.nix
              ];
          };

          # Meshless AIO ITX at Irvine
          "SolITX" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules =
              guiModules # Basic modules for gui system
              ++ niriDesktop # Scrolling desktop enviroment
              ++ kdeDesktop # Windows-like desktop enviroment
              ++ gnomeDesktop # MacOS-like desktop environment
              ++ createSoftwares # Softwares for work
              ++ personalSoftwares # All default softwares enabled
              ++ [
                ./hosts/SolITX/device-specific.nix # Hardware configurations
                ./users/Sol/user.nix # Create the user named Sol
                ./users/Sol/home.nix # Home-manager settings for Sol
                ./mods/core/kernels/linux-zen.nix # High-performance core for Desktop
                ./mods/gui/niri/launcher.nix # Choose Niri as the default user interface
                ./mods/themes/darksol/oswide.nix # Global theme by Sol
                ./mods/themes/darksol/launcher.nix
                ./mods/core/drivers/nvidia/nvidia.nix # So Nvidia, Fuck You
                ./mods/core/drivers/usb/bolt.nix # USB4 driver
                ./mods/core/drivers/firmwares/closed.nix # Enable close-sourced firmwares
                ./mods/core/drivers/filesystems/ntfs.nix # Compatiable for windows file system
                ./mods/softwares/virtualize/waydroid.nix # Android simulator
                ./mods/services/tailscale/default.nix # Virtual local network
              ];
          };

          # Sol's server
          "SolBase" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules =
              guiModules
              ++ niriDesktop
              ++ [
                nix-minecraft.nixosModules.minecraft-servers
                { nixpkgs.overlays = [ nix-minecraft.overlay ]; }
                ./hosts/SolBase/device-specific.nix
                ./users/Sol/user.nix
                ./users/Sol/home.nix
                ./mods/gui/niri/launcher.nix
                ./mods/themes/darksol/oswide.nix
                ./mods/themes/darksol/launcher.nix
                ./mods/softwares/internet/firefox.nix
                ./mods/services/SolOS_Private/miniserver.nix
                ./mods/services/SolOS_Private/sayuki/zeroclaw.nix
                ./mods/services/ssh/default.nix
                ./mods/services/minecraft/nix-minecraft.nix
                ./mods/services/minecraft/mcbugus.nix
                ./mods/services/tailscale/default.nix
              ];
          };

          # Raspberry Pi
          "solpi" = nixpkgs.lib.nixosSystem {
            system = "aarch64-linux";
            modules = tuiModules ++ [
              ./hosts/bluxpi/device-specific.nix
              ./users/blux/user.nix
              ./mods/core/platforms/rpi4.nix
              ./mods/services/ssh.nix
            ];
          };

          # Windows Subsystem Linux
          "SolOS-WSL" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = tuiModules ++ [
              nixos-wsl.nixosModules.default
              home-manager.nixosModules.home-manager
              ./users/Sol/user.nix
              ./mods/core/platforms/wsl.nix
              ./mods/themes/darksol/oswide.nix
            ];
          };

          # Old Version configs, to be immigrated
          "MachenikeMini" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules =
              niriDesktop
              ++ kdeDesktop
              ++ personalSoftwares
              ++ [
                ./hosts/MachenikeMini/device-specific.nix
                ./mods/services/zeroclaw.nix
                ./mods/services/ssh.nix
              ];
          };

          "XuLab" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules =
              niriDesktop
              ++ kdeDesktop
              ++ createSoftwares
              ++ [
                ./mods/core/kernels/linux-zen.nix
                ./hosts/XuLab/device-specific.nix
                ./mods/core/drivers/nvidia/nvidia.nix
                ./users/XuLab/user.nix
                ./mods/services/tailscale.nix
              ];
          };

          "SOLOSISO" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
              "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares.nix"

              ({ pkgs, ... }: {
                nixpkgs.config.allowUnfree = true;
                isoImage.contents = [
                  {
                    source = self.nixosConfigurations.SolXPS26.config.system.build.toplevel;
                    target = "/target-system";
                  }
                ];
                # environment.etc."nixos-config".source = ./.;
                hardware.enableAllFirmware = true;
              })
            ];
          };

          "SOLOSISO2" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules =
              guiModules
              ++ niriDesktop
              ++ [
                "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-base.nix"
                "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares.nix"

                # ({ pkgs, ... }: {
                #   isoImage.contents = [
                #     {
                #       source = self.nixosConfigurations.SolXPS26.config.system.build.toplevel;
                #       target = "/target-system";
                #     }
                #   ];
                # })
                ./users/Sol/user.nix
                ./users/Sol/home.nix
              ];
          };
        };
      };
      perSystem =
        { pkgs, ... }:
        {
          devShells = {
            default = pkgs.mkShell {
              NIX_CONFIG = "extra-experimental-features = nix-command flakes";
              nativeBuildInputs = with pkgs; [
                gh
                git
                lazygit
                gnumake
                neovim
                nh
                yazi
                zoxide
              ];
              shellHook = ''
                echo "Fiat Lux!"
              '';
            };
          };
        };

    };
}
