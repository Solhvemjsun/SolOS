{
  ###############
  ## RTL8814AU ##
  ###############

  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtl8814au
  ];

  services.create_ap = {
    enable = true;
    settings = {
      INTERNET_IFACE = "eno1";
      WIFI_IFACE = "wlp117s0f4u2";
      SSID = "Axazel";
      PASSPHRASE = ".Azazel.";
    };
  };

}
