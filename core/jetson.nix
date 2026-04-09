{ pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.nvidia-jetpack.enable = true;

  networking.hostName = "orin-nano";
  networking.networkmanager.enable = true;

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3Nza... your-ssh-key"
    ];
  };

  services.openssh.enable = true;
  system.stateVersion = "24.05";
}
