
return {
  "williamboman/mason.nvim",
  dependencies = "WhoIsSethDaniel/mason-tool-installer.nvim",
  cmd = {
    "Mason", "MasonUpdate", "MasonInstall", "MasonUninstall", "MasonUninstallAll",
    "MasonLog",
  },
  build = ":MasonUpdate", -- :MasonUpdate updates registry contents
  opts = {
    ensure_installed = {
      -- Language Servers
      "ansible-language-server", "awk-language-server", "bash-language-server",
      "buf-language-server", "clangd", "cmake-language-server",
      "csharp-language-server", "css-lsp", "cucumber-language-server",
      "docker-compose-language-service", "dockerfile-language-server",
      "eslint-lsp", "gopls", "graphql-language-service-cli", "html-lsp",
      -- "java-language-server",
      "jdtls", "json-lsp", "kotlin-language-server", "lemminx", -- xml language server
      "ltex-ls", "lua-language-server", "marksman", "nginx-language-server",
      "perlnavigator", "powershell-editor-services", "prosemd-lsp",
      "pyright", "ruby-lsp", "rust-analyzer", "salt-lsp", "sqlls",
      "svelte-language-server", "taplo", "terraform-ls",
      "typescript-language-server", "vim-language-server", "vue-language-server",
      "yaml-language-server",

      -- Debug Adapters
      "bash-debug-adapter", -- "chrome-debug-adapter", -- doesn't seem to work
      "cpptools", "delve", -- go debugger
      "firefox-debug-adapter", "java-debug-adapter", "js-debug-adapter",
      "kotlin-debug-adapter", "node-debug2-adapter", "php-debug-adapter",
      "debugpy",

      -- Linters
      "actionlint", "ansible-lint", "cfn-lint", "cmakelint", "cspell",
      "commitlint", "cpplint", "editorconfig-checker", "eslint_d", "flake8",
      "hadolint", --dockerfile linter
      "jsonlint", "ktlint", "luacheck", "markdownlint", "phpstan", "proselint",
      "shellcheck", "sqlfluff", "stylelint", "tflint", "tfsec", "vint",
      "write-good", "yamllint",

      -- Formatters
      "beautysh", "blackd-client", "buf", "cbfmt", "clang-format", "cmakelang",
      "csharpier", "fixjson", "gofumpt", "google-java-format", "luaformatter",
      "markdown-toc", "php-cs-fixer", "prettierd", "rubocop", "rustfmt",
      -- "shfmt",
      "sqlfmt", "stylua", "yamlfmt",

      -- Other tools
      "gh", "gitui", "glow", "jq", "yq",
    },

    PATH = "skip",

    pip = {
      upgrade_pip = true,
    },

    ui = {
      icons = {
        package_pending = " ",
        package_installed = " ",
        package_uninstalled = " ﮊ",
      },
    },

    max_concurrent_installers = 10,
  },
  config = function(_, opts)
    require("mason").setup(opts)

    require('mason-tool-installer').setup({
      ensure_installed = opts.ensure_installed,
      run_on_start = false,
    })

    vim.api.nvim_create_user_command("UpdateAll", function()
      vim.cmd("Lazy sync")
      vim.cmd("MasonToolsUpdate")
    end, {})

    vim.g.mason_binaries_list = opts.ensure_installed
  end,
}
