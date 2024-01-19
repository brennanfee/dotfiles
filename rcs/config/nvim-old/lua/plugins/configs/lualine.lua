-- Lualine

-- Set lualine as statusline
-- See `:help lualine.txt`
return {
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    opts = {
      options = {
        icons_enabled = true,
        component_separators = "|",
        section_separators = "",
      },
    },
  },
}
