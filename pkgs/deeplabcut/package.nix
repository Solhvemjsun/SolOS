{
  config,
  lib,
  dream2nix,
  ...
}:

{
  imports = [
    dream2nix.modules.dream2nix.pip
  ];

  deps =
    { nixpkgs, ... }:
    {
      python = nixpkgs.python310;
      tbb = nixpkgs.tbb_2021_11;
      inherit (nixpkgs)
        atk
        cairo
        cups
        dbus
        fetchFromGitHub
        fontconfig
        freetype
        gst_all_1
        gtk3
        krb5
        libdrm
        libxkbcommon
        pango
        pcsclite
        qt6
        wayland
        xorg
        ;
    };

  name = "deeplabcut";
  version = "2.3.11-unstable-2025-03-25";

  mkDerivation = {
    # NOTE udpate pip.requirementsList when updating src
    src = config.deps.fetchFromGitHub {
      owner = "DeepLabCut";
      repo = "DeepLabCut";
      rev = "0f893b12ad2ef963fc0fe18be228c0a364b04a28";
      hash = "sha256-zvGPZVKVxl4259U4yOnnU43sr18Lr7AKZcF2jzXQdR8=";
    };
  };

  buildPythonPackage = {
    pythonImportsCheck = [ config.name ];
  };

  pip = {
    pipVersion = "24.3.1";

    # NOTE cuda versions of torch and your gpu driver have to be compatible
    # to use another cuda version, say 12.1, add the following config and
    # change the dependency "torch>=2.0.0" to "torch-2.5.1+cu121"
    # pipFlags = [ "--extra-index-url" "https://download.pytorch.org/whl/cu121" ];

    # we manually list dependencies declared in setup.py
    # to workaround https://github.com/nix-community/dream2nix/issues/745
    flattenDependencies = true;
    requirementsList = [
      "albumentations<=1.4.3"
      "dlclibrary>=0.0.7"
      "einops"
      "dlclibrary>=0.0.6"
      "filterpy>=1.4.4"
      "ruamel.yaml>=0.15.0"
      "imgaug>=0.4.0"
      "imageio-ffmpeg"
      "numba>=0.54"
      "matplotlib>=3.3,<3.9,!=3.7.0,!=3.7.1"
      "networkx>=2.6"
      "numpy>=1.18.5"
      "pandas>=1.0.1,!=1.5.0"
      "scikit-image>=0.17"
      "scikit-learn>=1.0"
      "scipy>=1.4,<1.11.0"
      "statsmodels>=0.11"
      "tables==3.8.0"
      "timm"
      "torch>=2.0.0"
      "torchvision"
      "tqdm"
      "pycocotools"
      "pyyaml"
      "Pillow>=7.1"

      # gui
      "pyside6==6.4.2"
      "qdarkstyle==3.1"
      "napari-deeplabcut>=0.2.1.6"

      # modelzoo
      "huggingface_hub"

      # wandb
      "wandb"

      # tf
      "tensorflow>=2.0,<=2.10;platform_system=='Windows'"
      "tensorflow>=2.0,<=2.12;platform_system!='Windows'"
      "tensorpack>=0.11"
      "tf_slim>=1.1.0"
    ];
    overrides = {
      torch = {
        mkDerivation = {
          # skip pythonRelaxDepsHook hook
          # to workaround the following error for torch wheels from https://download.pytorch.org
          #   error: Missing torch-2.5.1.dist-info/RECORD file
          postBuild = ''
            pythonRelaxDepsHook() { : ; }
          '';
        };
      };
      tensorflow-io-gcs-filesystem = {
        # to break circular dependency, do not patch libtensorflow_framework.so
        # add libtensorflow_framework.so to LD_LIBRARY_PATH in devShell instead
        env.autoPatchelfIgnoreMissingDeps = [ "libtensorflow_framework.so*" ];
      };
      numba = {
        mkDerivation.buildInputs = [ config.deps.tbb ];
      };
      pyside6-essentials = {
        mkDerivation.buildInputs = with config.deps; [
          atk
          cairo
          cups
          dbus
          fontconfig
          freetype
          gtk3
          krb5
          libdrm
          libxkbcommon
          pango
          qt6.qt3d
          qt6.qtpositioning
          qt6.qtscxml
          qt6.qtvirtualkeyboard
          qt6.qtwebengine
          wayland
          xorg.libxcb
        ];
        env = {
          dontWrapQtApps = true;
          autoPatchelfIgnoreMissingDeps = [ "libmysqlclient.so*" ];
        };
      };
      pyside6-addons = {
        mkDerivation.buildInputs = with config.deps; [
          gst_all_1.gst-plugins-base
          gst_all_1.gstreamer
          pcsclite
          qt6.qtmultimedia
        ];
        env = {
          dontWrapQtApps = true;
        };
      };
    };
  };
}
