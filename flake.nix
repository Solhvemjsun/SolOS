{
  description = "Sol's OS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    home-manager.url = "github:nix-community/home-manager";
    stylix.url = "github:danth/stylix";
    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
  };

  outputs = { nixpkgs, nixvim, home-manager, stylix, minegrub-theme, ... }: let 
    commonModules = [
      nixvim.nixosModules.nixvim
      stylix.nixosModules.stylix
      ./core/nixos.nix
      ./users/Sol.nix
    ];
    hyprlandModules = [
      minegrub-theme.nixosModules.default
      home-manager.nixosModules.home-manager
      ./hyprland/hyprland.nix
    ];
    personalModules = [
      ./software/gaming.nix
      ./software/personal.nix
      ./software/tor.nix 
    ];
    workModules = [
      ./software/office.nix
      ./software/develop.nix
    ];
  in {
    nixosConfigurations = {
      "SolXPS" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ hyprlandModules ++ personalModules ++ workModules ++ [
          {
            networking.hostName = "SolXPS";
            home-manager.users.Sol = {};
          }
          ./device/XPS13.nix
          ./hardware/laptop.nix
        ];
      };

      "SolITX" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ hyprlandModules ++ personalModules ++ workModules ++ [
          {
            networking.hostName = "SolITX";
            home-manager.users.Sol = {};
          }
          ./device/MeshlessAIO.nix
          ./hardware/nvidia.nix
          ./hardware/razer.nix
        ]; 
      };

      "XuLab" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ hyprlandModules ++ workModules ++ [
          {
            networking.hostName = "XuLab";
            home-manager.users.Sol = {};
            # home-manager.users.XuLab = {};
          }
          ./device/XuLab.nix
          ./hardware/nvidia.nix
          ./software/develop.nix

        ]; 
      };

      "SolBase" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ hyprlandModules ++ [
          {
            networking.hostName = "SolBase";
            home-manager.users.Sol = {};
          }
          ./device/SolBase.nix
          ./service/miniserver.nix
        ];
      };

      "MachenikeMini" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ hyprlandModules ++ [
          {
            networking.hostName = "MachenikeMini";
            home-manager.users.Sol = {};
          }
          ./device/MachenikeMini.nix
        ];
      };

      "DarkSol" = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = commonModules ++ [
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
          {
            networking.hostName = "DarkSol";
          }
          ./core/rpi4.nix
        ];
      };
    };
    devShells = {
      aarch64-linux.default = nixpkgs.legacyPackages.aarch64-linux.mkShell {
        buildInputs = [ nixpkgs.legacyPackages.aarch64-linux.qemu ];
      };
    };

  };
}
