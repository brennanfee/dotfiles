-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = {}

-- Appearance
config.font = wezterm.font_with_fallback({
  { family="JetBrains Mono", weight="Regular" },
  { family="Symbols Nerd Font", scale = 0.75 },
  "Noto Color Emoji",
})
config.font_size = 16.0
config.adjust_window_size_when_changing_font_size = false
config.freetype_load_target = 'Light'

config.color_scheme = "OneHalfDark"
config.window_background_opacity = 1.0
config.window_decorations = "RESIZE"

config.bold_brightens_ansi_colors = "No"

config.colors = {
  brights = {
    '#282c34',
    '#e06c75',
    '#98c379',
    '#ff0000',
    '#61afef',
    '#c678dd',
    '#56b6c2',
    '#dcdfe4',
  },
}

config.font_rules = {
  {
    intensity = 'Bold',
    italic = false,
    font = wezterm.font_with_fallback({
      { family="JetBrains Mono", weight="ExtraBold", italic=false },
      { family="Symbols Nerd Font", scale = 0.75 },
      "Noto Color Emoji",
    }),
  },
  {
    intensity = 'Bold',
    italic = true,
    font = wezterm.font_with_fallback({
      { family="JetBrains Mono", weight="ExtraBold", italic=true },
      { family="Symbols Nerd Font", scale = 0.75 },
      "Noto Color Emoji",
    }),
  },
  {
    intensity = 'Half',
    italic = false,
    font = wezterm.font_with_fallback({
      { family="JetBrains Mono", weight="Thin", italic=false },
      { family="Symbols Nerd Font", scale = 0.75 },
      "Noto Color Emoji",
    }),
  },
  {
    intensity = 'Half',
    italic = true,
    font = wezterm.font_with_fallback({
      { family="JetBrains Mono", weight="Thin", italic=true },
      { family="Symbols Nerd Font", scale = 0.75 },
      "Noto Color Emoji",
    }),
  },
}

-- Initial state
config.initial_rows = 30
config.initial_cols = 130
config.default_cwd = wezterm.home_dir .. "/profile"
config.default_prog = { "tmux", "new-session", "-c", wezterm.home_dir .. "/profile" }

-- Turn off the tab bar, as I use tmux
config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

-- Updates
config.check_for_updates = true
config.check_for_updates_interval_seconds = 86400 -- Every 24 hours

-- Don't prompt when closing the window
config.window_close_confirmation = "NeverPrompt"

-- finally, return the configuration to wezterm
return config
