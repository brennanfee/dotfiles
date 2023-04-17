-- Telescope and fuzzy finding

return {
  {
    "nvim-telescope/telescope.nvim",
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      "nvim-telescope/telescope-dap.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- `make` must be installed on the system for this to work
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    dependencies = { "nvim-telescope/telescope.nvim", },
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
}

-- Other telescope plugins to consider:
--
-- nvim-telescope/telescope-github.nvim
-- nvim-telescope/telescope-cheat.nvim
-- nvim-telescope/telescope-node-modules.nvim
-- nvim-telescope/telescope-media-files.nvim
