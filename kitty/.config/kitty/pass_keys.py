"""The purpose of this script if for the
ctrl+hjkl to be executed in Neovim before
Kitty if Neovim is open, this allows for
better navigation between the Neovim and
Kitty windows"""

import re
from typing import List

from kittens.tui.handler import result_handler
from kitty.key_encoding import KeyEvent, parse_shortcut
from kitty.boss import Boss


def is_window_vim(window, vim_id):
    fp = window.child.foreground_processes
    print(fp)
    return any(
        re.search(
            vim_id,
            p["cmdline"][0] if len(p["cmdline"]) else "",
            re.I,
        )
        for p in fp
    )


def encode_key_mapping(window, key_mapping):
    mods, key = parse_shortcut(key_mapping)
    event = KeyEvent(
        mods=mods,
        key=key,
        shift=bool(mods & 1),
        alt=bool(mods & 2),
        ctrl=bool(mods & 4),
        super=bool(mods & 8),
        hyper=bool(mods & 16),
        meta=bool(mods & 32),
    ).as_window_system_event()

    return window.encoded_key(event)


def main(_: List[str]):
    pass


@result_handler(no_ui=True)
def handle_result(
    args: List[str],
    answer: str,
    target_window_id: int,
    boss: Boss,
) -> None:
    direction = args[1]
    key_mapping = args[2]
    vim_id = args[3] if len(args) > 3 else "n?vim"

    window = boss.window_id_map.get(target_window_id)

    if window is None:
        return
    if is_window_vim(window, vim_id):
        for keymap in key_mapping.split(">"):
            encoded = encode_key_mapping(window, keymap)
            window.write_to_child(encoded)
    else:
        boss.active_tab.neighboring_window(direction)
