import re

from kittens.tui.handler import result_handler
from kitty.key_encoding import KeyEvent, parse_shortcut

PASSTHROUGH = r"\b(vim|nvim|fzf)\b"


# Return True if any foreground process in the window matches PASSTHROUGH
def is_window_passthrough(window):

    fp = window.child.foreground_processes

    # Check if any argument in a process's cmdline matches PASSTHROUGH,
    # including when launched via wrappers or pipelines (e.g., "zoxide query | fzf")
    def is_process_passthrough(p):
        return any(re.search(PASSTHROUGH, arg, re.IGNORECASE) for arg in p["cmdline"])

    return any(is_process_passthrough(p) for p in fp)


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


def main():
    pass


@result_handler(no_ui=True)
def handle_result(args, result, target_window_id, boss):
    window = boss.window_id_map.get(target_window_id)
    direction = args[2]
    key_mapping = args[3]

    if window is None:
        return
    if is_window_passthrough(window):
        for keymap in key_mapping.split(">"):
            encoded = encode_key_mapping(window, keymap)
            window.write_to_child(encoded)
    else:
        boss.active_tab.neighboring_window(direction)
