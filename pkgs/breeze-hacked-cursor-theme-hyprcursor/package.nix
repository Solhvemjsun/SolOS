{
  stdenvNoCC,
  breeze-hacked-cursor-theme,
  hyprcursor,
  xcur2png,
}:

stdenvNoCC.mkDerivation {
  inherit (breeze-hacked-cursor-theme) pname version;

  src = breeze-hacked-cursor-theme;

  nativeBuildInputs = [
    hyprcursor
    xcur2png
  ];

  buildPhase = ''
    runHook preBuild

    pushd share/icons
    hyprcursor-util --extract Breeze_Hacked
    substituteInPlace extracted_*/manifest.hl \
      --replace-fail "Extracted Theme" "Breeze Hacked" \
      --replace-fail "Automatically extracted with hyprcursor-util" "KDE Plasma Cursor Theme" \
      --replace-fail "version = 0.1" "version = $version"
    hyprcursor-util --create extracted_*
    popd

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons
    cp -r share/icons/Breeze_Hacked $out/share/icons
    cp -r share/icons/theme_*/* $out/share/icons/*/

    runHook postInstall
  '';
}
