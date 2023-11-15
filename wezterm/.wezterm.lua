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

config.color_scheme = "Tokyo Night Storm"

config.audible_bell = "Disabled"

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