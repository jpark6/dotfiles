-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- Set default program to WSL If OS is Windows 
if wezterm.target_triple:find("windows") then
  config.default_prog = { "wsl.exe" }
end

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- Set padding in pixels
config.window_padding = {
  left = 5,
  right = 5,
  top = 5,
  bottom = 0,
}

config.window_background_opacity = 0.65
config.win32_system_backdrop = 'Tabbed' -- "Acrylic", 'Mica', 'Tabbed'
config.macos_window_background_blur = 20

config.text_background_opacity = 1.0

-- or, changing the font size and color scheme.
config.font = wezterm.font("Hack Nerd Font", {italic = false})
config.font_size = 14
config.color_scheme = "zenburned"

config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.keys = {
  -- Ctrl-Tab -> send to tmux as Ctrl-b n (next-window)
  {
    key = "Tab",
    mods = "CTRL",
    action = wezterm.action.SendString("\x01n"), -- Ctrl-a (0x01) + n
  },
  -- Ctrl-Shift-Tab -> send to tmux as Ctrl-b p (previous-window)
  {
    key = "Tab",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SendString("\x01p"), -- Ctrl-a (0x01) + p
  },
}
-- Finally, return the configuration to wezterm:
return config
