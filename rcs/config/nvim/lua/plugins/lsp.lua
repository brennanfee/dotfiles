-- LSP plugins and config
local utils = require("functions")
local settings = require("user-settings")

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      {
        'williamboman/mason.nvim',
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
        config = function()
          require("mason").setup({
            pip = {
              upgrade_pip = true,
            },
            ui = {
              icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
              },
            },
          })
        end,
      },
      'williamboman/mason-lspconfig.nvim',
      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', opts = {} },
      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  }
}
