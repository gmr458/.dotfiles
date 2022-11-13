local wezterm = require("wezterm")

return {
	font = wezterm.font("Iosevka Fixed", { weight = "Regular", italic = false, bold = false }),
	font_rules = {
		{
			intensity = "Bold",
			font = wezterm.font("Iosevka Fixed", { weight = "Regular" }),
		},
	},
	font_size = 12.0,
	enable_tab_bar = false,
	window_decorations = "NONE",
	default_cursor_style = "BlinkingBar",
	force_reverse_video_cursor = true,
	color_scheme = "Catppuccin Mocha",
}
