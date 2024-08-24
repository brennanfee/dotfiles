local M = {
  "folke/which-key.nvim",
  dependencies = {
    {
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.icons",
    },
  },
}

function M.config()
  local wk = require("which-key")

  wk.setup({
    preset = "modern",
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    show_help = true,
    show_keys = true,
    disable = {
      bt = {},
      ft = { "TelescopePrompt" },
    },
    win = {
      no_overlap = false,
    },
    debug = false,
  })

  -- Mappings
  wk.add({
    { "<leader>q", "<cmd>confirm q<CR>", desc = "Quit" },
    { "<leader>v", "<cmd>vsplit<CR>", desc = "Split" },
    { "<leader>;", "<cmd>tabnew | terminal<CR>", desc = "Term" },
    -- Tab handling
    { "<leader>a", group = "Tab" },
    { "<leader>aN", "<cmd>tabnew %<cr>", desc = "New Tab" },
    { "<leader>ah", "<cmd>-tabmove<cr>", desc = "Move Left" },
    { "<leader>al", "<cmd>+tabmove<cr>", desc = "Move Right" },
    { "<leader>an", "<cmd>$tabnew<cr>", desc = "New Empty Tab" },
    { "<leader>ao", "<cmd>tabonly<cr>", desc = "Only" },
  })
end

return M
