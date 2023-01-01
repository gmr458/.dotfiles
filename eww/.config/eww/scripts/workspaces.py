#!/usr/bin/python

"""Workspaces script for Hyprland"""

import subprocess


def get_occupied_workspaces() -> list[str]:
    """Get occupied workspaces in Hyprland"""

    with subprocess.Popen(
        [
            "hyprctl",
            "workspaces",
        ],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    ) as process:
        index_workspaces: list[str] = []

        if process.stdout is not None:
            for line in process.stdout.readlines():
                line = line.decode("UTF-8")
                if "workspace ID" in line:
                    print(line)
                    index_workspaces.append(line[13])

        index_workspaces.sort()

        return index_workspaces


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


occupied_workspaces = get_occupied_workspaces()
focused_workspace = get_focused_workspace()

script_yuck = "(box :class 'workspaces' :orientation 'horizontal' :halign 'start' :spacing 4 "

for workspace in occupied_workspaces:
    class_button = "visible"

    print(workspace)

    if workspace == focused_workspace:
        class_button = "active"

    script_yuck += f"(button :class '{class_button}' :onclick 'hyprctl dispatch workspace {workspace}' '{workspace}')"

script_yuck += ")"

print(script_yuck)
