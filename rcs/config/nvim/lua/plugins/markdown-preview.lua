local M = {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
}

function M.config()
  local utils = require("core.utils")

  vim.g.mkdp_refresh_slow = 1
  vim.g.mkdp_page_title = "File: ${name} "
  vim.g.mkdp_preview_options = {
    mkit = {
      html = true,
      xhtmlOut = true,
      breaks = true,
      langPrefix = "language-",
      linkify = true,
      typographer = true,
    },
    disable_filename = true,
  }

  utils.keymap("n", "<leader>pv", function()
    vim.cmd("MarkdownPreviewToggle")
  end, { desc = "MD: [P]re[v]iew Markdown" })
end

return M
