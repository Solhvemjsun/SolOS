{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    google-chrome
  ];

  environment.sessionVariables.BROWSER = "google-chrome-stable";
}
