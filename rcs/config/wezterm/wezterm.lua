-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = {}

-- Appearance
config.font = wezterm.font_with_fallback {
  "JetBrains Mono",
  "Nerd Font Symbols"
}
config.font_size = 16.0
config.color_scheme = "One Dark (Gogh)"
config.window_background_opacity = 1.0

-- Initial state
config.initial_rows = 30
config.initial_cols = 130
config.default_cwd = wezterm.home_dir .. "/profile"
config.default_prog = { "tmux" }

-- Updates
config.check_for_updates = true
config.check_for_updates_interval_seconds = 86400 -- Every 24 hours

-- Don't prompt when closing the window
config.window_close_confirmation = "NeverPrompt"

-- finally, return the configuration to wezterm
return config
