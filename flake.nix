{
  description = "Sol's OS, Fiat Nix!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    nix-on-droid.url = "github:nix-community/nix-on-droid/release-24.05";
    nix-on-droid.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-hardware.inputs.nixpkgs.follows = "nixpkgs";

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
    {
      nixpkgs,
      nix-on-droid,
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
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      commonModules = [
        ./core/nixos.nix
        ./users/Sol.nix
        nixvim.nixosModules.nixvim
        ./tui/fish.nix
        ./tui/nixvim.nix
        ./tui/yazi.nix
      ];
      guiModules = [
        minegrub-theme.nixosModules.default
        home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix
        ./gui/common.nix
        { home-manager.users.Sol = { }; }
      ];
      niriModules = [
        ./gui/niri.nix
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
        ./gui/kde.nix
      ];
      personalModules = [
        ./softwares/personal.nix
        ./softwares/tor.nix
        ./softwares/nextcloud.nix
        ./softwares/gaming.nix
      ];
      workModules = [
        ./softwares/office.nix
        ./softwares/develop.nix
        ./softwares/streaming.nix
      ];
      mcserverModules = [
        nix-minecraft.nixosModules.minecraft-servers
        { nixpkgs.overlays = [ nix-minecraft.overlay ]; }
      ];
    in
    {
      nixosConfigurations = {
        "SolXPS" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            commonModules
            ++ guiModules
            ++ niriModules
            ++ personalModules
            ++ workModules
            ++ [
              ./devices/XPS13/device-specific.nix
              ./mods/oprain/mod.nix
              ./mods/bambu/mod.nix
            ];
        };

        "SolZ13" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            commonModules
            ++ guiModules
            ++ niriModules
            ++ kdeModules
            ++ personalModules
            ++ workModules
            ++ [
              nixos-hardware.nixosModules.asus-battery
              nixos-hardware.nixosModules.common-gpu-amd
              ./devices/ROG_Z13/device-specific.nix
              ./mods/oprain/mod.nix
              ./mods/bambu/mod.nix
              ./mods/china/mod.nix
            ];
        };

        "SolITX" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          # inherit specialArgs;
          modules =
            commonModules
            ++ guiModules
            ++ niriModules
            ++ personalModules
            ++ workModules
            # ++ mcserverModules
            ++ [
              ./devices/SolITX/device-specific.nix
              ./hardware/nvidia.nix
              ./hardware/health.nix
              ./mods/oprain/mod.nix
              ./mods/bambu/mod.nix
              # ./service/mcbugus.nix
            ];
        };

        "XuLab" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            commonModules
            ++ guiModules
            ++ niriModules
            ++ workModules
            ++ [
              ./devices/XuLab/device-specific.nix
              ./hardware/nvidia.nix
              ./users/XuLab.nix
            ];
        };

        "SolBase" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            commonModules
            ++ guiModules
            ++ niriModules
            ++ mcserverModules
            ++ [
              ./devices/SolBase/device-specific.nix
              ./private/SolOS_Private/miniserver.nix
              ./service/ssh.nix
              ./service/minecraft/nix-minecraft.nix
              ./service/minecraft/mcbugus.nix
            ];
        };

        "MachenikeMini" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            commonModules
            ++ guiModules
            ++ kdeModules
            ++ personalModules
            ++ workModules
            ++ [
              ./devices/MachenikeMini/device-specific.nix
            ];
        };

        "DarkSol" = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = commonModules ++ [
            ./core/rpi4.nix
            ./devices/DarkSol/device-specific.nix
            ./service/ssh.nix
          ];
        };

        "SolOS-WSL" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            commonModules
            ++ workModules
            ++ guiModules
            ++ [
              nixos-wsl.nixosModules.default
              ./core/wsl.nix
            ];
        };

        "Template" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux"; # Your CPU Architecture
          modules =
            commonModules
            ++ guiModules
            ++ niriModules
            # ++ The other modules you want
            ++ [
              ./devices/Template/device-specific.nix # Your device
              # ./hardware/nvidia.nix # If you have Nvidia card
            ];
        };
      };

      nixOnDroidConfigurations = {
        default = nix-on-droid.lib.nixOnDroidConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-linux";
            overlays = [
              nix-on-droid.overlays.default
            ];
          };
          modules = [
            ./core/nix-on-droid.nix
          ];
          home-manager-path = home-manager.outPath;
        };
      };

      devShells = {
        "x86_64-linux" = {
          default = pkgs.mkShell {
            NIX_CONFIG = "extra-experimental-features = nix-command flakes";
            nativeBuildInputs = with pkgs; [
              nh
              git
              openssh
              gnumake
            ];
            shellHook = ''
              echo "Fiat Nix!"
            '';
          };
          BCI = pkgs.mkShell {
            NIX_CONFIG = "extra-experimental-features = nix-command flakes";
            nativeBuildInputs = with pkgs; [
              brainflow
              cargo
              rustc
            ];
            shellHook = ''
              echo "Fiat Nix!"
              vim ./
            '';
          };
        };
      };
    };
}
