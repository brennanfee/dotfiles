local M = {
  "ejrichards/mise.nvim",
  opts = {
    args = "env --json --quiet",
    initial_path = vim.env.PATH_SYSTEM_AUGMENTED,
  },
}

return M
