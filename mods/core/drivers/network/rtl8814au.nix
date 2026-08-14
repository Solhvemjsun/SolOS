{ config, ... }:

{
  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtl8814au
  ];
}
