-- Null-ls
local utils = require("core.utils")
local settings = require("core.user-settings")

return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- code actions
          null_ls.builtins.code_actions.eslint_d,
          null_ls.builtins.code_actions.gitrebase,
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.code_actions.refactoring,
          null_ls.builtins.code_actions.shellcheck,
          -- completions
          null_ls.builtins.completion.luasnip,
          null_ls.builtins.completion.spell,
          null_ls.builtins.completion.tags,
          -- diagnostics (linting)
          null_ls.builtins.diagnostics.ansiblelint,
          null_ls.builtins.diagnostics.cfn_lint.with({
            filetypes = { "cloudformation", "cfn" },
          }),
          null_ls.builtins.diagnostics.checkmake,
          null_ls.builtins.diagnostics.checkstyle.with({
            extra_args = { "-c", "/google_checks.xml" }, -- or "/sun_checks.xml" or path to self written rules
          }),
          null_ls.builtins.diagnostics.chktex,
          null_ls.builtins.diagnostics.clang_check,
          null_ls.builtins.diagnostics.cmake_lint,
          null_ls.builtins.diagnostics.commitlint,
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.diagnostics.hadolint, -- dockerfile
          null_ls.builtins.diagnostics.jsonlint,
          null_ls.builtins.diagnostics.ktlint,
          null_ls.builtins.diagnostics.luacheck,
          null_ls.builtins.diagnostics.markdownlint,
          null_ls.builtins.diagnostics.markuplint, -- html
          null_ls.builtins.diagnostics.misspell.with({
            extra_args = { "-locale", "US" },
          }),
          null_ls.builtins.diagnostics.php,
          null_ls.builtins.diagnostics.rubocop,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.diagnostics.sqlfluff.with({
            -- change to your dialect
            -- others: athena, mysql, oracle, postgres, redshift, sqlite, t-sql
            extra_args = { "--dialect", "postgres" },
          }),
          null_ls.builtins.diagnostics.stylelint,
          null_ls.builtins.diagnostics.terraform_validate,
          null_ls.builtins.diagnostics.tfsec,
          null_ls.builtins.diagnostics.tidy,
          null_ls.builtins.diagnostics.trail_space,
          null_ls.builtins.diagnostics.tsc,
          null_ls.builtins.diagnostics.vint, -- vimscript
          null_ls.builtins.diagnostics.write_good.with({
            extra_args = { "--no-passive" },
          }),
          null_ls.builtins.diagnostics.yamllint,
          -- Formatting
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.cmake_format,
          null_ls.builtins.formatting.gofumpt,
          null_ls.builtins.formatting.google_java_format,
          null_ls.builtins.formatting.ktlint,
          null_ls.builtins.formatting.packer, -- hcl files
          null_ls.builtins.formatting.perltidy,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.rubocop,
          null_ls.builtins.formatting.rustfmt,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.sqlfluff.with({
            -- change to your dialect
            -- others: athena, mysql, oracle, postgres, redshift, sqlite, tsql
            extra_args = { "--dialect", "postgres" },
          }),
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.taplo, -- toml
          null_ls.builtins.formatting.terraform_fmt,
          -- Hover
          null_ls.builtins.hover.printenv,
        },

        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            if utils.safeRead(settings.formatOnSave, false) then
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
    end,
  },
}
