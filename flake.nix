{
  description = "Sol's OS, Fiat Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-on-droid.url = "github:nix-community/nix-on-droid/release-24.05";
    home-manager.url = "github:nix-community/home-manager";
    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
    nixvim.url = "github:nix-community/nixvim";
    stylix.url = "github:danth/stylix";
    plasma-manager.url = "github:nix-community/plasma-manager";
  };

  outputs = { nixpkgs, nixvim, home-manager, plasma-manager, stylix, minegrub-theme, nix-on-droid, ... }: let 
    commonModules = [
      ./core/nixos.nix
      ./users/Sol.nix
    ];
    userModules = [
      home-manager.nixosModules.home-manager
      nixvim.nixosModules.nixvim
      ./terminal/nixvim.nix
      ./core/user.nix
      # ./terminal/zsh.nix
    ];
    hyprlandModules = [
      stylix.nixosModules.stylix
      minegrub-theme.nixosModules.default
      { home-manager.users.Sol = {}; }
      ./gui/common.nix
      ./gui/hyprland/hyprland.nix
    ];
    kdeModules = [
      minegrub-theme.nixosModules.default
      {
        home-manager = {
          users.Sol = {};
          sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
        };  
      }
      ./gui/common.nix
      ./gui/kde/kde.nix
    ];
    personalModules = [
      ./gui/softwares/gaming.nix
      ./gui/softwares/personal.nix
      ./gui/softwares/tor.nix 
      ./gui/softwares/nextcloud.nix
    ];
    workModules = [
      ./gui/softwares/office.nix
      ./gui/softwares/develop.nix
    ];
  in {

    nixOnDroidConfigurations = {
      default = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-linux";
          overlays = [
            nix-on-droid.overlays.default
          ];
        };
        modules = [
          # stylix.nixOnDroidModules.stylix
          nixvim.homeManagerModules.nixvim
          ./core/nix-on-droid.nix
        ];
        home-manager-path = home-manager.outPath;
      };
    };

    nixosConfigurations = {
      "SolXPS" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ userModules ++ hyprlandModules ++ personalModules ++ workModules ++ [
          { networking.hostName = "SolXPS"; }
          ./hardware/devices/XPS13.nix
          ./hardware/laptop.nix
        ];
      };

      "SolITX" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ userModules ++ hyprlandModules ++ personalModules ++ workModules ++ [
          { networking.hostName = "SolITX"; }
          ./hardware/devices/MeshlessAIO.nix
          ./hardware/nvidia.nix
          ./hardware/razer.nix
        ]; 
      };

      "XuLab" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ userModules ++ hyprlandModules ++ workModules ++ [
          {
            networking.hostName = "XuLab";
            home-manager.users.XuLab = {};
          }
          ./hardware/devices/XuLab.nix
          ./users/XuLab.nix
          ./hardware/nvidia.nix

        ]; 
      };

      "SolBase" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ userModules ++ hyprlandModules ++ [
          { networking.hostName = "SolBase"; }
          ./hardware/devices/SolBase.nix
          ./service/miniserver.nix
          ./service/ssh.nix
        ];
      };

      "MachenikeMini" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ userModules ++ kdeModules ++ personalModules ++ workModules ++ [
          { networking.hostName = "MachenikeMini"; }
          ./hardware/devices/MachenikeMini.nix
        ];
      };

      "DarkSol" = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = commonModules ++ [
          { networking.hostName = "DarkSol"; }
          ./core/rpi4.nix
          ./hardware/devices/DarkSol.nix
          ./service/ssh.nix
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
