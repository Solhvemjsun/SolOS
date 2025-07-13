{ ... }:

{
  boot.loader.grub.memtest86.enable = true;

  services.smartd = {
    enable = true;
    devices = [
      {
        device = "/dev/disk/by-label/NIXROOT";
      }
    ];
  };
}
