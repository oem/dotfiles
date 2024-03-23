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
config.font_size = 12.0

config.color_scheme = "Catppuccin Mocha"

config.audible_bell = "Disabled"
config.window_close_confirmation = "NeverPrompt"

-- keys
config.keys = {
    {
        key = 'f',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ToggleFullScreen
    },
    {
        key = 'r',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ReloadConfiguration,
    },
}

config.cursor_blink_rate = 800

-- window styling

config.hide_tab_bar_if_only_one_tab = true
config.enable_scroll_bar = false

config.window_padding = {
    left = 30,
    right = 30,
    bottom = 10,
    top = 10
}

config.window_background_opacity = 1

return config
