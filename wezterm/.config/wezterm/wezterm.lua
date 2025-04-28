local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.window_background_opacity = 0.9

config.enable_wayland = true

local fonts = {
    blex_mono = {
        name = 'BlexMono Nerd Font Mono',
        size = 12.0,
        cell_width = 0.9,
        line_height = 0.9,
        padding = {
            left = 3,
            right = 0,
            top = 1,
            bottom = 0,
        },
    },
    cascadia_code = {
        name = 'Cascadia Code NF',
        size = 11.9,
        cell_width = 0.8,
        line_height = 1.0,
        padding = {
            left = 3,
            right = 0,
            top = 1,
            bottom = 0,
        },
    },
    comic_mono = {
        name = 'ComicMono Nerd Font Mono',
        size = 12.0,
        cell_width = 0.8,
        line_height = 1.0,
        padding = {
            left = 3,
            right = 0,
            top = 1,
            bottom = 0,
        },
    },
    consolas = {
        name = 'Consolas Nerd Font Mono',
        size = 13.0,
        cell_width = 0.8,
        line_height = 0.9,
        padding = {
            left = 3,
            right = 0,
            top = 1,
            bottom = 0,
        },
    },
    fira_code = {
        name = 'FiraCode Nerd Font Mono',
        size = 11.5,
        cell_width = 0.8,
        line_height = 1.0,
        padding = {
            left = 3,
            right = 0,
            top = 3,
            bottom = 0,
        },
    },
    geist_mono = {
        name = 'GeistMono Nerd Font Mono',
        size = 12.0,
        cell_width = 1.0,
        line_height = 1.0,
        padding = {
            left = 7,
            right = 0,
            top = 8,
            bottom = 0,
        },
    },
    hack = {
        name = 'Hack Nerd Font Mono',
        size = 11.0,
        cell_width = 0.8,
        line_height = 1.0,
        padding = {
            left = 3,
            right = 0,
            top = 1,
            bottom = 0,
        },
    },
    iosevka = {
        name = 'IosevkaFixed Nerd Font Mono',
        size = 11.0,
        cell_width = 1.0,
        line_height = 1.0,
        padding = {
            left = 2,
            right = 0,
            top = 4,
            bottom = 0,
        },
    },
    jetbrains_mono = {
        name = 'JetBrainsMono Nerd Font Mono',
        size = 11.7,
        cell_width = 0.8,
        line_height = 0.9,
        padding = {
            left = 3,
            right = 0,
            top = 3,
            bottom = 0,
        },
    },
    roboto_mono = {
        name = 'RobotoMono Nerd Font Mono',
        size = 11.0,
        cell_width = 0.8,
        line_height = 0.9,
        padding = {
            left = 3,
            right = 0,
            top = 1,
            bottom = 0,
        },
    },
}

local font = fonts.geist_mono

config.window_padding = {
    left = font.padding.left,
    right = font.padding.right,
    top = font.padding.top,
    bottom = font.padding.bottom,
}

config.font = wezterm.font(font.name, { weight = 'Regular' })
config.font_size = font.size
config.font_rules = {
    {
        intensity = 'Bold',
        font = wezterm.font(font.name, { weight = 'Regular' }),
    },
}
config.cell_width = font.cell_width
config.line_height = font.line_height
-- config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

config.default_cursor_style = 'SteadyUnderline'
config.cursor_thickness = '1px'

config.underline_position = '-1px'
config.underline_thickness = '1px'

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 20

wezterm.on('switch-to-left', function(window, pane)
    local tab = window:mux_window():active_tab()

    if tab:get_pane_direction 'Left' ~= nil then
        window:perform_action(wezterm.action.ActivatePaneDirection 'Left', pane)
    else
        window:perform_action(wezterm.action.ActivateTabRelative(-1), pane)
    end
end)

wezterm.on('switch-to-right', function(window, pane)
    local tab = window:mux_window():active_tab()

    if tab:get_pane_direction 'Right' ~= nil then
        window:perform_action(
            wezterm.action.ActivatePaneDirection 'Right',
            pane
        )
    else
        window:perform_action(wezterm.action.ActivateTabRelative(1), pane)
    end
end)

config.keys = {
    {
        key = 'h',
        mods = 'ALT',
        action = wezterm.action.EmitEvent 'switch-to-left',
    },
    {
        key = 'j',
        mods = 'ALT',
        action = wezterm.action.ActivatePaneDirection 'Down',
    },
    {
        key = 'k',
        mods = 'ALT',
        action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
        key = 'l',
        mods = 'ALT',
        action = wezterm.action.EmitEvent 'switch-to-right',
    },
    {
        key = 'n',
        mods = 'ALT',
        action = wezterm.action.SpawnTab 'CurrentPaneDomain',
    },
    {
        key = 'w',
        mods = 'ALT',
        action = wezterm.action.CloseCurrentPane { confirm = false },
    },
    {
        key = '|',
        mods = 'ALT',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = '-',
        mods = 'ALT',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'r',
        mods = 'ALT',
        action = wezterm.action.PromptInputLine {
            description = 'Enter new name for tab',
            action = wezterm.action_callback(function(window, _, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        },
    },
    {
        key = 'u',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.EmitEvent 'switch-background',
    },
}

wezterm.on('switch-background', function(window, _)
    local overrides = window:get_config_overrides() or {}

    if overrides.color_scheme == 'dark' then
        overrides.color_scheme = 'light'
        goto done
    elseif overrides.color_scheme == 'light' then
        overrides.color_scheme = 'dark'
        goto done
    end

    if overrides.color_scheme == 'black' then
        overrides.color_scheme = 'white'
        goto done
    elseif overrides.color_scheme == 'white' then
        overrides.color_scheme = 'black'
        goto done
    end

    ::done::
    window:set_config_overrides(overrides)
end)

config.color_schemes = {
    ['dark'] = {
        foreground = '#d8d8d8',
        background = '#0e0e0e',
        cursor_bg = '#d8d8d8',
        cursor_fg = '#000000',
        cursor_border = '#d8d8d8',
        selection_fg = '#000000',
        selection_bg = '#383838',
        ansi = {
            '#181818',
            '#AC4242',
            '#90A959',
            '#F4BF75',
            '#6A9FB5',
            '#AA759F',
            '#75B5AA',
            '#D8D8D8',
        },
        brights = {
            '#6B6B6B',
            '#C55555',
            '#AAC474',
            '#FECA88',
            '#82B8C8',
            '#C28CB8',
            '#93D3C3',
            '#F8F8F8',
        },
        tab_bar = {
            background = '#111111',
            new_tab = {
                bg_color = '#111111',
                fg_color = '#585858',
            },
            inactive_tab_hover = {
                bg_color = '#202020',
                fg_color = '#585858',
            },
            new_tab_hover = {
                bg_color = '#202020',
                fg_color = '#585858',
            },
        },
    },
    ['black'] = {
        foreground = '#EDEDED',
        background = '#000000',
        cursor_bg = '#EDEDED',
        cursor_fg = '#000000',
        cursor_border = '#EDEDED',
        selection_fg = '#000000',
        selection_bg = '#0F2F57',
        -- ansi = {
        --     '#000000',
        --     '#D93036',
        --     '#398E4A',
        --     '#FF990A',
        --     '#0062D1',
        --     '#763DA9',
        --     '#0D8C7D',
        --     '#EDEDED',
        -- },
        ansi = {
            '#000000',
            '#FF6166',
            '#62C073',
            '#FF990A',
            '#52A8FF',
            '#BF7AF0',
            '#0AC7B4',
            '#EDEDED',
        },
        brights = {
            '#454545',
            '#FF6166',
            '#62C073',
            '#FF990A',
            '#52A8FF',
            '#BF7AF0',
            '#0AC7B4',
            '#EDEDED',
        },
        tab_bar = {
            background = '#0A0A0A',
            new_tab = {
                bg_color = '#0A0A0A',
                fg_color = '#454545',
            },
            inactive_tab_hover = {
                bg_color = '#292929',
                fg_color = '#454545',
            },
            new_tab_hover = {
                bg_color = '#292929',
                fg_color = '#454545',
            },
        },
    },
    ['light'] = {
        background = '#ffffff',
        foreground = '#0e0e0e',
        cursor_fg = '#d8d8d8',
        cursor_bg = '#000000',
        cursor_border = '#000000',
        selection_fg = '#000000',
        selection_bg = '#C8C8C8',
        ansi = {
            '#181818',
            '#AC4242',
            '#90A959',
            '#F4BF75',
            '#6A9FB5',
            '#AA759F',
            '#75B5AA',
            '#D8D8D8',
        },
        brights = {
            '#6B6B6B',
            '#C55555',
            '#AAC474',
            '#FECA88',
            '#82B8C8',
            '#C28CB8',
            '#93D3C3',
            '#F8F8F8',
        },
        tab_bar = {
            background = '#C8C8C8',
            new_tab = {
                bg_color = '#C8C8C8',
                fg_color = '#585858',
            },
            inactive_tab_hover = {
                bg_color = '#202020',
                fg_color = '#585858',
            },
            new_tab_hover = {
                bg_color = '#202020',
                fg_color = '#585858',
            },
        },
    },
}

config.color_scheme = 'black'

local icons = {
    ['bash'] = '  ',
    ['cmd.exe'] = '  ',
    ['docker'] = ' 󰡨 ',
    ['go'] = '  ',
    ['java'] = '  ',
    ['ls'] = '  ',
    ['lsd'] = '  ',
    ['lua'] = '  ',
    ['powershell'] = ' 󰨊 ',
    ['psql'] = '  ',
    ['python'] = '  ',
    ['python2'] = '  ',
    ['python2.7'] = '  ',
    ['python3'] = '  ',
    ['python3.10'] = '  ',
    ['python3.11'] = '  ',
    ['python3.12'] = '  ',
    ['node-20'] = ' 󰎙 ',
    ['nvim'] = '  ',
    ['vim'] = '  ',
    ['zsh'] = '  ',
}

local function get_icon(key)
    local v = icons[key]
    if v ~= nil then
        return v
    end

    return ' '
end

local function tab_title(tab_info)
    local title = tab_info.tab_title
    if title and #title > 0 then
        return table.concat { get_icon(title), tab_info.tab_id, ':', title, ' ' }
    end

    return table.concat {
        get_icon(tab_info.active_pane.title),
        tab_info.tab_id,
        ':',
        tab_info.active_pane.title,
        ' ',
    }
end

wezterm.on('format-tab-title', function(tab, _, _, copy_config, _, _)
    local color_scheme = copy_config.color_scheme
    local color_schemes = copy_config.color_schemes

    local colors = {
        bg_inactive = color_schemes[color_scheme].tab_bar.background,
        fg_inactive = color_schemes[color_scheme].tab_bar.new_tab.fg_color,
        bg_active = color_schemes[color_scheme].ansi[3],
        fg_active = color_schemes[color_scheme].tab_bar.background,
    }

    local title = tab_title(tab)

    return {
        {
            Background = {
                Color = tab.is_active and colors.bg_active
                    or colors.bg_inactive,
            },
        },
        {
            Foreground = {
                Color = tab.is_active and colors.fg_active
                    or colors.fg_inactive,
            },
        },
        { Text = title },
    }
end)

return config
