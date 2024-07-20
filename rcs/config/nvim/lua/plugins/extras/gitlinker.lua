local M = {
  "linrongbin16/gitlinker.nvim",
  dependencies = { { "nvim-lua/plenary.nvim" } },
  event = "VeryLazy",
}

function M.config()
  local wk = require("which-key")
  wk.add({
    { "<leader>s", group = "Source/Git" },
    { "<leader>sy", "<cmd>GitLink!<cr>", desc = "Git link" },
    { "<leader>sY", "<cmd>GitLink blam<cr>", desc = "Git link blame" },
  })

  require("gitlinker").setup({
    message = false,
    console_log = false,
  })
end

return M
