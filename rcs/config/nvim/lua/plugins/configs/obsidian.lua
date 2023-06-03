return {
  "epwalsh/obsidian.nvim",
  lzy = true,
  event = { "BufReadPre " .. vim.fn.expand("~") .. "/profile/cloud/notes/brain/**/*.md" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    dir = "~/profile/cloud/notes/brain",
    notes_subdir = "2-notes",

    daily_notes = {
      folder = "3-timeline/daily-notes",
      date_format = "%Y-%m-%d",
    },

    completion = {
      nvim_cmp = true,
    },

    templates = {
      subdir = "4-resources/templates",
      date_format = "%Y-%m-%d",
      time_format = "%I:%M:%S %p",
    },

    -- For external urls
    follow_url_func = function(url)
      -- Open the URL in the default web browser
      vim.fn.jobstart({ "xdg-open", url })
    end,

    use_advanced_uri = false,
    open_app_foreground = false,
    finder = "telescope.nvim",
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    -- Optional, override the 'gf' keymap to utilize Obsidian's search functionality.
    -- see also: 'follow_url_func' config option above.
    vim.keymap.set("n", "gf", function()
      if require("obsidian").util.cursor_on_markdown_link() then
        return "<cmd>ObsidianFollowLink<CR>"
      else
        return "gf"
      end
    end, { noremap = false, expr = true })
  end,
}
