-- Display the color for things like ##1236ff

return {
  {
    "NvChad/nvim-colorizer.lua",
    lazy = false,
    opts = {
      user_default_options = {
        css = true,
        sass = { enable = true, parsers = { "css" } },
        mode = "virtualtext", -- Set the display mode.
        tailwind = true, -- Enable tailwind colors
      },
    },
  },
}
