local M = {}

M.lsp_servers = {
  "ansiblels",
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

M.debug_adapters = {
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
}

M.linters = {
  "actionlint",
  "ansible-lint",
  "cfn-lint",
  "checkmake",
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
  "semgrep",
  "shellcheck",
  -- "snyk",
  "sqlfluff",
  "stylelint",
  "tflint",
  "tfsec",
  "vint",
  "write-good",
  "yamllint",
}

M.formatters = {
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
}

M.misc_tools = {
  "ast-grep",
  "gh",
  "gitui",
  "glow",
  "jq",
  "yq",
}

M.all_except_lsps = {
  unpack(M.debug_adapters),
  unpack(M.linters),
  unpack(M.formatters),
  unpack(M.misc_tools),
}

M.all_tools = {
  unpack(M.all_except_lsps),
  unpack(M.lsp_servers),
}

return M
