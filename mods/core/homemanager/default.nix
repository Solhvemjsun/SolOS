{ ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    sharedModules = [
      ./home.nix
    ];
  };
}
