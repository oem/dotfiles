-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.font = wezterm.font { family = "Berkeley Mono", weight = "Bold" }
config.font_size = 15.0

-- colors
config.colors = {
    foreground = '#c0caf5',
    background = '#24283b',
    ansi = {
        '#1D202F',
        '#f7768e',
        '#9ece6a',
        '#e0af68',
        '#7aa2f7',
        '#bb9af7',
        '#7dcfff',
        '#a9b1d6',
    },
    brights = {
        '#414868',
        '#f7768e',
        '#9ece6a',
        '#e0af68',
        '#7aa2f7',
        '#bb9af7',
        '#7dcfff',
        '#c0caf5',
    },
    cursor_bg = 'orange',
}

-- keys
config.keys = {
    {
        key = 'f',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ToggleFullScreen

    }
}

config.cursor_blink_rate = 800

-- window styling

config.hide_tab_bar_if_only_one_tab = true

config.enable_scroll_bar = false

config.window_padding = {
    left = 30,
    right = 30,
    bottom = 30,
    top = 30
}

return config
