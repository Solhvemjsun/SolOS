{
  description = "Sol's OS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    home-manager.url = "github:nix-community/home-manager";
    stylix.url = "github:danth/stylix";
    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
  };

  outputs = { nixpkgs, nixvim, home-manager, stylix, minegrub-theme, ... }: 

  let 
    commonModules = [
      nixvim.nixosModules.nixvim
      stylix.nixosModules.stylix
      ./core/nixos.nix
    ];
    hyprlandModules = [
      minegrub-theme.nixosModules.default
      home-manager.nixosModules.home-manager
      ./hyprland/hyprland.nix
    ];
    personalModules = [
      ./software/develop.nix
      ./software/gaming.nix
      ./software/personal.nix
      ./software/tor.nix 
    ];
  in {
    nixosConfigurations = {
      "SolXPS" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ hyprlandModules ++ personalModules ++ [
          { networking.hostName = "SolXPS"; }
          { home-manager.users.Sol = {}; }
          ./device/XPS13.nix
          ./hardware/laptop.nix
        ];
      };

      "SolITX" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ hyprlandModules ++ personalModules ++ [
          { networking.hostName = "SolITX"; }
          { home-manager.users.Sol = {}; }
          ./device/MeshlessAIO.nix
          ./hardware/nvidia.nix
          ./hardware/razer.nix
        ]; 
      };

      "XuLab" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ hyprlandModules ++ [
          { networking.hostName = "XuLab"; }
          ./device/XuLab.nix
          { home-manager.users.Sol = {}; }
          { home-manager.users.XuLab = {}; }
          ./hardware/nvidia.nix
          ./software/develop.nix

        ]; 
      };

      "SolBase" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ hyprlandModules ++ [
          { networking.hostName = "SolBase"; }
          { home-manager.users.Sol = {}; }
          ./device/SolBase.nix
          ./service/miniserver.nix
        ];
      };

      "MachenikeMini" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ hyprlandModules ++ [
          { networking.hostName = "MachenikeMini"; }
          { home-manager.users.Sol = {}; }
          ./device/MachenikeMini.nix
        ];
      };

    };

  };
}
