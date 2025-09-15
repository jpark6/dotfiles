-- Pull in the wezterm API
local wezterm = require "wezterm"

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

config.enable_wayland = false
config.hide_mouse_cursor_when_typing = false
-- Set default program to WSL If OS is Windows 
if wezterm.target_triple:find("windows") then
  config.default_prog = { "wsl.exe", "~" }
  -- config.default_prog = { "pwsh.exe" }
  config.launch_menu = {
  {
  label = "PowerShell 7",
  args = { "pwsh.exe", "-NoLogo" },
    },
    {
      label = "Windows PowerShell",
      args = { "powershell.exe", "-NoLogo" },
    },
  }
end

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- Set padding in pixels
config.window_padding = {
  left = 3,
  right = 3,
  top = 3,
  bottom = 3,
}

config.default_cursor_style = 'SteadyBlock' -- SteadyBlock, BlinkingBlock, SteadyUnderline, BlinkingUnderline, SteadyBar, and BlinkingBar
config.cursor_blink_rate = 500
config.enable_kitty_graphics = true
-- config.cursor_blink_ease_in = "easeIn"
-- config.cursor_blink_ease_out = "easeOut"

config.window_background_opacity = 0.92
-- config.win32_system_backdrop = 'Acrylic' -- "Acrylic", 'Mica', 'Tabbed'
config.macos_window_background_blur = 40

config.text_background_opacity = 1.0

-- or, changing the font size and color scheme.
-- config.font = wezterm.font("JetBrainsMonoNerdFont", {italic = false})
config.font = wezterm.font_with_fallback {
  "CaskaydiaCove Nerd Font",
  "Noto Sans CJK KR",
}
config.font_size = 10
config.color_scheme = "Snazzy (base16)"

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
