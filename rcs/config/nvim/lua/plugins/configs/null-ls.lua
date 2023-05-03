-- Null-ls
local utils = require("core/utils")
local settings = require("core/user-settings")

return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "williamboman/mason.nvim",
      "jay-babu/mason-null-ls.nvim"
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          -- Linters
          "ansible-lint",
          "cfn-lint",
          "cmakelint",
          "commitlint",
          "flake8",
          "jsonlint",
          "luacheck",
          "markdownlint",
          "shellcheck",
          "sqlfluff",
          "stylelint",
          "vint",
          "write-good",
          "yamllint",
          -- Formatters
          "black",
          "clang-format",
          "gofumpt",
          "google-java-format",
          "ktlint",
          "prettier",
          "rubocop",
          "rustfmt",
--          "shfmt",
          "sqlfmt",
          "stylua",
        },
        automatic_installation = false,
        automatic_setup = true,
        handlers = {},
      })

      local augroup = vim.api.nvim_create_augroup("LspFormatting", { })
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- code actions
          null_ls.builtins.code_actions.cspell,
          null_ls.builtins.code_actions.eslint,
          null_ls.builtins.code_actions.gitrebase,
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.code_actions.refactoring,
          null_ls.builtins.code_actions.shellcheck,
          -- completions
          null_ls.builtins.completion.luasnip,
          -- diagnostics (linting)
          null_ls.builtins.diagnostics.ansiblelint,
          null_ls.builtins.diagnostics.cfn_lint,
          null_ls.builtins.diagnostics.checkmake,
          null_ls.builtins.diagnostics.checkstyle.with({
            extra_args = { "-c", "/google_checks.xml" }, -- or "/sun_checks.xml" or path to self written rules
          }),
          null_ls.builtins.diagnostics.chktex,
          null_ls.builtins.diagnostics.clang_check,
          null_ls.builtins.diagnostics.cmake_lint,
          null_ls.builtins.diagnostics.commitlint,
          null_ls.builtins.diagnostics.cspell,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.diagnostics.hadolint, -- dockerfile
          null_ls.builtins.diagnostics.jsonlint,
          null_ls.builtins.diagnostics.ktlint,
          null_ls.builtins.diagnostics.luacheck,
          null_ls.builtins.diagnostics.markdownlint,
          null_ls.builtins.diagnostics.markuplint, -- html
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
          null_ls.builtins.diagnostics.write_good,
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
--          null_ls.builtins.formatting.shfmt,
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
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            if utils.safeRead(settings.formatOnSave, false)
            then
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({
                    bufnr = bufnr,
                    filter = function(client)
                      return client.name == "null-ls"
                    end
                  })
                end,
              })
            end
          end
        end,

        -- should_attach = function(bufnr)
        --   return false
        -- end
      })
    end,
  }
}
