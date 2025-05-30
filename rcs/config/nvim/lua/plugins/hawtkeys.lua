-- Description: hawtkeys.nvim is a nvim plugin for finding and suggesting memorable and easy-to-press keys for your
-- nvim shortcuts. It takes into consideration keyboard layout, easy-to-press combinations and memorable phrases, and
-- excludes already mapped combinations to provide you with suggested keys for your commands.
-- Commands -> :Hawtkeys, :HawtkeysAll, :HawtkeysDupes

local M = {
  "tris203/hawtkeys.nvim",
  cmd = { "HawtkeysAll", "Hawtkeys", "HawtkeysDupes" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {},
}

function M.init()
  -- Key Mappings
  vim.keymap.set("n", "<leader>?a", "<cmd>HawtkeysAll<cr>", { desc = "Show All Keymaps" })
  vim.keymap.set("n", "<leader>?s", "<cmd>Hawtkeys<cr>", { desc = "Search Keymaps" })
  vim.keymap.set("n", "<leader>?d", "<cmd>HawtkeysDupes<cr>", { desc = "Check For Duplicate Keymaps" })
end

return M
