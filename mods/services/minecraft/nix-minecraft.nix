{ ... }:

{
  # MCBUGUS Via nix-minecraft
  services.minecraft-servers = {
    enable = true;
    dataDir = "/srv/minecraft/";

    eula = true;
    openFirewall = true;
  };
}
