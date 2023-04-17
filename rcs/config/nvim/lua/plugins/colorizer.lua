-- Display the color for things like ##1236ff

return {
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        mode = "virtualtext", -- Set the display mode.
        tailwind = true, -- Enable tailwind colors
      })
    end,
  },
}
