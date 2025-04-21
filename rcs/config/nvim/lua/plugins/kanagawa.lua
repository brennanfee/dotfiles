local M = {
  "rebelot/kanagawa.nvim",
  lazy = false, -- Make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- Make sure to load this before all the other start plugins
}

function M.config()
  require("kanagawa").setup({
    undercurl = true,
    terminalColors = true,
    theme = "wave",
    background = {
      dark = "wave",
      light = "lotus",
    },
  })

  -- vim.cmd("colorscheme kanagawa")
end

return M
