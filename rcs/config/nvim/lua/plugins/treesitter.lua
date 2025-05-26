local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  local tool_lists = require("tools.tool-lists")

  require("nvim-treesitter.configs").setup({
    ensure_installed = tool_lists.treesitter_languages,
    sync_install = true,
    auto_installed = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
  })

  -- Mappings
  local wk = require("which-key")
  wk.add({
    { "<leader>T", group = "Treesitter" },
  })
end

return M
