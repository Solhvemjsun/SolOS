{ pkgs, ... }:

{
  #########
  ## RGB ##
  #########

  services.hardware.openrgb.enable = true;
  hardware.i2c.enable = true;
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];

  ##########
  ## ASUS ##
  ##########

  services.asusd = {
    enable = true;
  };

  programs.rog-control-center = {
    enable = true;
    autoStart = true;
  };

  environment.systemPackages = with pkgs; [
    asusctl
  ];
}
