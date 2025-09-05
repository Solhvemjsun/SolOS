{
  description = "Sol's OS, Fiat Nix!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    # lix-module.url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.2-1.tar.gz";
    # lix-module.inputs.nixpkgs.follows = "nixpkgs";

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

    astal-shell.url = "github:knoopx/ags";

    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    nix-on-droid.url = "github:nix-community/nix-on-droid/release-24.05";
    nix-on-droid.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      # lix-module,
      nixvim,
      home-manager,
      stylix,
      minegrub-theme,
      niri,
      astal-shell,
      plasma-manager,
      nix-minecraft,
      nix-on-droid,
      ...
    }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      commonModules = [
        ./core/nixos.nix
        ./users/Sol.nix
        # lix-module.nixosModules.default
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
        { nixpkgs.overlays = [ astal-shell.overlays.default ]; }
        { home-manager.sharedModules = [ niri.homeModules.niri ]; }
      ];
      kdeModules = [
        { home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ]; }
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
        ./softwares/engineering.nix
        ./softwares/streaming.nix
      ];
      creativeModules = [
        ./softwares/music.nix
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
            ++ creativeModules
            ++ [
              ./device/XPS13/device-specific.nix
              ./hardware/laptop.nix
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
            ++ creativeModules
            # ++ mcserverModules
            ++ [
              ./device/SolITX/device-specific.nix
              ./hardware/nvidia.nix
              ./hardware/health.nix
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
              ./device/XuLab/device-specific.nix
              ./users/XuLab.nix
              ./hardware/nvidia.nix
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
              { }
              ./device/SolBase/device-specific.nix
              ./service/miniserver.nix
              ./service/ssh.nix
              ./service/mcbugus.nix
            ];
        };

        "MachenikeMini" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            commonModules
            ++ guiModules
            ++ kdeModules
            ++ niriModules
            ++ personalModules
            ++ workModules
            ++ [
              ./device/MachenikeMini/device-specific.nix
            ];
        };

        "DarkSol" = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = commonModules ++ [
            ./core/rpi4.nix
            ./device/DarkSol/device-specific.nix
            ./service/ssh.nix
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
