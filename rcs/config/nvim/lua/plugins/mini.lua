local M = {
  "echasnovski/mini.nvim",
  version = false,
}

function M.config()
  require("mini.icons").setup()
  require("mini.ai").setup()
  require("mini.surround").setup()
  require("mini.bracketed").setup()
  require("mini.files").setup()

  require("mini.operators").setup({
    evaluate = { prefix = "<leader>g=" },
    exchange = { prefix = "<leader>gx" },
    multiply = { prefix = "<leader>gm" },
    replace = { prefix = "<leader>gr" },
    sort = { prefix = "<leader>gs" },
  })

  -- vim.g.miniindentscope_disable = true
  -- require("mini.indentscope").setup()
end

return M
