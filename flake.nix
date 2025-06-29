{
  description = "Sol's OS, Fiat Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
    nixvim.url = "github:nix-community/nixvim/nixos-25.05";
    stylix.url = "github:danth/stylix/release-25.05";
    niri.url = "github:sodiboo/niri-flake";
    plasma-manager.url = "github:nix-community/plasma-manager";
    nix-on-droid.url = "github:nix-community/nix-on-droid/release-24.05";
  };

  outputs =
    {
      nixpkgs,
      nixvim,
      home-manager,
      stylix,
      minegrub-theme,
      niri,
      nix-on-droid,
      ...
    }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      commonModules = [
        ./core/nixos.nix
        ./users/Sol.nix
        home-manager.nixosModules.home-manager
        nixvim.nixosModules.nixvim
        ./softwares/nixvim.nix
        ./core/user.nix
        ./core/zsh.nix
      ];
      hyprlandModules = [
        stylix.nixosModules.stylix
        minegrub-theme.nixosModules.default
        { home-manager.users.Sol = { }; }
        ./gui/common.nix
        ./gui/hyprland/hyprland.nix
      ];
      niriModules = [
        stylix.nixosModules.stylix
        minegrub-theme.nixosModules.default
        # niri.nixosModules.niri
        ./gui/common.nix
        ./gui/niri/niri.nix
        {
          home-manager = {
            users.Sol = { };
            sharedModules = [
              niri.homeModules.niri
            ];
          };
          # nixpkgs.overlays = [ niri.overlays.niri ];
        }
      ];
      kdeModules = [
        minegrub-theme.nixosModules.default
        { home-manager.users.Sol = { }; }
        ./gui/common.nix
        ./gui/kde/kde.nix
      ];
      personalModules = [
        ./softwares/gaming.nix
        ./softwares/personal.nix
        ./softwares/tor.nix
        ./softwares/nextcloud.nix
      ];
      workModules = [
        ./softwares/office.nix
        ./softwares/develop.nix
      ];
    in
    {

      nixosConfigurations = {
        "SolXPS" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            commonModules
            ++ hyprlandModules
            ++ personalModules
            ++ workModules
            ++ [
              { networking.hostName = "SolXPS"; }
              ./hardware/devices/XPS13.nix
              ./hardware/laptop.nix
            ];
        };

        "SolITX" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          # inherit specialArgs;
          modules =
            commonModules
            # ++ hyprlandModules
            ++ niriModules
            ++ personalModules
            ++ workModules
            ++ [
              { networking.hostName = "SolITX"; }
              ./hardware/devices/MeshlessAIO.nix
              ./hardware/nvidia.nix
              # ./hardware/razer.nix
              ./services/postgresql.nix
              ./virtualize/wine.nix
            ];
        };

        "XuLab" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            commonModules
            ++ hyprlandModules
            ++ workModules
            ++ [
              {
                networking.hostName = "XuLab";
                home-manager.users.XuLab = { };
              }
              ./hardware/devices/XuLab.nix
              ./users/XuLab.nix
              ./hardware/nvidia.nix

            ];
        };

        "SolBase" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            commonModules
            ++ hyprlandModules
            ++ [
              { networking.hostName = "SolBase"; }
              ./hardware/devices/SolBase.nix
              ./services/miniserver.nix
              ./services/ssh.nix
            ];
        };

        "MachenikeMini" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            commonModules
            ++ kdeModules
            ++ personalModules
            ++ workModules
            ++ [
              { networking.hostName = "MachenikeMini"; }
              ./hardware/devices/MachenikeMini.nix
            ];
        };

        "DarkSol" = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = commonModules ++ [
            { networking.hostName = "DarkSol"; }
            ./core/nixos.nix
            ./core/rpi4.nix
            ./users/Sol.nix
            ./hardware/devices/DarkSol.nix
            ./services/ssh.nix
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
        "x86_64-linux".default = pkgs.mkShell {
          NIX_CONFIG = "extra-experimental-features = nix-command flakes";
          nativeBuildInputs = with pkgs; [
            nh
            git
            openssh
            gnumake
          ];
          shellHook = ''
            echo "Fiat Nix!"
            vim ./
          '';
        };
      };

    };
}
