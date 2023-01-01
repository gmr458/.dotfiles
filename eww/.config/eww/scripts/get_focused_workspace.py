#!/usr/bin/python

"""Workspaces script for Hyprland"""

import subprocess

def get_focused_workspace() -> str:
    """Get focused workspace in Hyprland"""

    with subprocess.Popen(
        [
            "hyprctl",
            "monitors",
        ],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    ) as process:
        focused = "1"

        if process.stdout is not None:
            for line in process.stdout.readlines():
                line = line.decode("UTF-8")
                line = line.strip()
                if "active workspace:" in line:
                    focused = line[18]

        return focused


focused_workspace = get_focused_workspace()

print(focused_workspace)
