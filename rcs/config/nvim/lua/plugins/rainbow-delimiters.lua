local M = {
  "HiPhish/rainbow-delimiters.nvim",
}

function M.config()
  local rainbow_delimiters = require("rainbow-delimiters")

  require("rainbow-delimiters.setup").setup({
    strategy = {
      [""] = rainbow_delimiters.strategy["global"],
      vim = rainbow_delimiters.strategy["local"],
    },
    query = {
      [""] = "rainbow-delimiters",
      lua = "rainbow-blocks",
    },
    priority = {
      [""] = 110,
      lua = 210,
    },
    highlight = {
      "RainbowDelimiterRed",
      "RainbowDelimiterYellow",
      "RainbowDelimiterBlue",
      "RainbowDelimiterOrange",
      "RainbowDelimiterGreen",
      "RainbowDelimiterViolet",
      "RainbowDelimiterCyan",
    },
  })

  -- TODO: Use theme colors
  vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#f38ba8" })
  vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#fab387" })
  vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#89b4fa" })
  vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#f2cdcd" })
  vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#a6e3a1" })
  vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#cba6f7" })
  vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#74c7ec" })
end

return M
