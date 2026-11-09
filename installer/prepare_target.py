#!/usr/bin/env python3
"""Copy the public SolOS flake and capture Calamares' generated target data."""

import json
from pathlib import Path
import re
import shutil
import sys


DESKTOPS = {"niri", "kde", "cosmic"}
USERNAME = re.compile(r"[a-z_][a-z0-9_-]*[$]?")
SOURCE = Path("/etc/solos-installer-source")


def copy_source(source: Path, target: Path) -> None:
    def ignore_private(directory: str, names: list[str]) -> set[str]:
        current = Path(directory)
        ignored = {".git", "result", "result-iso"}.intersection(names)
        if current == source / "mods" / "services":
            ignored.update({"SolOS_Private"}.intersection(names))
        return ignored

    shutil.copytree(source, target, dirs_exist_ok=True, ignore=ignore_private)


def prepare(root: Path, desktop: str, username: str, source: Path = SOURCE) -> None:
    if desktop not in DESKTOPS:
        raise ValueError(f"unsupported desktop: {desktop}")
    if not USERNAME.fullmatch(username):
        raise ValueError(f"invalid username: {username}")
    if not root.is_absolute() or root.resolve() == Path("/"):
        raise ValueError("target root must be an absolute mounted directory")
    if not source.is_dir() or not (source / "flake.lock").is_file():
        raise FileNotFoundError(f"SolOS installer source is missing: {source}")

    target = root / "etc" / "nixos"
    config = target / "configuration.nix"
    hardware = target / "hardware-configuration.nix"
    if not config.is_file() or not hardware.is_file():
        raise FileNotFoundError("Calamares did not generate the NixOS target config")

    generated_config = config.read_bytes()
    generated_hardware = hardware.read_bytes()
    copy_source(source, target)

    target_config = target / "installer" / "target"
    target_config.mkdir(parents=True, exist_ok=True)
    (target_config / "configuration.nix").write_bytes(generated_config)
    (target_config / "hardware-configuration.nix").write_bytes(generated_hardware)
    (target_config / "desktop.nix").write_text(json.dumps(desktop) + "\n", encoding="utf-8")
    (target_config / "username.nix").write_text(json.dumps(username) + "\n", encoding="utf-8")


def main() -> None:
    if len(sys.argv) != 4:
        raise SystemExit("usage: prepare_target.py ROOT DESKTOP USERNAME")
    prepare(Path(sys.argv[1]), sys.argv[2], sys.argv[3])


if __name__ == "__main__":
    main()
