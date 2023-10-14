-- Indent guides

-- Add indentation guides even on blank lines
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    -- opts = {
    --   enabled = 1,
    --   indent = {
    --     char = "┊",
    --   },
    --   exclude = {
    --     filetypes = {
    --       "alpha",
    --       "dashboard",
    --       "neo-tree",
    --       "help",
    --       "man",
    --       "gitcommit",
    --       "terminal",
    --       "packer",
    --       "checkhealth",
    --       "lazy",
    --       "lspinfo",
    --       "TelescopePrompt",
    --       "TelescopeResults",
    --       "mason",
    --       "",
    --     },
    --   },
    -- },
    -- config = function(_, opts)
    --   require("ibl").setup(opts)
    -- end,
  },
}
