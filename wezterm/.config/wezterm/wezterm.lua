local wezterm = require 'wezterm'
local font = require 'lua.font'

return {
    enable_wayland = true,
    font = wezterm.font(font.name, { weight = font.weight, italic = false }),
    font_rules = {
        {
            intensity = 'Bold',
            font = wezterm.font(font.name, { weight = font.weight }),
        },
    },
    font_size = font.size,
}
