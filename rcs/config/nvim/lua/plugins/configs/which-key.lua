-- folke/which-key.nvim

return {
  {
    "folke/which-key.nvim",
    keys = { "<leader>", '"', "'", "`", "c", "v" },
    init = function()
      vim.keymap.set("n", "<leader>wK", "<cmd> WhichKey <CR>", { desc = "which-key all keymaps"})
      vim.keymap.set("n", "<leader>wk", function()
        local input = vim.fn.input "WhichKey: "
        vim.cmd("WhichKey " .. input)
      end, { desc = "which-key query lookup"})
    end,
    opts = {
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "  ", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },

      popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
      },

      window = {
        border = "none", -- none/single/double/shadow
      },

      layout = {
        spacing = 6, -- spacing between columns
      },

      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },

      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        i = { "j", "k" },
        v = { "j", "k" },
      },
    },
  }
}
