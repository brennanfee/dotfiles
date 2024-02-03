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
    "awk_ls",
    "bashls",
    "biome",
    "clangd",
    "cmake",
    "csharp_ls",
    "cssls",
    "cucumber_language_server",
    "docker_compose_language_service",
    "dockerls",
    "eslint",
    "gopls",
    "graphql",
    "html",
    -- "java_language_server",
    "jdtls",
    "jsonls",
    "kotlin_language_server",
    "lemminx", -- xml language server
    -- "ltex",
    "lua_ls",
    "marksman",
    -- "nginx-language-server",
    "perlnavigator",
    "powershell_es",
    "pyright",
    "ruby_ls",
    "rust_analyzer",
    -- "salt_ls",
    "sqlls",
    "svelte",
    "taplo", -- TOML language server
    "terraformls",
    "tsserver",
    "vimls",
    "vuels",
    "yamlls",
  }

  local servers = {
    -- Language Servers
    "ansiblels",
    "awk_ls",
    "bashls",
    "biome",
    "clangd",
    "cmake",
    "csharp_ls",
    "cssls",
    "cucumber_language_server",
    "docker_compose_language_service",
    "dockerls",
    "eslint",
    "gopls",
    "graphql",
    "html",
    -- "java_language_server",
    "jdtls",
    "jsonls",
    "kotlin_language_server",
    "lemminx", -- xml language server
    -- "ltex",
    "lua_ls",
    "marksman",
    -- "nginx-language-server",
    "perlnavigator",
    "powershell_es",
    "pyright",
    "ruby_ls",
    "rust_analyzer",
    -- "salt_ls",
    "sqlls",
    "svelte",
    "taplo", -- TOML language server
    "terraformls",
    "tsserver",
    "vimls",
    "vuels",
    "yamlls",

    -- Debug Addapters
    "bash-debug-adapter", -- "chrome-debug-adapter", -- doesn't seem to work
    "cpptools",
    "delve", -- go debugger
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
    --"commitlint", I'll manually install this (with asdf and node)
    "cpplint",
    "editorconfig-checker",
    "eslint_d",
    "flake8",
    "hadolint", --dockerfile linter
    "jsonlint",
    "ktlint",
    "luacheck",
    "markdownlint",
    "misspell",
    "phpstan",
    "proselint",
    "shellcheck",
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
    run_on_start = false,
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
