-- Mini is a swiss army knife of small utilities

return {
  {
    'echasnovski/mini.nvim',
    branch = 'stable',
    config = function()
      --require('mini.surround').setup({})
      require('mini.bufremove').setup({})
    end,
  }
}
