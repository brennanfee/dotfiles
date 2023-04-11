local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
  debug = false,
  sources = {
    diagnostics.ansiblelint,
    diagnostics.chktex,
    --diagnostics.codespell,
    diagnostics.cppcheck,
    --diagnostics.editorconfig_checker,
    diagnostics.eslint,
    diagnostics.flake8,
    diagnostics.gitlint,
    diagnostics.jsonlint,
    --diagnostics.luacheck,
    diagnostics.markdownlint,
    diagnostics.mdl,
    diagnostics.proselint,
    diagnostics.shellcheck,
    diagnostics.stylelint,
    --diagnostics.textlint,
    diagnostics.tidy,
    diagnostics.tsc,
    diagnostics.vint,
    --diagnostics.write_good,
    diagnostics.yamllint,

    formatting.black.with { extra_args = { "--fast" } },
    formatting.clang_format,
    --formatting.fixjson,
    formatting.gofumpt,
    formatting.goimports,
    --formatting.lua_format,
    --formatting.markdownlint,
    --formatting.mdformat,
    formatting.prettier.with {
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" }
    },
    formatting.rustfmt,
    --formatting.shellharden,
    formatting.shfmt,
    --formatting.stylelint,
    formatting.stylua,
    --formatting.terrafmt,
    formatting.terraform_fmt,
    --formatting.tidy,
    --formatting.uncrustify,
    --formatting.xmllint,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- NOTE: on < 0.8, you should use vim.lsp.buf.formatting_sync() instead
          --vim.lsp.buf.format({ bufnr = bufnr })
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
}
