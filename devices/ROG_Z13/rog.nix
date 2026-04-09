{ lib, ... }:

{
  services.asusd = {
    enable = true;
  };

  programs.rog-control-center = {
    enable = true;
    autoStart = true;
  };

  # boot = {
  #   kernelModules = [ "asus_armoury" ];
  #   kernelPatches = [
  #     {
  #       name = "enable-asus-armoury";
  #       patch = null;
  #       structuredExtraConfig = with lib.kernel; {
  #         ASUS_ARMOURY = module;
  #       };
  #     }
  #   ];
  # };  
}
