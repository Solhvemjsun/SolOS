{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hmcl
    temurin-bin-21
    temurin-bin-8
  ];

  environment.variables = {
    JAVA_HOME = pkgs.temurin-bin-21;
  };
}
