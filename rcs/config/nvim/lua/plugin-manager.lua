-- Install and initialize plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Now the plugins
require("lazy").setup({
  { import = "plugins" },
}, {
  performance = {
    rtp = {
      --disable some rtp plugins
      disabled_plugins = {
        "gzip",
        --"matchit",
        --"matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
-- Old plugin list:
-- wbthomason/packer.nvim
-- nvim-lua/popup.nvim
-- nvim-lua/plenary.nvim
-- antoinemadec/FixCursorHold.nvim
-- navarasu/onedark.nvim
-- lunarvim/darkplus.nvim
-- lunarvim/onedarker.nvim
-- lewis6991/impatient.nvim
-- gpanders/editorconfig.nvim # Should be built into 0.9 now
-- hrsh7th/nvim-cmp
--    hrsh7th/cmp-buffer
--    hrsh7th/cmp-path
--    hrsh7th/cmp-cmdline
--    hrsh7th/cmp-nvim-lua
-- rafamadriz/friendly-snippets (dependency of LuaSnip?)
-- L3MON4D3/LuaSnip
--    saadparwaiz1/cmp_luasnip
-- neovim/nvim-lspconfig
--    hrsh7th/cmp-nvim-lsp
--    williamboman/nvim-lsp-installer
--    tamago324/nlsp-settings.nvim
--    jose-elias-alvarez/null-ls.nvim
-- mfussenegger/nvim-dap
--    rcarriga/nvim-dap-ui
--    theHamsta/nvim-dap-virtual-text
--    nvim-telescope/telescope-dap.nvim
-- nvim-telescope/telescope.nvim
--    nvim-lua/popup.nvim # Redundant from above
--    nvim-lua/plenary.nvim # Redundant from above
-- crispgm/telescope-heading.nvim
-- nvim-telescope/telescope-symbols.nvim
-- nvim-telescope/telescope-file-browser.nvim
-- nvim-telescope/telescope-fzf-native.nvim
-- nvim-telescope/telescope-media-files.nvim
-- nvim-telescope/telescope-packer.nvim
-- nvim-treesitter/nvim-treesitter
--    nvim-treesitter/nvim-treesitter-refactor
--    nvim-treesitter/nvim-treesitter-textobjects
--    p00f/nvim-ts-rainbow
-- windwp/nvim-autopairs
-- numToStr/Comment.nvim
--    JoosepAlviste/nvim-ts-context-commentstring
-- lewis6991/gitsigns.nvim
--    nvim-lua/plenary.nvim # Redundant from above
-- kyazdani42/nvim-tree.lua
--    kyazdani42/nvim-web-devicons
-- akinsho/nvim-bufferline.lua
--    kyazdani42/nvim-web-devicons
-- nvim-lualine/lualine.nvim
--    kyazdani42/nvim-web-devicons
-- akinsho/toggleterm.nvim
-- ahmedkhalf/project.nvim
-- goolord/alpha-nvim
--    kyazdani42/nvim-web-devicons
-- folke/which-key.nvim
-- folke/todo-comments.nvim
--    nvim-lua/plenary.nvim
-- norcalli/nvim-colorizer.lua
-- echasnovski/mini.nvim
--#### OLD VIM PLUGINS
-- tpope/vim-repeat
-- tpope/vim-repeat  # Commented out, Using mini.nvim instead
-- wellle/targets.vim # Commented out
-- AdamWhittingham/vim-copy-filename
-------------------------------------
-- To look at
-- nvim-neorg/neorg
-- dstein64/vim-startuptime
-- hrsh7th/cmp-nvim-lsp
-- Wansmer/treesj
-- monaqa/dial.nvim
-- folke/noice.nvim
-- stevearc/dressing.nvim
----  From Kickstart
-- tpope/vim-fugitive
-- tpope/vim-rhubarb
-- tpope/vim-sleuth
-- neovim/nvim-lspconfig # Above
--    williamboman/mason.nvim
--    williamboman/mason-lspconfig.nvim
--    j-hui/fidget.nvim
--    folke/neodev.nvim
-- hrsh7th/nvim-cmp  # Above
--    hrsh7th/cmp-nvim-lsp
--    L3MON4D3/LuaSnip  # Interesting, set up as dependencies of nvim-cmp
--    saadparwaiz1/cmp_luasnip # Interesting, set up as dependencies of nvim-cmp
-- lukas-reineke/indent-blankline.nvim
-- mfussenegger/nvim-dap # Above
--    rcarriga/nvim-dap-ui # Above
--    williamboman/mason.nvim
--    jay-babu/mason-nvim-dap.nvim
--    leoluz/nvim-dap-go
-- nvim-neo-tree/neo-tree.nvim
-- willothy/nvim-cokeline
---- From Astro
-- hrsh7th/nvim-cmp # Above
--    saadparwaiz1/cmp_luasnip
--    hrsh7th/cmp-buffer
--    hrsh7th/cmp-path
--    hrsh7th/cmp-nvim-lsp
-- famiu/bufdelete.nvim
-- max397574/better-escape.nvim
-- NMAC427/guess-indent.nvim
-- Shatur/neovim-session-manager
-- s1n7ax/nvim-window-picker
-- mrjones2014/smart-splits.nvim
-- kevinhwang91/nvim-ufo
--    kevinhwang91/promise-async
-- mfussenegger/nvim-dap
--    jay-babu/mason-nvim-dap.nvim
--        nvim-dap
--    rcarriga/nvim-dap-ui
-- rebelot/heirline.nvim
-- b0o/SchemaStore.nvim
-- with null-ls:  jay-babu/mason-null-ls.nvim
-- stevearc/aerial.nvim
-- nvim-neo-tree/neo-tree.nvim
--    MunifTanjim/nui.nvim
-- nvim-treesitter/nvim-treesitter
--    windwp/nvim-ts-autotag
--    JoosepAlviste/nvim-ts-context-commentstring
-- nvim-tree/nvim-web-devicons  ?????
-- onsails/lspkind.nvim
-- rcarriga/nvim-notify
-- stevearc/dressing.nvim
-- NvChad/nvim-colorizer.lua
----  NvChad
