-- Telescope and fuzzy finding

return {
  {
    "nvim-telescope/telescope.nvim",
    verson = '*', -- stable
    cmd = "Telescope",
    dependencies = {
      'nvim-lua/plenary.nvim',
      "nvim-telescope/telescope-dap.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-github.nvim",
      "chip/telescope-software-licenses.nvim",
      "crispgm/telescope-heading.nvim",
      "LinArcX/telescope-env.nvim",
      "nat-418/telescope-color-names.nvim",
      "PhilippFeO/telescope-filelinks.nvim",
      "benfowler/telescope-luasnip.nvim",
      "tsakirist/telescope-lazy.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    init = function()
      -- mappings
      --TODO: Load mappings
    end,
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--vimgrep",
          "--smart-case",
        },
        prompt_prefix = "  ",
        initial_mode = "insert",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
          },
        },
        file_ignore_patterns = { "node_modules" },
        path_display = { "truncate" },
        set_env = { ["COLORTERM"] = "truecolor" },
        mappings = {
          n = { ["q"] = "close", },
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },

      extensions_list = {
        "dap", "file_browser", "fzf", "gh", "software-licenses", "heading",
        "env", "color_names", "filelinks", "luasnip", "lazy",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)

      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },
}
