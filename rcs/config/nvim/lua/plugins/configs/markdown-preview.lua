local utils = require("core/utils")

return {
  "iamcco/markdown-preview.nvim",
  build = function() vim.fn["mkdp#util#install"]() end,
  ft = "markdown",
  init = function()
    local map = utils.map_key

    map("n", "<leader>pv", function()
      vim.cmd("MarkdownPreviewToggle")
    end, { desc = "MD: [P]re[v]iew Markdown" })
  end,
  config = function()
    vim.g.mkdp_refresh_slow = 1
    vim.g.mkdp_page_title = 'File: ${name} '
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
  end,
}
