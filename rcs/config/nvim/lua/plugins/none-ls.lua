local M = {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

function M.config()
  local null_ls = require("null-ls")

  local actions = null_ls.builtins.code_actions
  local completions = null_ls.builtins.completion
  local diagnostics = null_ls.builtins.diagnostics
  local formatting = null_ls.builtins.formatting

  null_ls.setup({
    debug = false,
    sources = {
      -- code actions
      -- actions.eslint_d, -- using the lsp server instead
      actions.gitrebase,
      actions.gitsigns,
      actions.refactoring,
      -- actions.shellcheck, -- using bashls language server instead
      -- completions
      completions.luasnip,
      completions.spell,
      completions.tags,
      -- diagnostis (linting)
      diagnostics.ansiblelint,
      diagnostics.cfn_lint.with({
        filetypes = { "cloudformation", "cfn" },
      }),
      diagnostics.checkmake,
      diagnostics.checkstyle.with({
        extra_args = { "-c", "/google_checks.xml" }, -- or "/sun_checks.xml" or path to self written rules
      }),
      -- diagnostics.chktex, -- using texlab instead
      -- diagnostics.clang_check, -- using clangd instead
      diagnostics.clangd,
      diagnostics.cmake_lint,
      diagnostics.commitlint,
      -- diagnostics.eslint_d, -- using the lsp server instead
      -- diagnostics.flake8, -- using ruff instead
      diagnostics.hadolint, -- dockerfile
      -- diagnostics.jsonlint,  -- using the lsp server instead
      diagnostics.ktlint,
      -- diagnostics.luacheck, -- using the lsp server instead
      diagnostics.markdownlint,
      diagnostics.markuplint, -- html
      -- diagnostics.misspell.with({
      --   extra_args = { "-locale", "US" },
      -- }),
      diagnostics.php,
      diagnostics.rubocop,
      diagnostics.ruff,
      -- diagnostics.shellcheck, -- using bashls language server instead
      diagnostics.sqlfluff.with({
        -- change to your dialect
        -- others: athena, mysql, oracle, postgres, redshift, sqlite, t-sql
        extra_args = { "--dialect", "postgres" },
      }),
      diagnostics.stylelint,
      diagnostics.terraform_validate,
      diagnostics.texlab,
      diagnostics.tfsec,
      diagnostics.tidy,
      diagnostics.trail_space,
      -- diagnostics.tsc, -- using tsserver language server instead
      diagnostics.vint, -- vimscript
      diagnostics.write_good.with({
        extra_args = { "--no-passive" },
      }),
      diagnostics.yamllint,
      -- formatting
      formatting.black,
      formatting.clang_format,
      formatting.cmake_format,
      formatting.gofumpt,
      formatting.google_java_format,
      formatting.ktlint,
      formatting.packer, -- hcl files
      -- formatting.perltidy, -- using PerlNavigator language server instead
      formatting.prettier,
      formatting.rubocop,
      -- formatting.rustfmt, -- using rust_analyzer language server instead
      formatting.shfmt,
      formatting.sqlfluff.with({
        -- change to your dialect
        -- others: athena, mysql, oracle, postgres, redshift, sqlite, tsql
        extra_args = { "--dialect", "postgres" },
      }),
      formatting.stylua,
      -- formatting.taplo, -- using taplo language server instead
      formatting.terraform_fmt,
      -- Hover
      null_ls.builtins.hover.printenv,
    },
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        -- Format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              bufnr = bufnr,
              filter = function(server)
                return server.name == "null-ls"
              end,
            })
          end,
        })
      end
    end,

    should_attach = function(bufnr)
      local bt = vim.bo[bufnr].bt
      local ft = vim.bo[bufnr].ft
      if bt ~= "" then
        return false
      end
      if ft == "" or ft == "NvimTree" or ft == "alpha" then
        return false
      end

      return true
    end,
  })
end

return M
