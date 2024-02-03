local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  -- event = "VeryLazy",
}

-- function M.config()
--   local icons = require("core.icons")

--   require("ibl").setup({
--     indent = {
--       char = icons.ui.LineMiddle,
--     },
--     exclude = {
--       buftypes = { "terminal", "nofile" },
--       filetypes = {
--         "alpha",
--         "help",
--         "startify",
--         "dashboard",
--         "lazy",
--         "neogitstatus",
--         "NvimTree",
--         "Trouble",
--         "text",
--       },
--     },
--     scope = {
--       enabled = true,
--       -- highlight = highlightGroups,
--     },
--   })
-- end

function M.config()
  local icons = require("core.icons")

  -- Rainbow delimiters integration
  local highlightGroups = { "IblScope" }
  local rainbowInstalled, _ = pcall(require, "rainbow-delimiters")
  if rainbowInstalled then
    highlightGroups = {
      "RainbowDelimiterRed",
      "RainbowDelimiterYellow",
      "RainbowDelimiterBlue",
      "RainbowDelimiterOrange",
      "RainbowDelimiterGreen",
      "RainbowDelimiterViolet",
      "RainbowDelimiterCyan",
    }
  end

  require("ibl").setup({
    indent = {
      char = icons.ui.LineMiddle,
      -- highlight = highlightGroups,
    },
    exclude = {
      buftypes = { "terminal", "nofile" },
      filetypes = {
        "alpha",
        "help",
        "startify",
        "dashboard",
        "lazy",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "text",
      },
    },
    scope = {
      enabled = true,
      highlight = highlightGroups,
    },
  })

  -- if rainbowInstalled then
  --   local hooks = require("ibl.hooks")
  --   hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  --     -- TODO: Use theme colors
  --     vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#E06C75" })
  --     vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#E5C07B" })
  --     vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#61AFEF" })
  --     vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#D19A66" })
  --     vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#98C379" })
  --     vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#C678DD" })
  --     vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#56B6C2" })
  --   end)

  --   hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  -- end
end

return M
