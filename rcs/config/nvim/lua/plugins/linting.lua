local M = {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
}

M.config = function()
  local lint = require("lint")

  lint.linters_by_ft = {
    -- bash = { "shellcheck", "editorconfig-checker" },
    bash = { "editorconfig-checker" },
    lua = { "editorconfig-checker" },
    -- sh = { "shellcheck", "editorconfig-checker" },
    sh = { "editorconfig-checker" },
    yaml = { "yamllint", "editorconfig-checker" },
    -- javascript = { "eslint_d" },
    -- typescript = { "eslint_d" },
    -- javascriptreact = { "eslint_d" },
    -- typescriptreact = { "eslint_d" },
    -- svelte = { "eslint_d" },
    -- python = { "ruff" },
    -- ansible = { "ansbile_lint" },
  }

  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = lint_augroup,
    callback = function()
      lint.try_lint()
    end,
  })

  vim.keymap.set("n", "<leader>lc", function()
    lint.try_lint()
  end, { desc = "Check File/Lint" })

  vim.keymap.set("n", "<leader>ll", function()
    print(M.list_linters())
  end, { desc = "List Linters" })
end

M.list_linters = function()
  local linters = require("lint").get_running()
  if #linters == 0 then
    return "󰦕 No linters"
  end
  return "󱉶 " .. table.concat(linters, ", ")
end

return M
