local wezterm = require("wezterm")

local fonts = {
	caskaydia_cove = "CaskaydiaCove Nerd Font Mono",
	comic_mono = "ComicMono Nerd Font Mono",
	fira_code = "FiraCode Nerd Font Mono",
	iosevka_fixed = "Iosevka Fixed",
	roboto_mono = "RobotoMono Nerd Font Mono",
}
local font = fonts.fira_code

local weights = {
	thin = "Thin",
	extra_light = "ExtraLight",
	light = "Light",
	demi_light = "DemiLight",
	book = "Book",
	regular = "Regular",
	medium = "Medium",
	demi_bold = "DemiBold",
	bold = "Bold",
	extra_bold = "ExtraBold",
	black = "Black",
	extra_black = "ExtraBlack",
}
local font_weight = weights.regular

return {
	-- font
	font = wezterm.font(font, { weight = font_weight, italic = false }),
	font_rules = {
		{
			intensity = "Bold",
			font = wezterm.font(font, { weight = font_weight }),
		},
	},
	font_size = 11.5,

	-- tab bar
	use_fancy_tab_bar = false,
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,

	window_decorations = "NONE",
	default_cursor_style = "BlinkingBar",
	force_reverse_video_cursor = true,
	color_schemes = {
		["Catppuccin Mocha Black"] = require("lua.colorschemes.catppuccin-mocha-black"),
	},
	color_scheme = "Catppuccin Mocha Black",
}
