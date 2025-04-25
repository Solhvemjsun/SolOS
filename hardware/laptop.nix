{ config, lib, pkgs, ... }:

{
  #############
  ## DRIVERS ##
  #############

  services.libinput.enable = true; # Enable touchpad

  services.fprintd.enable = true; # Enable fingerprint reader

  ######################
  ## POWER MANAGEMENT ##
  ######################

  powerManagement.enable = true;

  services.thermald.enable = true; # Prevents CPU from overheating

  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        energy_pref_bias = "balance_power";
        platform_profile = "balanced";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        energy_pref_bias = "balance_performance";
        platform_profile = "performance";
        turbo = "auto";
      };
    };
  };

}
