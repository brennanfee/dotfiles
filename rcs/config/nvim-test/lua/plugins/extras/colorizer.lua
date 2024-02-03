local M = {
  "NvChad/nvim-colorizer.lua",
  event = { "BufReadPost", "BufNewFile" },
}

function M.config()
  require("colorizer").setup({
    filetypes = {
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
      "css",
      "html",
      "astro",
      "lua",
    },
    user_default_options = {
      names = false,
      css = true,
      sass = { enable = true, parsers = { "css" } },
      mode = "virtualtext", -- Set the display mode
      tailwind = "both",
    },
    buftypes = {},
  })
end

return M
