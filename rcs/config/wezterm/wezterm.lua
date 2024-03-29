-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = {}

-- Fonts
config.font = wezterm.font_with_fallback({
  {
    family = "JetBrains Mono",
    weight = "Regular",
    assume_emoji_presentation = false,
  },
  { family = "Symbols Nerd Font" },
  { family = "Noto Color Emoji" },
})
config.font_size = 16.0
config.warn_about_missing_glyphs = false
config.adjust_window_size_when_changing_font_size = false
config.freetype_interpreter_version = 40
config.freetype_load_target = "Light"

config.bold_brightens_ansi_colors = "No"
config.use_cap_height_to_scale_fallback_fonts = true
config.strikethrough_position = "125%"
config.underline_thickness = "2px"

config.font_rules = {
  {
    intensity = "Bold",
    italic = false,
    font = wezterm.font_with_fallback({
      { family = "JetBrains Mono", weight = "ExtraBold", italic = false },
      { family = "Symbols Nerd Font" },
      { family = "Noto Color Emoji" },
    }),
  },
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font_with_fallback({
      { family = "JetBrains Mono", weight = "ExtraBold", italic = true },
      { family = "Symbols Nerd Font" },
      { family = "Noto Color Emoji" },
    }),
  },
  {
    intensity = "Half",
    italic = false,
    font = wezterm.font_with_fallback({
      { family = "JetBrains Mono", weight = "Thin", italic = false },
      { family = "Symbols Nerd Font" },
      { family = "Noto Color Emoji" },
    }),
  },
  {
    intensity = "Half",
    italic = true,
    font = wezterm.font_with_fallback({
      { family = "JetBrains Mono", weight = "Thin", italic = true },
      { family = "Symbols Nerd Font" },
      { family = "Noto Color Emoji" },
    }),
  },
}

-- Color Scheme And Appearance
config.color_scheme = "OneDarkPro"
config.window_background_opacity = 1.0
config.window_decorations = "RESIZE"
config.force_reverse_video_cursor = true
config.window_padding = { left = 10, right = 10, top = 10, bottom = 5 }

config.color_schemes = {
  ["OneDarkPro"] = {
    ansi = {
      "#282c34", -- black
      "#e06c75", -- red
      "#98c379", -- green (lime)
      "#e5c07b", -- yellow
      "#61afef", -- blue
      "#c678dd", -- purple
      "#56b6c2", -- cyan (aqua)
      "#abb2bf", -- white
    },
    brights = {
      "#5c6370", -- black (grey)
      "#e9969d", -- red (maroon)
      "#b3d39c", -- green (olive)
      "#edd4a6", -- yellow (orange)
      "#8fc6f4", -- blue (navy)
      "#d7a1e7", -- purple (magenta\fuchsia)
      "#7bc6d0", -- cyan (teal)
      "#c8cdd5", -- white (silver)
    },
    foreground = "#abb2bf",
    background = "#282c34",
    cursor_fg = "#dcdfe4",
    cursor_bg = "#a3b3cc",
    cursor_border = "#a3b3cc",
    selection_fg = "#abb2bf",
    selection_bg = "#c678dd",
    --selection_bg = "#414858",
  },

  ["OneDarkProVivid"] = {
    ansi = {
      "#282c34", -- black
      "#ef596f", -- red
      "#89ca78", -- green (lime)
      "#e5c07b", -- yellow
      "#61afef", -- blue
      "#d55fde", -- purple
      "#2bbac5", -- cyan (aqua)
      "#abb2bf", -- white
    },
    brights = {
      "#5c6370", -- black (grey)
      "#f38897", -- red (maroon)
      "#a9d89d", -- green (olive)
      "#edd4a6", -- yellow (orange)
      "#8fc6f4", -- blue (navy)
      "#e089e7", -- purple (magenta\fuchsia)
      "#4bced8", -- cyan (teal)
      "#c8cdd5", -- white (silver)
    },
    foreground = "#abb2bf",
    background = "#282c34",
    cursor_fg = "#dcdfe4",
    cursor_bg = "#a3b3cc",
    cursor_border = "#a3b3cc",
    -- selection_fg = "#abb2bf",
    -- selection_bg = "#3a404c",
    selection_fg = "#abb2bf",
    selection_bg = "#d55fde",
  },
  ["OneDarkProLight"] = {
    ansi = {
      "#6a6a6a", -- black
      "#e05661", -- red
      "#1da912", -- green (lime)
      "#eea825", -- yellow
      "#118dc3", -- blue
      "#9a77cf", -- purple
      "#56b6c2", -- cyan (aqua)
      "#fafafa", -- white
    },
    brights = {
      "#bebebe", -- black (grey)
      "#e88189", -- red (maroon)
      "#25d717", -- green (olive)
      "#f2bb54", -- yellow (orange)
      "#1caceb", -- blue (navy)
      "#b69ddc", -- purple (magenta\fuchsia)
      "#7bc6d0", -- cyan (teal)
      "#ffffff", -- white (silver)
    },
    foreground = "#6a6a6a",
    background = "#fafafa",
    cursor_fg = "#dcdfe4",
    cursor_bg = "#a3b3cc",
    cursor_border = "#a3b3cc",
    selection_fg = "#fafafa",
    selection_bg = "#9a77cf",
  },
  ["OneDarkProDark"] = {
    ansi = {
      "#000000", -- black
      "#ef596f", -- red
      "#89ca78", -- green (lime)
      "#e5c07b", -- yellow
      "#61afef", -- blue
      "#d55fde", -- purple
      "#2bbac5", -- cyan (aqua)
      "#abb2bf", -- white
    },
    brights = {
      "#434852", -- black (grey)
      "#f38897", -- red (maroon)
      "#a9d89d", -- green (olive)
      "#edd4a6", -- yellow (orange)
      "#8fc6f4", -- blue (navy)
      "#e089e7", -- purple (magenta\fuchsia)
      "#4bced8", -- cyan (teal)
      "#c8cdd5", -- white (silver)
    },
    foreground = "#abb2bf",
    background = "#000000",
    cursor_fg = "#dcdfe4",
    cursor_bg = "#a3b3cc",
    cursor_border = "#a3b3cc",
    selection_fg = "#abb2bf",
    selection_bg = "#d55fde",
  },
}

-- Bell
config.audible_bell = "Disabled"
config.visual_bell = {
  fade_in_function = "EaseIn",
  fade_in_duration_ms = 150,
  fade_out_function = "EaseOut",
  fade_out_duration_ms = 150,
}
config.colors = { visual_bell = "#202020" }

-- Initial state
config.initial_rows = 32 -- Leaves a few lines of screen space above/below the window
config.initial_cols = 140 -- Wide enough for 100 Neovim columns plus 30 for tree view
config.default_prog = {
  "tmux",
  "new-session",
  "-c",
  wezterm.home_dir .. "/profile",
}

-- Turn off the tab bar, as I use tmux
config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

-- Updates
config.check_for_updates = true
config.check_for_updates_interval_seconds = 86400 -- Every 24 hours

-- Mouse Settings
config.swallow_mouse_click_on_pane_focus = true
config.swallow_mouse_click_on_window_focus = true

-- Don't prompt when closing the window
config.window_close_confirmation = "NeverPrompt"

-- finally, return the configuration to wezterm
return config
