local wezterm = require("wezterm")
local font = require("lua.font")

return {
    -- font
    font = wezterm.font(font.name, { weight = font.weight, italic = false }),
    font_rules = {
        {
            intensity = "Bold",
            font = wezterm.font(font.name, { weight = font.weight }),
        },
    },
    font_size = font.size,

    -- tab bar
    use_fancy_tab_bar = false,
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = true,

    window_background_opacity = 0.9,
    window_decorations = "NONE",
    default_cursor_style = "BlinkingBar",
    force_reverse_video_cursor = true,
    color_schemes = {
        ["Catppuccin Mocha Black"] = require("lua.colorschemes.catppuccin-mocha-black"),
    },
    color_scheme = "Catppuccin Mocha Black",
}
