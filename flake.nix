{
  description = "Sol's OS, Fiat Nix!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
    minegrub-theme.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

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
      nixpkgs,
      flake-parts,
      nixos-wsl,
      nixos-hardware,
      home-manager,
      minegrub-theme,
      nixvim,
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
        ./mods/core/nix/nix.nix
        ./mods/core/drivers/network/networkmanager.nix
      ];
      tuiModules = coreModules ++ [
        home-manager.nixosModules.home-manager
        nixvim.nixosModules.nixvim
        ./mods/core/home/homemanager.nix
        ./users/Sol/user.nix
        ./mods/tui/fish.nix
        ./mods/tui/nixvim.nix
        ./mods/tui/yazi.nix
        ./mods/tui/softwares.nix
        ./mods/tui/fastfetch.nix
      ];
      guiModules = tuiModules ++ [
        minegrub-theme.nixosModules.default
        stylix.nixosModules.stylix
        ./mods/gui/common.nix
        ./mods/core/performance/zramSwap.nix
      ];
      niriModules = guiModules ++ [
        ./mods/gui/niri/default.nix
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
      kdeModules = [
        { home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ]; }
        ./mods/gui/kde/default.nix
      ];
      basicSoftwares = [
        ./mods/gui/softwares/cloud/nextcloud.nix
        ./mods/gui/softwares/streaming/obs.nix
        ./mods/gui/softwares/work/communication.nix
        ./mods/gui/softwares/net/communication.nix
        ./mods/gui/softwares/net/firefox.nix
        ./mods/gui/softwares/net/remote.nix
        ./mods/gui/softwares/net/tor.nix
      ];
      createSoftwares = basicSoftwares ++ [
        ./mods/gui/softwares/art/draw.nix
        ./mods/gui/softwares/art/music.nix
        ./mods/gui/softwares/art/video.nix
        ./mods/gui/softwares/design/3d.nix
        ./mods/gui/softwares/design/cad.nix
        ./mods/gui/softwares/develop/game.nix
      ];
      personalSoftwares = createSoftwares ++ [
        ./mods/gui/softwares/joy/media.nix
        ./mods/gui/softwares/joy/minecraft.nix
        ./mods/gui/softwares/joy/steam.nix
        ./mods/gui/softwares/joy/communication.nix
      ];
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      flake = {
        nixosConfigurations = {
          "SolXPS" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules =
              niriModules
              ++ personalSoftwares
              ++ [
                ./hosts/XPS13/device-specific.nix
                ./mods/gui/softwares/net/clash.nix
              ];
          };

          "SolZ13" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules =
              niriModules
              ++ kdeModules
              ++ personalSoftwares
              ++ [
                nixos-hardware.nixosModules.asus-battery
                nixos-hardware.nixosModules.common-gpu-amd
                ./hosts/ROG_Z13/device-specific.nix
                ./mods/gui/softwares/net/clash.nix
                ./mods/gui/softwares/virtualize/waydroid.nix
                ./mods/core/drivers/amdgpu/amdgpu.nix
                ./mods/services/tailscale.nix
                ./mods/experiment/ai/mod.nix
              ];
          };

          "SolGPD" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules =
              niriModules
              ++ kdeModules
              ++ personalSoftwares
              ++ [
                nixos-hardware.nixosModules.common-gpu-amd
                ./hosts/SolGPD/device-specific.nix
                ./mods/gui/softwares/net/clash.nix
                ./mods/services/tailscale.nix
              ];
          };

          "SolITX" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules =
              niriModules
              ++ kdeModules
              ++ personalSoftwares
              ++ [
                ./mods/core/kernels/linux-zen.nix
                ./hosts/SolITX/device-specific.nix
                ./mods/core/drivers/nvidia/nvidia.nix
                ./mods/core/drivers/firmwares/closed.nix
                ./mods/gui/softwares/virtualize/waydroid.nix
                ./mods/services/tailscale.nix
                ./mods/experiment/ai/mod.nix
              ];
          };

          "MachenikeMini" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules =
              niriModules
              ++ kdeModules
              ++ personalSoftwares
              ++ [
                ./mods/core/kernels/linux-zen.nix
                ./hosts/MachenikeMini/device-specific.nix
              ];
          };

          "XuLab" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules =
              niriModules
              ++ kdeModules
              ++ createSoftwares
              ++ [
                ./mods/core/kernels/linux-zen.nix
                ./hosts/XuLab/device-specific.nix
                ./mods/core/drivers/nvidia/nvidia.nix
                ./users/XuLab/user.nix
                ./mods/services/tailscale.nix
              ];
          };

          "SolBase" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = niriModules ++ [
              nix-minecraft.nixosModules.minecraft-servers
              { nixpkgs.overlays = [ nix-minecraft.overlay ]; }
              ./mods/core/kernels/linux-hardened.nix
              ./hosts/SolBase/device-specific.nix
              ./mods/gui/softwares/net/firefox.nix
              ./mods/services/SolOS_Private/miniserver.nix
              ./mods/services/SolOS_Private/zeroclaw.nix
              ./mods/services/ssh.nix
              ./mods/services/minecraft/nix-minecraft.nix
              ./mods/services/minecraft/mcbugus.nix
              ./mods/services/tailscale.nix
            ];
          };

          "DarkSol" = nixpkgs.lib.nixosSystem {
            system = "aarch64-linux";
            modules = tuiModules ++ [
              ./mods/core/platforms/rpi4.nix
              ./hosts/DarkSol/device-specific.nix
              ./mods/services/ssh.nix
            ];
          };

          "SolOS-WSL" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = tuiModules ++ [
              nixos-wsl.nixosModules.default
              ./mods/core/wsl.nix
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
                echo "Fiat Nix!"
              '';
            };
          };
        };

    };
}
