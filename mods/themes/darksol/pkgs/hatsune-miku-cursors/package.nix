{
  stdenvNoCC,
  fetchFromGitHub,
  hyprcursor,
  xcur2png,
  unstableGitUpdater,
}:

stdenvNoCC.mkDerivation {
  name = "hatsune-miku-cursors";
  version = "0-unstable-2024-04-13";

  src = fetchFromGitHub {
    owner = "supermariofps";
    repo = "hatsune-miku-windows-linux-cursors";
    rev = "24bbed734c17bc19516b939ee10203b229513d2a";
    hash = "sha256-m5CDmAATxtQgjV5Ij+5bF3QQ8Na3pXPNmQUtwHwwWFc=";
  };

  nativeBuildInputs = [
    hyprcursor
    xcur2png
  ];

  buildPhase = ''
    runHook preBuild

    rm -v miku-cursor-linux/cursors/{'ibeam_(old)','text_(old)'}
    hyprcursor-util --extract miku-cursor-linux
    substituteInPlace extracted_*/manifest.hl \
      --replace-fail "Extracted Theme" "Miku Cursor" \
      --replace-fail "Automatically extracted with hyprcursor-util" "Miku Cursors for Linux!" \
      --replace-fail "version = 0.1" "version = $version"
    hyprcursor-util --create extracted_*

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons/miku-cursor
    cp -r miku-cursor-linux/* $out/share/icons/miku-cursor
    cp -r theme_*/* $out/share/icons/miku-cursor

    runHook postInstall
  '';

  passthru = {
    updateScript = unstableGitUpdater { };
  };
}
