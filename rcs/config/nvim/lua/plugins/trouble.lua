local M = {
  "folke/trouble.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
}

function M.config()
  require("trouble").setup({
    height = 12,
    use_diagnostic_signs = true,
  })

  vim.keymap.set("n", "<leader>xx", function()
    require("trouble").toggle()
  end)
  vim.keymap.set("n", "<leader>xw", function()
    require("trouble").toggle("workspace_diagnostics")
  end)
  vim.keymap.set("n", "<leader>xd", function()
    require("trouble").toggle("document_diagnostics")
  end)
  vim.keymap.set("n", "<leader>xq", function()
    require("trouble").toggle("quickfix")
  end)
  vim.keymap.set("n", "<leader>xl", function()
    require("trouble").toggle("loclist")
  end)
  vim.keymap.set("n", "gR", function()
    require("trouble").toggle("lsp_references")
  end)

  -- Custom action for Telescope
  local trouble = require("trouble.providers.telescope")
  local ok, telescope = pcall(require, "telescope")
  if ok then
    telescope.setup({
      defaults = {
        mappings = {
          i = { ["<c-t>"] = trouble.open_with_trouble },
          n = { ["<c-t>"] = trouble.open_with_trouble },
        },
      },
    })
  end
end

return M
