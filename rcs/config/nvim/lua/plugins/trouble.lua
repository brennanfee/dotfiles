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

  -- Mappings
  local wk = require("which-key")
  wk.add({
    { "<leader>x", group = "Diagnostics" },
    { "<leader>xx", "<cmd>lua require('trouble').toggle()<cr>", desc = "Dialog" },
    {
      "<leader>xw",
      "<cmd>lua require('trouble').toggle('workspace_diagnostics')<cr>",
      desc = "Workspace Diagnostics",
    },
    {
      "<leader>xd",
      "<cmd>lua require('trouble').toggle('document_diagnostics')<cr>",
      desc = "Document Diagnostics",
    },
    { "<leader>xq", "<cmd>lua require('trouble').toggle('quickfix')<cr>", desc = "Quickfix" },
    { "<leader>xl", "<cmd>lua require('trouble').toggle('loclist')<cr>", desc = "Loclist" },
    {
      "<leader>gR",
      "<cmd>lua require('trouble').toggle('lsp_references')<cr>",
      desc = "LSP References",
    },
    {
      "<leader>lR",
      "<cmd>lua require('trouble').toggle('lsp_references')<cr>",
      desc = "LSP References",
    },
  })

  -- Custom action for Telescope
  local trouble = require("trouble.sources.telescope")
  local ok, telescope = pcall(require, "telescope")
  if ok then
    telescope.setup({
      defaults = {
        mappings = {
          i = { ["<c-t>"] = trouble.open },
          n = { ["<c-t>"] = trouble.open },
        },
      },
    })
  end
end

return M
