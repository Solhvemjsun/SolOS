{ config, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "zyan-itx";

  boot.loader.grub.configurationLimit = 2;

  hardware.nvidia.package = lib.mkForce config.boot.kernelPackages.nvidiaPackages.latest;
  hardware.nvidia-container-toolkit.enable = true;

  fileSystems."/run/media/szy/DATA" = {
    device = "/dev/disk/by-uuid/8CF85573F8555C90";
    fsType = "ntfs-3g";
    options = [
      "uid=1000"
      "gid=100"
      "umask=022"
      "windows_names"
      "nofail"
      "x-systemd.device-timeout=10s"
    ];
  };
}
