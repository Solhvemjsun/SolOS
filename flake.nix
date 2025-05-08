{
  description = "Sol's OS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    home-manager.url = "github:nix-community/home-manager";
    plasma-manager.url = "github:nix-community/plasma-manager";
    stylix.url = "github:danth/stylix";
    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
  };

  outputs = { nixpkgs, nixvim, home-manager, plasma-manager, stylix, minegrub-theme, ... }: let 
    commonModules = [
      ./core/nixos.nix
      ./users/Sol.nix
    ];
    terminalModules = [
      nixvim.nixosModules.nixvim
      ./terminal/nixvim.nix
      ./terminal/zsh.nix
      ./terminal/packages.nix
    ];
    hyprlandModules = [
      stylix.nixosModules.stylix
      minegrub-theme.nixosModules.default
      home-manager.nixosModules.home-manager
      { home-manager.users.Sol = {}; }
      ./gui/common.nix
      ./gui/hyprland/hyprland.nix
    ];
    kdeModules = [
      minegrub-theme.nixosModules.default
      home-manager.nixosModules.home-manager
      plasma-manager.homeManagerModules.plasma-manager
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
    nixosConfigurations = {
      "SolXPS" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ terminalModules ++ hyprlandModules ++ personalModules ++ workModules ++ [
          {
            networking.hostName = "SolXPS";
          }
          ./hardware/devices/XPS13.nix
          ./hardware/laptop.nix
        ];
      };

      "SolITX" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ terminalModules ++ hyprlandModules ++ personalModules ++ workModules ++ [
          {
            networking.hostName = "SolITX";
          }
          ./hardware/devices/MeshlessAIO.nix
          ./hardware/nvidia.nix
          ./hardware/razer.nix
        ]; 
      };

      "XuLab" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ terminalModules ++ hyprlandModules ++ workModules ++ [
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
        modules = commonModules ++ terminalModules ++ hyprlandModules ++ [
          {
            networking.hostName = "SolBase";
          }
          ./hardware/devices/SolBase.nix
          ./service/miniserver.nix
          ./service/ssh.nix
        ];
      };

      "MachenikeMini" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ terminalModules ++ kdeModules ++ personalModules ++ [
          {
            networking.hostName = "MachenikeMini";
          }
          ./hardware/devices/MachenikeMini.nix
        ];
      };

      "DarkSol" = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = commonModules ++ [
          {
            networking.hostName = "DarkSol";
          }
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
