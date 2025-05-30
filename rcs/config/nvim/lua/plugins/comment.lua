return {
  {
    "numToStr/Comment.nvim",
    config = function()
      vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Linewise Comment" })
      vim.keymap.set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Linewise Comment" })

      require("Comment").setup({
        ignore = "^$",
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      vim.g.skip_ts_context_commentstring_module = true
      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })
    end,
  },
}
