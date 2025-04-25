{
  description = "Sol's OS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nixvim.url = "github:nix-community/nixvim";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
  };

  outputs = { nixpkgs, nixvim, home-manager, stylix, minegrub-theme, ... }: {
    nixosConfigurations = {
      "SolXPS" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { networking.hostName = "SolXPS"; }
          nixvim.nixosModules.nixvim
          stylix.nixosModules.stylix
          minegrub-theme.nixosModules.default

          ./core/nixos.nix

          ./device/XPS13.nix
          ./hardware/laptop.nix

          ./hyprland/hyprland.nix

          ./software/develop.nix
          ./software/gaming.nix
          ./software/personal.nix
          ./software/tor.nix
          ./software/waydroid.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.users.Sol = import ./hyprland/home.nix;
            home-manager.backupFileExtension = "backup";
          }
        ];
      };

      "SolITX" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { networking.hostName = "SolITX"; }
          nixvim.nixosModules.nixvim
          stylix.nixosModules.stylix
          minegrub-theme.nixosModules.default

          ./core/nixos.nix

          ./device/MeshlessAIO.nix
          ./hardware/nvidia.nix
          ./hardware/razer.nix

          ./hyprland/hyprland.nix

          ./software/develop.nix
          ./software/gaming.nix
          ./software/tor.nix
          ./software/personal.nix
          ./software/waydroid.nix
          
          home-manager.nixosModules.home-manager
          {
            home-manager.users.Sol = import ./hyprland/home.nix;
            home-manager.backupFileExtension = "backup";
          }

        ]; 
      };

      "XuLab" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { networking.hostName = "XuLab"; }
          nixvim.nixosModules.nixvim
          stylix.nixosModules.stylix
          minegrub-theme.nixosModules.default

          ./core/nixos.nix

          ./device/XuLab.nix
          ./hardware/nvidia.nix

          ./hyprland/hyprland.nix

          ./software/develop.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.users.Sol = import ./hyprland/home.nix;
            home-manager.backupFileExtension = "backup";
          }

        ]; 
      };

      "SolBase" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { networking.hostName = "SolBase"; }

          nixvim.nixosModules.nixvim
          stylix.nixosModules.stylix
          minegrub-theme.nixosModules.default

          ./core/nixos.nix

          ./device/SolBase.nix

          ./service/miniserver.nix

          ./hyprland/hyprland.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.users.Sol = import ./hyprland/home.nix;
            home-manager.backupFileExtension = "backup";
          }

        ];
      };

      "MachenikeMini" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          { networking.hostName = "MachenikeMini"; }

          nixvim.nixosModules.nixvim
          stylix.nixosModules.stylix
          minegrub-theme.nixosModules.default

          ./core/nixos.nix

          ./device/MachenikeMini.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.users.Sol = import ./hyprland/home.nix;
            home-manager.backupFileExtension = "backup";
          }

        ];
      };

    };
  };
}
