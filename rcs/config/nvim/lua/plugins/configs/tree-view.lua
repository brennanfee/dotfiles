-- File tree plugin
local utils = require("core/utils")

-- return {
--   {
--     "nvim-neo-tree/neo-tree.nvim",
--     dependencies = {
--       "nvim-lua/plenary.nvim",
--       "MunifTanjim/nui.nvim",
--       "nvim-tree/nvim-web-devicons",
--     },
--     cmd = "Neotree",
--     init = function() vim.g.neo_tree_remove_legacy_commands = true end,
--     opts = function()
--       return {
--         auto_clean_after_session_restore = true,
--         close_if_last_window = true,
--         window = {
--           width = 30,
--         },
--         filesystem = {
--           follow_current_file = false,
--           hijack_netrw_behavior = "open_current",
--           use_libuv_file_watcher = true,
--         },
--       }
--     end,
--   }
-- }

return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function()
      vim.keymap.set("n", "<C-n>", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvimtree"})
      vim.keymap.set("n", "<leader>n", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvimtree"})

      vim.keymap.set("n", "<leader>e", "<cmd> NvimTreeFocus <CR>", { desc = "Focus nvimtree"})
    end,
    opts = {
      hijack_cursor = true,
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      view = {
        width = 35,
        relativenumber = true,
        preserve_window_proportions = true,
      },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)
      vim.g.nvimtree_side = opts.view.side
    end,
  }
}
