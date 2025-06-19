-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.font = wezterm.font_with_fallback {
    { family = "Berkeley Mono",          weight = "Black" },
    { family = "FiraCode Nerd Font Mono" },
}

config.font_size = 16.0
config.line_height = 1.2

local custom_theme = wezterm.color.get_builtin_schemes()['Pop (base16)']
custom_theme.background = 'black'
config.color_schemes = {
    ["Custom Theme"] = custom_theme
}
config.color_scheme = 'Custom Theme'

config.window_background_opacity = 1
config.window_decorations = 'RESIZE'

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

config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 800

-- window styling
config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.enable_scroll_bar = false

config.window_padding = {
    left = 30,
    right = 30,
    bottom = 30,
    top = 30
}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config.max_fps = 240
    config.default_prog = { 'wsl.exe', '--distribution', 'archlinux', '--cd', '~' }
end

return config
