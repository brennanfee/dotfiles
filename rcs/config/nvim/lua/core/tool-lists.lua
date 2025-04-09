local M = {}

M.lsp_servers = {
  "ansiblels",
  "autotools_ls",
  "awk_ls",
  -- "bacon-ls", -- For Rust, not in lspconfig yet
  -- "bacon_ls", -- For Rust, not in lspconfig yet
  "basedpyright", -- Pyright replacement
  "bashls",
  "biome",
  "clangd",
  "cmake",
  "cobol_ls",
  "csharp_ls",
  "css_variables",
  "cssls",
  "cssmodules_ls",
  "cucumber_language_server",
  "docker_compose_language_service",
  "dockerls",
  -- "eslint", -- Use Biome instead
  "fortls",
  "gopls",
  "graphql",
  -- "harper_ls",
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
  -- "nil_ls", -- Fails to install
  "perlnavigator",
  "phpactor",
  "powershell_es",
  "rubocop",
  "ruby_lsp",
  "ruff", -- Python
  "rust_analyzer", -- Switch to bacon_ls
  -- "salt_ls", -- Seems to be broken
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
  "bash-debug-adapter",
  -- "chrome-debug-adapter", -- doesn't seem to work
  "cpptools",
  "debugpy",
  "delve", -- Go debugger
  "firefox-debug-adapter",
  "java-debug-adapter",
  "js-debug-adapter",
  "kotlin-debug-adapter",
  "node-debug2-adapter",
  "perl-debug-adapter",
  "php-debug-adapter",
}

M.linters = {
  "actionlint",
  "alex",
  "ansible-lint",
  "ast-grep",
  "bacon", -- For Rust
  "bacon-ls", -- For Rust
  "biome",
  "buf",
  "cfn-lint",
  "checkmake",
  "checkstyle",
  "cmakelang",
  "cmakelint",
  "commitlint",
  "cpplint",
  "curlylint",
  "editorconfig-checker",
  "eslint_d",
  "flake8",
  "gitleaks",
  "gitlint",
  "hadolint", -- Dockerfile linter
  "htmlhint",
  "jsonlint",
  "ktlint",
  "luacheck",
  "markdownlint",
  "misspell",
  "oxlint",
  "phpstan",
  "proselint",
  "pydocstyle",
  "pylint",
  "rubocop",
  "ruff",
  "salt-lint",
  "selene", -- For Lua
  "semgrep",
  -- "snyk",
  "sqlfluff",
  "stylelint",
  "systemdlint",
  "textlint",
  "tflint",
  "tfsec",
  "typos",
  "vacuum",
  "vint",
  "vulture",
  "woke",
  "write-good",
  "yamllint",
}

M.formatters = {
  "ast-grep",
  "autoflake",
  "biome",
  "buf",
  "cbfmt",
  "clang-format",
  "cmakelang",
  "csharpier",
  "docformatter",
  "doctoc",
  "fixjson",
  "fprettify",
  "gci",
  "gofumpt",
  "goimports",
  "google-java-format",
  "hclfmt",
  "isort",
  "ktfmt",
  "ktlint",
  "luaformatter",
  "markdown-toc",
  "markdownlint",
  "mdformat",
  "mdsf",
  "nixpkgs-fmt",
  "php-cs-fixer",
  "pint",
  "prettier",
  "prettierd",
  "pretty-php",
  "pyment",
  "reformat-gherkin",
  "rubocop",
  "rubyfmt",
  "ruff",
  "rufo",
  "rustywind", -- For Tailwind
  "shfmt",
  "sqlfmt",
  "stylua",
  "typstfmt",
  "xmlformatter",
  "yamlfmt",
}

M.misc_tools = {
  "gh",
  "gitui",
  "glow",
  "jq",
  "yq",
}

M.all_except_lsps = {}
M.all_tools = {}

local utils = require("core/utils")
utils.tableAppend(M.all_except_lsps, M.debug_adapters)
utils.tableAppend(M.all_except_lsps, M.linters)
utils.tableAppend(M.all_except_lsps, M.formatters)
utils.tableAppend(M.all_except_lsps, M.misc_tools)

utils.tableAppend(M.all_tools, M.lsp_servers)
utils.tableAppend(M.all_tools, M.all_except_lsps)

return M
