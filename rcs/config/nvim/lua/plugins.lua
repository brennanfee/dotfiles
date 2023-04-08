--local settings = require("user-conf")
--local utils = require("functions")
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- Autocommand to re-sync when the plugins file is changed
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd(
"BufWritePost",
{ command = "source <afile> | PackerSync", group = packer_group, pattern = "plugins.lua" }
)

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
function get_config(name)
  return string.format('require("plugin-configs/%s")', name)
end

function get_theme_config(name)
  return string.format('require("theme-configs/%s-config")', name)
end

-- bootstrap packer if not installed
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrapped = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print "Installing packer, close and reopen Neovim..."
  vim.api.nvim_command("packadd packer.nvim")
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init({
  profile = {
    enable = true, -- enable profiling via :PackerCompile profile=true
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  }
})

return packer.startup(function(use)
  -- actual plugins list

  use("wbthomason/packer.nvim") -- Packer itself, so it gets updated

  -- Common dependencies
  use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
  use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins

  use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight

  -- Colorschemes
  use({ "navarasu/onedark.nvim", config = get_theme_config("onedark") })
  use("lunarvim/darkplus.nvim")
  use("lunarvim/onedarker.nvim")

  -- Impatient
  use("lewis6991/impatient.nvim")

  -- EditorConfig
  use("gpanders/editorconfig.nvim")

  -- cmp (completion) plugins
  use({
    "hrsh7th/nvim-cmp", -- The completion plugin
    requires = {
      { "hrsh7th/cmp-buffer" }, -- buffer completions
      { "hrsh7th/cmp-path" }, -- path completions
      { "hrsh7th/cmp-cmdline" }, -- cmdline completions
      { "hrsh7th/cmp-nvim-lua" }, -- lua API completions
    },
    config = get_config("cmp")
  })

  -- Snippets
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
  use({
    "L3MON4D3/LuaSnip",
    requires = "saadparwaiz1/cmp_luasnip",
    config = get_config("luasnip")
  })

  -- LSP
  use({
    "neovim/nvim-lspconfig",
    requires = {
      { "hrsh7th/cmp-nvim-lsp" }, -- lsp-cmp completion integration
      { "williamboman/nvim-lsp-installer" }, -- simple to use language server installer
      { "tamago324/nlsp-settings.nvim" }, -- language server settings defined in json for
      { "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters
    },
    config = get_config("lsp")
  })

  -- Debugging
  use({
    "mfussenegger/nvim-dap",
    requires = {
      { "rcarriga/nvim-dap-ui" }, -- UI for DAP output
      { "theHamsta/nvim-dap-virtual-text" }, -- Show debug values in virtual text
      { "nvim-telescope/telescope-dap.nvim" }, -- Telescope extention for frames, threads, commands etc.
    },
    config = get_config("dap")
  })

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    config = get_config("telescope"),
  })

  use({ "crispgm/telescope-heading.nvim" })
  use({ "nvim-telescope/telescope-symbols.nvim" })
  use({ "nvim-telescope/telescope-file-browser.nvim" })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "nvim-telescope/telescope-media-files.nvim" })
  use({ "nvim-telescope/telescope-packer.nvim" })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    requires = {
      --{ "nvim-treesitter/nvim-treesitter-refactor" },
      --{ "nvim-treesitter/nvim-treesitter-textobjects" },
      --{ "p00f/nvim-ts-rainbow" },
    },
    config = get_config("treesitter"),
    run = ":TSUpdate",
  })

  -- Autopairs
  use({ "windwp/nvim-autopairs", config = get_config("autopairs") })

  -- Comments
  use({
    "numToStr/Comment.nvim",
    requires = "JoosepAlviste/nvim-ts-context-commentstring",
    config = get_config("comment"),
  })

  -- Git integrations
  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    event = "BufReadPre",
    config = get_config("gitsigns"),
  })

  -- Tree
  use({
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = get_config("nvim-tree")
  })

  -- Bufferline
  use({
    "akinsho/nvim-bufferline.lua",
    requires = "kyazdani42/nvim-web-devicons",
    event = "BufReadPre",
    config = get_config("bufferline"),
  })

  -- Lualine
  use({
    "nvim-lualine/lualine.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    event = "VimEnter",
    config = get_config("lualine"),
  })

  -- Terminal and ToggleTerm
  use({ "akinsho/toggleterm.nvim", config = get_config("toggleterm") })

  -- Project
  use({ "ahmedkhalf/project.nvim", config = get_config("project") })

  -- Dashboard (using Alpha)
  use {
    'goolord/alpha-nvim',
    requires = "kyazdani42/nvim-web-devicons",
    config = get_config("alpha"),
  }

  -- Whichkey
  use({ "folke/which-key.nvim", config = get_config("whichkey") })

  -- Todo Comments
  use {
    'folke/todo-comments.nvim',
    requires = "nvim-lua/plenary.nvim",
    config = get_config("todo"),
  }

  -- Colorizer
  use({ "norcalli/nvim-colorizer.lua", config = get_config("colorizer") })

  -- Swiss Army Knife
  use {
    'echasnovski/mini.nvim',
    branch = 'stable',
    config = get_config("mini"),
  }

  -- Vim plugins (TODO: Look for lua replacements)
  use({ "tpope/vim-repeat" })
  -- use({ "tpope/vim-surround" }) # Using mini.nvim instead
  -- use({ "wellle/targets.vim" })
  use({ "AdamWhittingham/vim-copy-filename" })

  -- If we were bootstrapped, run sync
  if packer_bootstrapped then
    packer.sync()
  end
end)
