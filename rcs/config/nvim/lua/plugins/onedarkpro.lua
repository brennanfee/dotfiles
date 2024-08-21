local M = {
  "olimorris/onedarkpro.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
  require("onedarkpro").setup({
    options = {
      cursorline = true,
    },
    styles = {
      comments = "italic",
      keywords = "bold,italic",
      constants = "underline",
    },
  })

  -- vim.cmd("colorscheme onedark")
end

return M
