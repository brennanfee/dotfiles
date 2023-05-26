-- Tools for todo's in comments
local utils = require("core.utils")

return {
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    init = function()
      utils.lazy_load("todo-comments.nvim")
    end,
    config = function()
      require("todo-comments").setup({
        -- list of named colors where we try to extract the guifg from the
        -- list of hilight groups or use the hex color if hl not found as a fallback
        colors = {
          error = { "DiagnosticError", "ErrorMsg", utils.theme_colors().red },
          warning = { "DiagnosticWarn", "WarningMsg", utils.theme_colors().yellow },
          info = { "DiagnosticInfo", utils.theme_colors().blue },
          hint = { "DiagnosticHint", utils.theme_colors().green },
          default = { "Identifier", utils.theme_colors().dark_purple },
          test = { "Identifier", utils.theme_colors().purple },
        },
        search = {
          command = "rg",
          args = {
            "-L",
            "--color=never",
            "--vimgrep",
            "--smart-case",
          },
        },
      })
    end,
  },
}
