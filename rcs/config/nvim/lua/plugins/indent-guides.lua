-- Indent guides

-- Add indentation guides even on blank lines
-- See `:help indent_blankline.txt`
return {
  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      indentLine_enabled = 1,
      char = '┊',
      filetype_exclude = {
        "alpha",
        "dashboard",
        "neo-tree",
        "help",
        "terminal",
        "lazy",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
        "nvdash",
        "nvcheatsheet",
        "",
      },
      buftype_exclude = { "terminal" },
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
      show_current_context = true,
      show_current_context_start = true,
    },
  },
}
