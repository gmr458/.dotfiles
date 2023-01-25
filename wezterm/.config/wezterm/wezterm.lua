local wezterm = require("wezterm")

local fonts = {
	caskaydia_cove = "CaskaydiaCove Nerd Font Mono",
	comic_mono = "ComicMono Nerd Font Mono",
	fira_code = "FiraCode Nerd Font Mono",
	iosevka_fixed = "Iosevka Fixed",
	roboto_mono = "RobotoMono Nerd Font Mono",
}

local font = fonts.caskaydia_cove

return {
	font = wezterm.font(font, { weight = "Regular", italic = false, bold = false }),
	font_rules = {
		{
			intensity = "Bold",
			font = wezterm.font(font, { weight = "Regular" }),
		},
	},
	font_size = 12.0,
	enable_tab_bar = false,
	window_decorations = "NONE",
	default_cursor_style = "BlinkingBar",
	force_reverse_video_cursor = true,
	color_schemes = {
		["Catppuccin Mocha Black"] = require("lua.colorschemes.catppuccin-mocha-black")
	},
	color_scheme = "Catppuccin Mocha Black",
}
