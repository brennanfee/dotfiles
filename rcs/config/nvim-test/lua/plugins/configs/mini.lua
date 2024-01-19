-- Mini is a swiss army knife of small utilities

return {
  {
    "echasnovski/mini.bufremove",
    lazy = false,
    verson = "*", -- stable
    config = function()
      --require('mini.surround').setup({})
      require("mini.bufremove").setup({})
    end,
  },
}
