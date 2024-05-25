local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.window_background_opacity = 1.0

config.window_padding = {
    left = 3,
    right = 0,
    top = 1,
    bottom = 0,
}

config.enable_wayland = true

local fonts = {
    blex_mono = {
        name = 'BlexMono Nerd Font Mono',
        size = 12.0,
        cell_width = 0.9,
        line_height = 0.9,
    },
    cascadia_code = {
        name = 'Cascadia Code NF',
        size = 12.0,
        cell_width = 1.0,
        line_height = 1.0,
    },
    comic_mono = {
        name = 'ComicMono Nerd Font Mono',
        size = 12.0,
        cell_width = 1.0,
        line_height = 1.0,
    },
    consolas = {
        name = 'Consolas Nerd Font Mono',
        size = 13.0,
        cell_width = 1.0,
        line_height = 0.9,
    },
    fira_code = {
        name = 'FiraCode Nerd Font Mono',
        size = 11.0,
        cell_width = 0.8,
        line_height = 0.9,
    },
    geist_mono = {
        name = 'GeistMono Nerd Font Mono',
        size = 12.0,
        cell_width = 0.9,
        line_height = 0.9,
    },
    hack = {
        name = 'Hack Nerd Font Mono',
        size = 12.0,
        cell_width = 1.0,
        line_height = 1.0,
    },
    iosevka = {
        name = 'IosevkaFixed Nerd Font Mono',
        size = 11.7,
        cell_width = 1.0,
        line_height = 0.9,
    },
    jetbrains_mono = {
        name = 'JetBrainsMono Nerd Font Mono',
        size = 11.0,
        cell_width = 0.8,
        line_height = 0.9,
    },
    roboto_mono = {
        name = 'RobotoMono Nerd Font Mono',
        size = 11.0,
        cell_width = 1.0,
        line_height = 0.9,
    },
}

local font = fonts.jetbrains_mono

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
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        },
    },
}

config.colors = {
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
}

local icons = {
    ['bash'] = '  ',
    ['cmd'] = '  ',
    ['go'] = '  ',
    ['java'] = '  ',
    ['lua'] = '  ',
    ['powershell'] = ' 󰨊 ',
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
        return get_icon(title) .. tab_info.tab_id .. ':' .. title .. ' '
    end

    return get_icon(tab_info.active_pane.title)
        .. tab_info.tab_id
        .. ':'
        .. tab_info.active_pane.title
        .. ' '
end

wezterm.on(
    'format-tab-title',
    function(tab, tabs, panes, config, hover, max_width)
        local title = tab_title(tab)
        if tab.is_active then
            return {
                { Background = { Color = '#9EBC9F' } },
                { Foreground = { Color = '#111111' } },
                { Text = title },
            }
        end

        return {
            { Background = { Color = '#111111' } },
            { Foreground = { Color = '#585858' } },
            { Text = title },
        }
    end
)

return config
