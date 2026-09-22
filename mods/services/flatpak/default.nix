{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    warehouse
    cosmic-store
  ];
  services.flatpak = {
    enable = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    packages = [
      "com.github.tchx84.Flatseal"
    ];
  };
}
