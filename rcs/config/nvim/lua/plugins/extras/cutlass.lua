local M = {
  "gbprod/cutlass.nvim",
  event = "VeryLazy",
}

function M.config()
  require("cutlass").setup({
    cut_key = "gm",
    registers = {
      select = "s",
      delete = "d",
      change = "c",
    },
  })
end

return M
