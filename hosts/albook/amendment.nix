{ ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      slack = prev.runCommand "dummy-xterm" { } "mkdir $out";
    })
  ];
}
