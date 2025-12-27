{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lmstudio
    ollama-rocm
    alpaca
  ];
}
