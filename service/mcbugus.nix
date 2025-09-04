{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Minecraft server settings
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers.mcbugus = {
      enable = true;

      # Specify the custom minecraft server package
      package = pkgs.fabricServers.fabric-1_20_1.override {
        loaderVersion = "0.17.2";
      }; # Specific fabric loader version

      symlinks = {
        mods = pkgs.linkFarmFromDrvs "mods" (
          builtins.attrValues {
            # Get the modattr by nix run github:Infinidoge/nix-minecraft#nix-modrinth-prefetch -- 9xIK4e8l
            # Libs
            Fabric-API = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/UapVHwiP/fabric-api-0.92.6%2B1.20.1.jar";
              sha512 = "2bd2ed0cee22305b7ff49597c103a57c8fbe5f64be54a906796d48b589862626c951ff4cbf5cb1ed764a4d6479d69c3077594e693b7a291240eeea2bb3132b0c";
            };
            Cloth-Config-API = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/9s6osm5g/versions/2xQdCMyG/cloth-config-11.1.136-fabric.jar";
              sha512 = "2da85c071c854223cc30c8e46794391b77e53f28ecdbbde59dc83b3dbbdfc74be9e68da9ed464e7f98b4361033899ba4f681ebff1f35edc2c60e599a59796f1c";
            };
            Trinkets = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/5aaWibi9/versions/AHxQGtuC/trinkets-3.7.2.jar";
              sha512 = "bedf97c87c5e556416410267108ad358b32806448be24ef8ae1a79ac63b78b48b9c851c00c845b8aedfc7805601385420716b9e65326fdab21340e8ba3cc4274";
            };
            Cardinal-Components-API = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/K01OU20C/versions/Ielhod3p/cardinal-components-api-5.2.3.jar";
              sha512 = "f20484d5bc780bee9b388ff6075e7c3bd130c7f8cae75a425bfd1fb68d03ca19288c09b0729992987fd32f3a2433b49c25162e086de82abd8d06ee45e4e3c917";
            };

            # Equipments
            Traveler's-Backpack = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/rlloIFEV/versions/lnzLVA1W/travelersbackpack-fabric-1.20.1-9.1.38.jar";
              sha512 = "2c5e7348d2c9990bf25517a44c9baa0488b76e8fe5d0b5492e92189797d7725913b46d644b0dfe7587b55e03404d9770bc7ea945c626299e4ecd88aa0e04d067";
            };

          }
        );
      };
    };
  };
}
