from kittens.tui.handler import result_handler
from kitty.boss import Boss


def main():
    pass


directions = ["right", "left", "top", "bottom"]


@result_handler(no_ui=True)
def handle_result(args: list[str], result: str, target_window_id: int, boss: Boss):
    if len(args) == 2 and args[1] in directions:
        boss.active_tab.neighboring_window(args[1])
