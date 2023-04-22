-- Treesitter

return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-refactor',
    },
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
  },
}
