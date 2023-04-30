-- Lualine
local utils = require("core/utils")
local settings = require("core/user-settings")

-- Set lualine as statusline
-- See `:help lualine.txt`
return {
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    opts = {
      options = {
        icons_enabled = true,
        theme = utils.safeRead(settings.lineTheme, "default"),
        component_separators = '|',
        section_separators = '',
      },
    },
  },
}
