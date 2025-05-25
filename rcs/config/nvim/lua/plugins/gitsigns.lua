local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  cmd = "Gitsigns",
}

M.config = function()
  local icons = require("core.icons")

  local wk = require("which-key")
  wk.add({
    { "<leader>s", group = "Source/Git" },
    {
      "<leader>sj",
      "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>",
      desc = "Next Hunk",
    },
    {
      "<leader>sk",
      "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>",
      desc = "Prev Hunk",
    },
    { "<leader>sp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk" },
    { "<leader>sr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk" },
    { "<leader>sl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame" },
    { "<leader>sR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer" },
    { "<leader>sh", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk" },
    {
      "<leader>su",
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      desc = "Undo Stage Hunk",
    },
    { "<leader>sd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Git Diff" },
  })

  require("gitsigns").setup({
    signs = {
      add = { text = icons.git.SignsAdd },
      change = { text = icons.git.SignsChange },
      delete = { text = icons.git.SignsDelete },
      topdelete = { text = icons.git.SignsTopDelete },
      changedelete = { text = icons.git.SignsChangeDelete },
      untracked = { text = icons.git.SignsUntracked },
    },
    signs_staged = {
      add = { text = icons.git.SignsAdd },
      change = { text = icons.git.SignsChange },
      delete = { text = icons.git.SignsDelete },
      topdelete = { text = icons.git.SignsTopDelete },
      changedelete = { text = icons.git.SignsChangeDelete },
      untracked = { text = icons.git.SignsUntracked },
    },
    signs_staged_enable = true,
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    auto_attach = true,
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
    sign_priority = 6,
    update_debounce = 200,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
  })
end

return M
