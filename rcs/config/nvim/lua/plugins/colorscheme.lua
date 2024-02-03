-- DarkPlus
-- local M = {
--   "LunarVim/darkplus.nvim",
--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000, -- make sure to load this before all the other start plugins
-- }

-- function M.config()
--   vim.cmd.colorscheme "darkplus"
-- end

-- return M

local M = {
  "olimorris/onedarkpro.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
  local utils = require("core.utils")

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

  utils.setColorScheme(utils.theme)
end

return M
