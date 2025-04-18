local M = {
  "tris203/hawtkeys.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}

function M.config()
  local wk = require("which-key")
  require("hawtkeys").setup({})

  local wk = require("which-key")
  -- Mappings
  wk.add({
    { "<leader>?a", "<cmd>HawtkeysAll<cr>", desc = "Search All Keymaps" },
    { "<leader>?d", "<cmd>HawtkeysAll<cr>", desc = "Check For Duplicate Keymaps" },
  })
end

return M
