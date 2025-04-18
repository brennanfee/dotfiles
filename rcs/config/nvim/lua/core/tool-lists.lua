local M = {}

M.lsp_servers = {
  { name = "ansiblels", config = {} },
  { name = "autotools_ls", config = {} },
  { name = "awk_ls", config = {} },
}

-- M.lsp_servers = {
--   { name = "ansiblels", config = {} },
--   { name = "autotools_ls", config = {} },
--   { name = "awk_ls", config = {} },
--   -- { name = "bacon-ls", config = {} }, -- For Rust (not in lspconfig yet)
--   { name = "basedpyright", config = {} }, -- Pyright replacement
--   { name = "bashls", config = {} },
--   { name = "biome", config = {} },
--   { name = "clangd", config = {} },
--   { name = "cmake", config = {} },
--   { name = "cobol_ls", config = {} },
--   { name = "csharp_ls", config = {} },
--   { name = "css_variables", config = {} },
--   { name = "cssls", config = {} },
--   { name = "cssmodules_ls", config = {} },
--   { name = "cucumber_language_server", config = {} },
--   { name = "docker_compose_language_service", config = {} },
--   { name = "dockerls", config = {} },
--   -- { name = "eslint", config = {} }, -- Use Biome instead
--   { name = "fortls", config = {} },
--   { name = "gopls", config = {} },
--   { name = "graphql", config = {} },
--   -- { name = "harper_ls", config = {} },
--   { name = "html", config = {} },
--   { name = "htmx", config = {} },
--   { name = "jdtls", config = {} }, -- Java
--   { name = "jinja_lsp", config = {} },
--   { name = "jsonls", config = {} },
--   { name = "kotlin_language_server", config = {} },
--   { name = "lemminx", config = {} }, -- Xml language server
--   -- { name = "ltex", config = {} },
--   { name = "lua_ls", config = {} },
--   { name = "markdown_oxide", config = {} },
--   { name = "marksman", config = {} },
--   -- { name = "nginx_language_server", config = {} },
--   -- { name = "nil_ls", config = {} }, -- Fails to install
--   { name = "perlnavigator", config = {} },
--   { name = "phpactor", config = {} },
--   { name = "powershell_es", config = {} },
--   { name = "rubocop", config = {} },
--   { name = "ruby_lsp", config = {} },
--   { name = "ruff", config = {} }, -- Python
--   { name = "rust_analyzer", config = {} }, -- Switch to bacon_ls
--   -- { name = "salt_ls", config = {} }, -- Seems to be broken
--   -- { name = "snyk_ls", config = {} }, -- Security scanning
--   { name = "sqlls", config = {} },
--   { name = "stylelint_lsp", config = {} },
--   { name = "svelte", config = {} },
--   { name = "tailwindcss", config = {} },
--   { name = "taplo", config = {} }, -- TOML language server
--   { name = "terraformls", config = {} },
--   { name = "tflint", config = {} },
--   { name = "tinymist", config = {} }, -- Typst
--   { name = "ts_ls", config = {} },
--   { name = "typos_lsp", config = {} },
--   { name = "vacuum", config = {} }, -- OpenAPI/Swagger
--   { name = "vimls", config = {} },
--   { name = "vuels", config = {} },
--   { name = "yamlls", config = {} },
-- }

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
utils.tableAppendList(M.all_except_lsps, M.debug_adapters)
utils.tableAppendList(M.all_except_lsps, M.linters)
utils.tableAppendList(M.all_except_lsps, M.formatters)
utils.tableAppendList(M.all_except_lsps, M.misc_tools)

for _, server in pairs(M.lsp_servers) do
  table.insert(M.all_tools, server.name)
end
utils.tableAppendList(M.all_tools, M.all_except_lsps)

return M
