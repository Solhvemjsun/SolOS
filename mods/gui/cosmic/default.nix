{ ... }:

{
  services.desktopManager.cosmic.enable = true;
  services.system76-scheduler.enable = true;
  # Enable cross window clipboard
  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
  # Disable libadwaita theming for Firefox
  programs.firefox.preferences = {
    "widget.gtk.libadwaita-colors.enabled" = false;
  };
}
