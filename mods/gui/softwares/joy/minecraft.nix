{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    prismlauncher
    zulu8
  ];

  environment.variables = {
    JAVA_HOME = pkgs.jdk21;
  };
}
