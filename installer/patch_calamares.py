#!/usr/bin/env python3
"""Apply the small SolOS delta to the pinned NixOS Calamares job."""

from pathlib import Path
import sys


def replace_once(source: str, old: str, new: str) -> str:
    count = source.count(old)
    if count != 1:
        raise RuntimeError(f"expected one patch anchor, found {count}: {old[:70]!r}")
    return source.replace(old, new, 1)


def main() -> None:
    if len(sys.argv) != 3:
        raise SystemExit("usage: patch_calamares.py MAIN_PY PREPARE_TARGET_BIN")

    main_py = Path(sys.argv[1])
    prepare_target = sys.argv[2]
    source = main_py.read_text(encoding="utf-8")

    source = replace_once(
        source,
        '    status = _("Installing NixOS")\n',
        f'''    # Keep the upstream partition, hardware and password handling. Prepare
    # the SolOS flake from the configuration that this job just generated.
    desktop = gs.value("packagechooser_packagechooser")
    username = gs.value("username")
    if desktop not in ("niri", "kde", "cosmic") or not username:
        return (_("SolOS selection is incomplete"), _("Choose a desktop and user."))

    try:
        subprocess.check_output(
            ["pkexec", {prepare_target!r}, root_mount_point, desktop, username],
            stderr=subprocess.STDOUT,
        )
    except subprocess.CalledProcessError as e:
        message = e.output.decode("utf8", errors="replace")
        libcalamares.utils.error(message)
        return (_("SolOS configuration failed"), _(message))

    status = _("Installing SolOS")
''',
    )
    source = replace_once(
        source,
        '            "nixos-install",\n            "--no-root-passwd",\n',
        '''            "nixos-install",
            "--flake",
            "path:{}/etc/nixos#SolOSInstalled".format(root_mount_point),
            "--no-root-passwd",
''',
    )

    main_py.write_text(source, encoding="utf-8")


if __name__ == "__main__":
    main()
