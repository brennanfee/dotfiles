local M = {
  "brennanfee/oncedark.nvim",
  lazy = false, -- Make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- Make sure to load this before all the other start plugins
}

function M.config()
  require("oncedark").setup({
    options = {
      cursorline = true,
    },
    styles = {
      comments = "italic",
      keywords = "bold,italic",
      constants = "underline",
    },
  })

  vim.cmd("colorscheme oncedark")
end

return M
