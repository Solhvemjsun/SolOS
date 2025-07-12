{
  description = "Sol's OS, Fiat Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixvim,
      home-manager,
      stylix,
      minegrub-theme,
      niri,
      plasma-manager,
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
      guiModules = [
        minegrub-theme.nixosModules.default
        stylix.nixosModules.stylix
        ./gui/common.nix
        { home-manager.users.Sol = { }; }
      ];
      niriModules = [
        ./gui/niri.nix
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
              { networking.hostName = "SolXPS"; }
              ./hardware/devices/XPS13.nix
              ./hardware/laptop.nix
              ./core/fish.nix
            ];
        };

        "SolITX" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          # inherit specialArgs;
          modules =
            commonModules
            ++ guiModules
            ++ niriModules
            # ++ kdeModules
            ++ personalModules
            ++ workModules
            ++ [
              { networking.hostName = "SolITX"; }
              ./hardware/devices/MeshlessAIO.nix
              ./hardware/nvidia.nix
              ./services/postgresql.nix
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
            ++ guiModules
            ++ niriModules
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
            ++ guiModules
            ++ kdeModules
            ++ niriModules
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
