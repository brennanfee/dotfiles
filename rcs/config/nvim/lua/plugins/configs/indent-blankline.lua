-- Indent guides
local utils = require("core.utils")

-- Add indentation guides even on blank lines
-- See `:help indent_blankline.txt`
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    init = function()
      utils.lazy_load("indent-blankline.nvim")
    end,
    opts = {
      indentLine_enabled = 1,
      char = "┊",
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
        "",
      },
      buftype_exclude = { "terminal" },
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
      show_current_context = true,
      show_current_context_start = true,
    },
    config = function(_, opts)
      vim.keymap.set("n", "<leader>cc", function()
        local ok, start = require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )

        if ok then
          vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
          vim.cmd([[normal! _]])
        end
      end, { desc = "Jump to current_context" })

      require("indent_blankline").setup(opts)
    end,
  },
}
