{
  config,
  pkgs,
  lib,
  ...
}:

{
  # MCBUGUS Via nix-minecraft
  services.minecraft-servers = {
    enable = true;
    dataDir = /srv/minecraft/;
    runDir = /run/minecraft/;

    eula = true;
    openFirewall = true;
    servers.mcbugus = {
      enable = true;
      autostart = true;
      openFirewall = true;
      restart = "always";
      enableReload = true;
      serverProperties = {
        allow-flight = true;
        server-port = 25565;
        difficulty = 2;
        enable-command-block = true;
        enable-query = true;
        enable-status = true;
        enable-secure-profile = false;
        enforce-whitelist = false;
        gamemode = 0;
        motd = "§l§6Fiat Lux";
        enable-rcon = false;
        level-name = "world";
        level-seed = "Liberty";
        level-type = "minecraft:normal";
        max-players = 2021;
        online-mode = false;
        white-list = false;
      };
      # jvmOpts = "";


      # Specify the custom minecraft server package
      package = pkgs.fabricServers.fabric-1_20_1.override {
        loaderVersion = "0.17.2";
      }; # Specific fabric loader version

      symlinks = {
        mods = pkgs.linkFarmFromDrvs "mods" (
          # Get the modattr by nix run github:Infinidoge/nix-minecraft#nix-modrinth-prefetch -- version (Something like 9xIK4e8l)
          builtins.attrValues {
            ##########
            ## Libs ##
            ##########
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
            Patchouli = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/nU0bVIaL/versions/Muu5nGmj/Patchouli-1.20.1-84.1-FABRIC.jar";
              sha512 = "a08ae7db9381bf44ff5a22e5fa0cc44ff744fe220df6c88863eded09274786609e8705dc6a31f70c072127c81255a413d37aa479dd2aaf07bc7ed0c822e0a070";
            };
            Fabric-Language-Kotlin = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Ha28R6CL/versions/Y91MRWtG/fabric-language-kotlin-1.13.5%2Bkotlin.2.2.10.jar";
              sha512 = "bae89ea5e71895f5a760def61359bb90a715832d998aec8141902410c503533fc42631e033109fcc9cdb3f869c58da9b89e9efc3b3ef112cbafe27059de9239e";
            };
            Paucal = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/TZo2wHFe/versions/dabyDTwJ/paucal-0.6.0%2B1.20.1-fabric.jar";
              sha512 = "5ab76a177c66113a1a1a6aaf738077c711d4b73807814d530f753961967398d5908ef1857b3290e633a3917bf7a93f9dc8cf2fb9767b26b8efbe8e295922d571";
            };
            Inline = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/fin1PX4m/versions/n7VmkBLu/inline-fabric-1.20.1-1.2.2.jar";
              sha512 = "f2aecf5f8de3d6ff32d810b8d358450579ab3215d19ff5c228ab874f781d45ab35dfdbc0948d76150617e283140f0e8a0275c56d01d1a0991863e11952b27812";
            };
            Architectury = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/lhGA9TYQ/versions/WbL7MStR/architectury-9.2.14-fabric.jar";
              sha512 = "4cb8f009fd522d68a795d2cf5a657bdbe248b32ba7c33cd968f5ab521e9d60e198f8a3f6c50e7d960a2b8f50375116be0db1fd44b5710ea758697d8ea70d15de";
            };
            Markdown-Manual = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/nPQ9xkPg/versions/WahW4kDQ/markdown_manual-MC1.20.1-fabric-1.2.5%2Bc3f0b88.jar";
              sha512 = "f90184856fb42f9c9e6b13bedf07ed286a7399323a363369abbb777b1374f0f51e4d4fc34abdcc1b14439a53edf12398d0e1027e7c785afd6f60d383203bdcf7";
            };
            Forge-Config-API-Port = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/ohNO6lps/versions/1aKtMQZE/ForgeConfigAPIPort-v8.0.2-1.20.1-Fabric.jar";
              sha512 = "c74fda4c25f42f182cae4ef2abaceb6992f14015a9b97570460c98f3cec15db6f7f2806f970efa1d10ffab62dd50257f8486cb586da129459225e3aa8db71ae0";
            };
            CreativeCore = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/OsZiaDHq/versions/pcUy2Oig/CreativeCore_FABRIC_v2.12.33_mc1.20.1.jar";
              sha512 = "14040744178fb87adafe525a7f2eda0512e1154b0c29e702265aa948dec9cc65bdc064f72d6f023907d321221e7fb5c1309ddcd6d96d419b1a0c46809fb6c7cc";
            };

            ###############
            ## Bugfixies ##
            ###############

            ###################
            ## Optimizations ##
            ###################
            Lithium = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/vuuAe7ZA/lithium-fabric-mc1.20.1-0.11.3.jar";
              sha512 = "dc9bc65146f41cf99c46b46216dd3645be7c45cfeb2bc7cdceaa11bcd57771cdf2c30e84ce057f12b8dbf0d54fb808143cf46d92626370011ba5112bec18e720";
            };

            ################
            ## Eyecandies ##
            ################
            ModernUI = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/3sjzyvGR/versions/X2Gc2jpP/ModernUI-Fabric-1.20.1-3.12.0.1-universal.jar";
              sha512 = "91f42e2a5f410e1a57aba48dca4c306ebd531526f3fbc4e9b193e0bce20378c7f48a4fb547fafad8a1cfee34426e7f9d9816d2e6070d0e443b3d62dd1cf91208";
            };

            #################
            ## Multiplayer ##
            #################
            # So Microsoft, FUCK YOU.
            No-Chat-Reports = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/qQyHxfxd/versions/HeZZR2kF/NoChatReports-FABRIC-1.20.1-v2.2.2.jar";
              sha512 = "3213e37fc12205e49f69a6c295c8c3237d8464d63dedbfbac4901892752741d22ebf7e1b40d6683143e70ca158fc95b00c2af177a1263038edce9a46b6cbeb79";
            };
            Show-Me-What-You-Got = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/jTUiUpsh/versions/fQQ8wvKT/ShowMeWhatYouGot-1.20-1.1.1.jar";
              sha512 = "af08c3e83f885f51a5d881cf71a376790e7b20f43e488f3622a5280a1bf6d038d0abce0490813252d525af17f635fa8102e890276c9035c70c4663650f8db069";
            };
            TeaBridge = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/fhtWl3kP/versions/eDlnpfHd/teabridge-1.2.3-mc1.20.1-rev.e345de2.jar";
              sha512 = "fea739b73b4d8981eaed3859162622368e3da57eb94c2a34a4ec94a655f0199bdb834914b567b31290fed0e6de766edb2cd6c3eb479fa68e37a5fe83b97058c8";
            };

            ################
            ## Multimedia ##
            ################
            WATERMeDIA = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/G922NeHS/versions/uJgGeNEY/watermedia-2.1.33.jar";
              sha512 = "6828136316a8077f9ad18d9ea88dddf9609c301ef7dc31dcb2e0ade8637ca45c36131d829441206651c705de8587696e8047bf8091064e030457517192735fd1";
            };
            WATERFrAMES = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/eBzFuVTM/versions/OIroJuKI/waterframes-FABRIC-mc1.20.1-v2.1.12c.jar";
              sha512 = "3bb81abf53f4080ead4326623b671ff7236ff86cf34967b47f79a64a8c1fc8cda41cfab854adae77a016eeb0228c1b8c525f916b5798d70330c10246a8d34042";
            };
            # Video-Player = pkgs.fetchurl {
            #   url = "https://cdn.modrinth.com/data/sSAANV7f/versions/jVVnUOPF/VideoPlayer-3.0.5-FABRIC-1.20.X-3.0.5.jar";
            #   sha512 = "89b2d0b8dc58862d7eaba62b43fd99e01ca4c680ebd08aac4264b3ed4fd532deba722ff9e64eab484e2a75eb372ddc1a19c628d7223563fecf65a9ba2da817e5";
            # };

            ##############
            ## Computer ##
            ##############
            TIS-3D = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/L23x7zL8/versions/CLM8Bo4w/tis3d-MC1.20.1-fabric-1.7.7%2B354a583.jar";
              sha512 = "61f6917df75c176c417d4325d3c6a5d0bf419c9f3770a73413c1d98c0527d6aee41fc3d731fb814dc18ea46c38c52a7432d0567fbe8e75317c704dce79b96537";
            };
            Computer-Craft-Tweaked = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/gu7yAYhd/versions/CYNo3gyS/cc-tweaked-1.20.1-fabric-1.116.1.jar";
              sha512 = "7d8a40bd5eaa3c04cd6e7108e3341cd5a675981427e2c2f954e2875a0bf7ea8ebec1fbad989f966504e77289deac3770ff0174d78aee31f8e10b64e61eceb8c0";
            };
            Plethora-Peripherals = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/LDfFdCXe/versions/d30CtSG0/Plethora-Fabric-1.12.0.jar";
              sha512 = "c8c5963a844619c038917b399e12aa14ffbbab480c6103873e44526188fca29d71d2ff932a4587e2bb463288a2e1431c74681bc617af786d525232042989018b";
            };
            CC-C-Bridge = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/fXt291FO/versions/xmxP9wDw/cccbridge-mc1.20.1-v1.7.0-fabric.jar";
              sha512 = "edd3a50af7d83cbe0f5583fbc250de36909b05921aef98c646241e5685cadd4ed0ad72e31f73eb5766f4ba789b495ae8c26f757c07e1f9cb108bb3270b384332";
            };
            Tom's-Peripherals = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/ljgxd2P8/versions/45JnCEaJ/toms_peripherals_fabric-1.20.1-1.3.0.jar";
              sha512 = "c9e797908349ff400872d1a3d5457c3ac9c141b78c1a780aec91de61d102940f4fa6ff5f91d9ed2800074f5ea711b680ee8d2a8bab3badc2bb79fb97eb7d9602";
            };
            Ducky-Peripherals = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/l2IpK3Ji/versions/FYDI2Gut/duckyperiphs-1.20.1-1.3.1-fabric.jar";
              sha512 = "dbefdf44def2db076c1f5394ad62427e511d926ed12e4adf57b683d2ff1a1e5d0a95a4a94272f4bbafdb24c373eb1c7dba364937993f323d3996629da0bb0acd";
            };

            #########
            ## Hex ##
            #########
            Hex-Casting = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/nTW3yKrm/versions/IvI9LKNc/hexcasting-fabric-1.20.1-0.11.2.jar";
              sha512 = "0587997cf75cc8ffc7c7f10e10ccd856a683f6e2bd7433f66a0e9d6e4b3ae143fd26be62d459580e48a241e34cd6d3adc0d1407ec3717d7d6751cd59a45385b6";
            };
            Hexy-Dimensions = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/P7dNk96I/versions/pSfTHr1z/hexxy-dimensions-1.3.0.jar";
              sha512 = "03850605f43614ad417038798690f0bc1439b8a2ef805357d5f8a57d8e99d686f9ab52344c658f6c95095d0d9a395d8b558a49edb8b45dbeb4cfa117ae892ecf";
            };
            HexTweaks = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/pim6pG9O/versions/2zFKvdL9/hextweaks-5.3.3.jar";
              sha512 = "56628a9bf870c28dbd6a93152f033dc54f084a3222f0d59a06c147d3096a4fd30dbdc21d0c847609dda21a8582b62279c9a24808fd5a1e49211f8822271e42e4";
            };
            HexFlow = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/MRC1BQpK/versions/e2W72Zb1/hexFlow-fabric-1.20.1-0.2.1.1.jar";
              sha512 = "c748a77292f61400d773c7c07375af781bc027022741fc0ac126efee29f8335cc8570a4c60bc3191eb3f6116a882584ea47bbe0a9ee752cdbb7c6308f784169c";
            };
            HexOverpowered = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/PkhtCPsD/versions/xa4p46bH/HexOverpowered-fabric-1.20.1-0.8.2.jar";
              sha512 = "e48636fab5e7901178069c66bed7c7dfc7936f594d8b1a2318c5a88308502b4cbab4e2f100643e44e8102f904994090899129f7cbdb5ddc08f75300a3194d511";
            };
            Hexcassettes = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Y7OyTnxi/versions/4Ml342F0/hexcassettes-1.1.4.jar";
              sha512 = "c778865fd2726afaa95858845c58c19cebdb2d06c3aeffce3c7b9384daa97aef70a4a367b16a013df7cee0ca251c939eb19f4af7e6adb90c8b7ca1f3dbdefde7";
            };
            Hexcellular = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/mN6t9Bt4/versions/jiKc4UJz/hexcellular-1.0.4.jar";
              sha512 = "107e50e80f49d2344b5790c762c08ac9cb11baf36e20a116432903cfd3c3b35b8a5a80020a391d6480e758c78d15f78795a64b23b392359522986c0e34afe5bb";
            };
            HexParse = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/WjFyIzFj/versions/NholTciJ/hexParse-fabric-1.20.1-1.3.0.jar";
              sha512 = "8a5ff90c1b911f5476f6ecaf661904a0155a2d65a7c9cfda12c1696be6c9a221aebeac1a84041384e3d0045b538a12c4b2bc282a2123cac1c4e7793fcc97af07";
            };

            #############
            ## Botania ##
            #############
            Botania = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/pfjLUfGv/versions/X2tY0LhB/Botania-1.20.1-450-FABRIC.jar";
              sha512 = "58a5fea90acec93f216acc97e4d487bcea47a5a772e9a6ba1101f73c62f0ae6a477ebfefe840cc7d1ae9ee6b9a536c0c8d0326d48b0d6276bc12276797cd5171";
            };

            ############
            ## Create ##
            ############
            Create = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/Xbc0uyRg/versions/7Ub71nPb/create-fabric-0.5.1-j-build.1631%2Bmc1.20.1.jar";
              sha512 = "73ff936492c857ae411c10cae0194d64a56b98a1a7a9478ca13fe2a6e3ee155e327cf4590a3888aaa671561b4cf74de97f2f44224d7981b03a546e36236c3de2";
            };
            # Some Addons?

            ################
            ## Equipments ##
            ################
            Traveler's-Backpack = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/rlloIFEV/versions/lnzLVA1W/travelersbackpack-fabric-1.20.1-9.1.38.jar";
              sha512 = "2c5e7348d2c9990bf25517a44c9baa0488b76e8fe5d0b5492e92189797d7725913b46d644b0dfe7587b55e03404d9770bc7ea945c626299e4ecd88aa0e04d067";
            };

            ##################
            ## Enhancements ##
            ##################
            Chest-Cavity = pkgs.fetchurl {
              url = "https://cdn.modrinth.com/data/eo1wLeXR/versions/rtvJdDF9/chestcavity-2.17.1.jar";
              sha512 = "9c05eb5800510ea3c53bb7537d3478fbf887508fccbb1329742f179aae18538782b99e8acdbe5a3f2eda87e169a013fedeff81e5b64b3f83f3b2fa364c46c183";
            };

          }
        );
      };
    };
  };
}
