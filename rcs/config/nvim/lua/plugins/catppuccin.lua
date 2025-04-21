local M = {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false, -- Make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- Make sure to load this before all the other start plugins
}

function M.config()
  require("catppuccin").setup({
    flavour = "auto",
    background = {
      light = "latte",
      dark = "macchiato",
    },
    term_colors = true,
    default_integrations = true,
    integrations = {
      gitsigns = true,
      treesitter = true,
      mini = {
        enabled = true,
      },
    },
  })

  vim.cmd("colorscheme catppuccin")
end

return M
