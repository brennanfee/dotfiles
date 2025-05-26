local M = {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
  require("oil").setup({
    default_file_explorer = false,
    delete_to_trash = true,
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name, _) -- black hole is bufnr
        if name == ".git" then
          return true
        end
        if name == ".node_modules" then
          return true
        end
        return false
      end,
    },
    float = {
      max_height = 20,
      max_width = 60,
    },
  })
  vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
end

return M
