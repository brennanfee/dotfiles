-- Lualine
local utils = require("functions")
local settings = require("user-settings")

-- Set lualine as statusline
-- See `:help lualine.txt`
return {
  {
    'nvim-lualine/lualine.nvim',
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
