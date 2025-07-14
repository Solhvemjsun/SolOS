{
  description = "Sol's OS, Fiat Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    lix-module.url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.2-1.tar.gz";
    lix-module.inputs.nixpkgs.follows = "nixpkgs";

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

    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-on-droid.url = "github:nix-community/nix-on-droid/release-24.05";
    nix-on-droid.inputs.nixpkgs.follows = "nixpkgs";

    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      lix-module,
      nixvim,
      home-manager,
      stylix,
      minegrub-theme,
      niri,
      plasma-manager,
      nix-on-droid,
      aagl,
      ...
    }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      commonModules = [
        ./core/nixos.nix
        ./users/Sol.nix
        lix-module.nixosModules.default
        nixvim.nixosModules.nixvim
        ./softwares/nixvim.nix
        ./softwares/fish.nix
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
      ];
      creativeModules = [
        ./softwares/music.nix
      ];
      aaglModules = [
        aagl.nixosModules.default
        ./softwares/aagl.nix
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
              { networking.hostName = "SolXPS"; }
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
            ++ aaglModules
            ++ [
              { networking.hostName = "SolITX"; }
              ./device/SolITX/device-specific.nix
              ./hardware/nvidia.nix
              ./hardware/health.nix
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
            ++ [
              { networking.hostName = "SolBase"; }
              ./device/SolBase/device-specific.nix
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
              ./device/MachenikeMini/device-specific.nix
            ];
        };

        "DarkSol" = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = commonModules ++ [
            { networking.hostName = "DarkSol"; }
            ./core/nixos.nix
            ./core/rpi4.nix
            ./users/Sol.nix
            ./device/DarkSol/device-specific.nix
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
