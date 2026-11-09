{ lib, ... }:

{
  # The shared Niri preset contains output names for one developer's displays.
  # Let each installed machine detect its own displays instead.
  programs.niri.settings.outputs = lib.mkForce { };
  programs.niri.settings.screenshot-path =
    lib.mkForce "~/Pictures/Screenshots/Screenshot_%Y-%m-%d %H-%M-%S.png";
}
