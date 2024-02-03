local M = {
  "epwalsh/obsidian.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- event = "VeryLazy",
  event = { "BufReadPre " .. vim.fn.expand("~") .. "/profile/cloud/notes/brain/**/*.*" },
}

function M.config()
  require("obsidian").setup({
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
  })

  -- Optional, override the 'gf' keymap to utilize Obsidian's search functionality.
  -- see also: 'follow_url_func' config option above.
  vim.keymap.set("n", "gf", function()
    if require("obsidian").util.cursor_on_markdown_link() then
      return "<cmd>ObsidianFollowLink<CR>"
    else
      return "gf"
    end
  end, { noremap = false, expr = true })
end

return M
