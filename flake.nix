{
  description = "Sol's OS, Fiat Nix!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
    minegrub-theme.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";

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

    papertoy.url = "github:sin-ack/papertoy";
  };

  outputs =
    inputs@{
      nixpkgs,
      flake-parts,
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
      papertoy,
      ...
    }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      commonModules = [
        ./core/nixos.nix
        ./users/Sol.nix
        nixvim.nixosModules.nixvim
        ./mods/tui/fish.nix
        ./mods/tui/nixvim.nix
        ./mods/tui/yazi.nix
      ];
      guiModules = [
        minegrub-theme.nixosModules.default
        home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix
        ./mods/git/mod.nix
        ./mods/gui/common.nix
        { home-manager.users.Sol = { }; }
      ];
      niriModules = [
        ./mods/gui/niri.nix
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
        ./mods/gui/kde.nix
      ];
      personalModules = [
        ./mods/softwares/personal.nix
        ./mods/softwares/tor.nix
        ./mods/softwares/nextcloud.nix
        ./mods/softwares/gaming.nix
      ];
      workModules = [
        ./mods/softwares/office.nix
        ./mods/softwares/develop.nix
        ./mods/softwares/streaming.nix
      ];
      mcserverModules = [
        nix-minecraft.nixosModules.minecraft-servers
        { nixpkgs.overlays = [ nix-minecraft.overlay ]; }
      ];
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      flake = {
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
                ./hosts/XPS13/device-specific.nix
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
                ./hosts/ROG_Z13/device-specific.nix
                ./mods/oprain/mod.nix
                ./mods/china/clash.nix
                ./mods/waydroid/mod.nix
                ./mods/amdgpu/mod.nix
                ./mods/ai/mod.nix
                ./mods/services/tailscale.nix
              ];
          };

          "SolGPD" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules =
              commonModules
              ++ guiModules
              ++ niriModules
              ++ kdeModules
              ++ personalModules
              ++ workModules
              ++ [
                nixos-hardware.nixosModules.common-gpu-amd
                ./hosts/SolGPD/device-specific.nix
                ./mods/bambu/mod.nix
                ./mods/china/clash.nix
                ./mods/waydroid/mod.nix
                ./mods/services/tailscale.nix
              ];
          };

          "SolITX" = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            # inherit specialArgs;
            modules =
              commonModules
              ++ guiModules
              ++ niriModules
              ++ kdeModules
              ++ personalModules
              ++ workModules
              # ++ mcserverModules
              ++ [
                ./hosts/SolITX/device-specific.nix
                # ./mods/nvidia/mod.nix
                ./mods/waydroid/mod.nix
                ./mods/services/tailscale.nix
                ./mods/memorysavior/mod.nix
                ./mods/lix/mod.nix
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
                ./hosts/XuLab/device-specific.nix
                ./mods/nvidia/mod.nix
                ./users/XuLab.nix
                ./mods/services/tailscale.nix
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
                ./hosts/SolBase/device-specific.nix
                ./mods/ai/mod.nix
                ./private/SolOS_Private/miniserver.nix
                ./private/SolOS_Private/zeroclaw.nix
                ./mods/services/ssh.nix
                ./mods/services/minecraft/nix-minecraft.nix
                ./mods/services/minecraft/mcbugus.nix
                ./mods/services/tailscale.nix
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
                ./hosts/MachenikeMini/device-specific.nix
              ];
          };

          "DarkSol" = nixpkgs.lib.nixosSystem {
            system = "aarch64-linux";
            modules = commonModules ++ [
              ./core/rpi4.nix
              ./hosts/DarkSol/device-specific.nix
              ./mods/services/ssh.nix
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

        };
      };
      perSystem =
        { pkgs, ... }:
        {
          devShells = {
            default = pkgs.mkShell {
              NIX_CONFIG = "extra-experimental-features = nix-command flakes";
              nativeBuildInputs = with pkgs; [
                gh
                git
                lazygit
                gnumake
                neovim
                nh
                yazi
                zoxide
              ];
              shellHook = ''
                echo "Fiat Nix!"
              '';
            };
          };
        };

    };
}
