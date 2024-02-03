vim.o.guifont =
  "JetBrainsMono_Nerd_Font_Mono,JetBrainsMono_Nerd_Font,JetBrains_Mono:h16,monospace:h16"

if vim.g.neovide then
  -- I frequently forget I am in the IDE\Windowed\Visual version so a confirmation makes me thing
  -- twice before closing.
  vim.g.neovide_confirm_quit = true

  vim.g.neovide_remember_window_size = true

  vim.g.neovide_input_use_logo = true

  vim.g.neovide_cursor_animation_length = 0 -- turn off cursor animations
end
