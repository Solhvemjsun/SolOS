{
  config,
  name,
  lib,
  ...
}:

{
  home = {
    stateVersion = "24.05";
    username = lib.mkDefault name;
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
  };
}
