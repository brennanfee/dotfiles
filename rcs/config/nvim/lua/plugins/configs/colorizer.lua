-- Display the color for things like ##1236ff

return {
  {
    "NvChad/nvim-colorizer.lua",
    init = function()
      require("core.utils").lazy_load "nvim-colorizer.lua"
    end,
    config = function()
      require("colorizer").setup({
        mode = "virtualtext", -- Set the display mode.
        tailwind = true, -- Enable tailwind colors
      })

      -- execute colorizer as soon as possible
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },
}
