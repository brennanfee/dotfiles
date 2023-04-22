-- File tree plugin
local utils = require("functions")

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
    opts = { },
  }
}
