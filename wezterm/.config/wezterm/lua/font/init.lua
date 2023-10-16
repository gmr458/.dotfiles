local font_weight = {
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

local list_fonts = {
    caskaydia_cove = {
        name = "CaskaydiaCove Nerd Font Mono",
        weight = font_weight.regular,
        size = 10.5,
    },
    comic_mono = {
        name = "ComicMono Nerd Font Mono",
        weight = font_weight.regular,
        size = 11.6,
    },
    consolas = {
        name = "Consolas Nerd Font Mono",
        weight = font_weight.regular,
        size = 12.4,
    },
    fira_code = {
        name = "FiraCode Nerd Font Mono",
        weight = font_weight.regular,
        size = 11.5,
    },
    iosevka_fixed = {
        name = "Iosevka Fixed",
        weight = font_weight.regular,
        size = 12.0,
    },
    roboto_mono = {
        name = "RobotoMono Nerd Font Mono",
        weight = font_weight.regular,
        size = 10.5,
    },
}

local font = list_fonts.roboto_mono

return font
