local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  build = ":MasonUpdate", -- :MasonUpdate updates registry contents
}

function M.config()
  local lsp_servers = {
    "ansiblels",
    "ast_grep",
    "autotools_ls",
    "awk_ls",
    "basedpyright", -- Pyright replacement
    "bashls",
    "biome",
    "clangd",
    "cmake",
    "cobol_ls",
    "csharp_ls",
    "cssls",
    "cucumber_language_server",
    "docker_compose_language_service",
    "dockerls",
    "eslint",
    "fortls",
    "gopls",
    "graphql",
    "harper_ls",
    "html",
    "htmx",
    "jdtls", -- Java
    "jinja_lsp",
    "jsonls",
    "kotlin_language_server",
    "lemminx", -- Xml language server
    "ltex",
    "lua_ls",
    "markdown_oxide",
    "marksman",
    -- "nginx_language_server",
    "perlnavigator",
    "phpactor",
    "powershell_es",
    "rubocop",
    "ruby_lsp",
    "ruff", -- Python
    "rust_analyzer",
    --"salt_ls", -- Seems to be broken
    -- "snyk_ls", -- Security scanning
    "sqlls",
    "stylelint_lsp",
    "svelte",
    "tailwindcss",
    "taplo", -- TOML language server
    "terraformls",
    "tflint",
    "tinymist", -- Typst
    "ts_ls",
    "typos_lsp",
    "vacuum", -- OpenAPI/Swagger
    "vimls",
    "vuels",
    "yamlls",
  }

  local servers = {
    -- Language Servers
    unpack(lsp_servers),

    -- Debug Adapters
    "bash-debug-adapter", -- "chrome-debug-adapter", -- doesn't seem to work
    "cpptools",
    "delve", -- Go debugger
    "firefox-debug-adapter",
    "java-debug-adapter",
    "js-debug-adapter",
    "kotlin-debug-adapter",
    "node-debug2-adapter",
    "php-debug-adapter",
    "debugpy",

    -- Linters
    "actionlint",
    "ansible-lint",
    "cfn-lint",
    "cmakelint",
    "commitlint",
    "cpplint",
    "editorconfig-checker",
    "eslint_d",
    "flake8",
    "hadolint", -- Dockerfile linter
    "jsonlint",
    "ktlint",
    "luacheck",
    "markdownlint",
    "misspell",
    "phpstan",
    "proselint",
    "shellcheck",
    -- "snyk",
    "sqlfluff",
    "stylelint",
    "tflint",
    "tfsec",
    "vint",
    "write-good",
    "yamllint",

    -- Formatters
    "black",
    "blackd-client",
    "buf",
    "cbfmt",
    "clang-format",
    "cmakelang",
    "commitlint",
    "csharpier",
    "fixjson",
    "gofumpt",
    "google-java-format",
    "htmlhint",
    "luaformatter",
    "markdown-toc",
    "php-cs-fixer",
    "prettierd",
    "rubocop",
    "shfmt",
    "sqlfmt",
    "stylua",
    "yamlfmt",

    -- Other Tools
    "gh",
    "gitui",
    "glow",
    "jq",
    "yq",
  }

  require("mason").setup({
    ensure_installed = servers,
    PATH = "skip",
    pip = {
      upgrade_pip = true,
    },
    ui = {
      border = "rounded",
      -- TODO: Switch to icons array
      icons = {
        package_pending = " ",
        package_installed = "󰄳 ",
        package_uninstalled = " 󰚌",
      },
    },
    max_concurrent_installers = 5,
  })

  require("mason-lspconfig").setup({
    ensure_installed = lsp_servers,
  })

  require("mason-tool-installer").setup({
    ensure_installed = servers,
    run_on_start = true,
  })

  vim.api.nvim_create_user_command("AutoUpdate", function()
    require("lazy").sync({ wait = true, show = false })
    --vim.cmd("MasonToolsUpdate")
  end, {})

  vim.api.nvim_create_user_command("DoUpdate", function()
    require("lazy").sync({ wait = true, show = false })
    vim.cmd("MasonToolsUpdate")
  end, {})

  vim.g.mason_binaries_list = servers
end

return M
