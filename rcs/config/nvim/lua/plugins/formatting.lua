local M = {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
}

M.config = function()
  local conform = require("conform")

  local function first(bufnr, ...)
    local conform = require("conform")
    for i = 1, select("#", ...) do
      local formatter = select(i, ...)
      if conform.get_formatter_info(formatter, bufnr).available then
        return formatter
      end
    end
    return select(1, ...)
  end

  conform.setup({
    formatters_by_ft = {
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      svelte = { "prettierd", "prettier", stop_after_first = true },
      vue = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },
      less = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      markdown = function(bufnr)
        return { first(bufnr, "prettierd", "prettier"), "injected" }
      end,
      graphql = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "yamlfmt" },
      xml = { "xmllint" }, -- xmlformatter
      lua = { "stylua" },
      -- python = { "ruff" },
      python = { "ruff_organize_imports", "ruff_format", "ruff_fix" },
      go = { "goimports", "gofmt" },
      perl = { "perlimports", "perltidy" },
      typst = { "prettypst" }, -- typstyle
      rust = { "rustfmt" },
      sh = { "shfmt", "shellcheck" },
      bash = { "shfmt", "shellcheck" },
      toml = { "taplo" }, -- ??
      terraform = { "terraform_fmt" },
      tofu = { "tofu_fmt" },
      zig = { "zigfmt" },
      hcl = { "hcl" }, -- terragrunt_hclfmt
      packer = { "packer_fmt" },
      -- php = { "" },
      -- c, c++, c#
      -- java
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = {
      async = false,
      timeout_ms = 1000,
    },
  })

  vim.keymap.set({ "n", "v" }, "<leader>lf", function()
    conform.format({
      lsp_fallback = true,
      async = true,
      timeout_ms = 1000,
    })
  end, { desc = "Format" })
end

return M
