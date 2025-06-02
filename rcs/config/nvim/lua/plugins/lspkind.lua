local M = {
  "onsails/lspkind.nvim",
}

M.config = function()
  require("lspkind").setup({
    mode = "symbol_text",
  })
end

return M
