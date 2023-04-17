-- LSP configurations

-- Enable the following language servers
--   Add any additional override configuration will be passed to the `settings`
--   field of the server config.
local servers = {
  ansiblels = {}, -- filetypes: yaml.ansible
  awk_ls = {}, -- filetypes: awk
  bashls = {}, -- filetypes: sh
  clangd = {}, -- filetypes: c, cpp, objc, objcpp, cuda, proto -- alternatives: sourcekit
  cmake = {}, -- filetypes: cmake -- alternatives: neocmake
  csharp_ls = {}, -- filetypes: cs -- alternatives: omnisharp, omnisharp-mono
  cssls = {}, -- filetypes: css, scss, less -- alternatives: stylelint-lsp, unocss
  cucumber_language_server = {}, -- filetypes: cucumber
  --docker_compose_language_service = {}, -- filetypes: yaml --alternatives: yamlls, spectral
  dockerls = {}, -- filetypes: dockerfile
  eslint = {}, -- filetypes: javascript, javascriptreact, javascript.jsx, typescript, typescriptreact, typescript.tsx, vue, svelte, astro -- alternatives: tsserver, unocss, vtsls
  gopls = {}, -- filetypes: go, gomod, gowork, gotmpl -- alternatives: golangci_lint_ls
  graphql = {}, -- filetypes: graphql, typescriptreact, javascriptreact
  html = {}, -- filetypes: html -- alternatives: unocss
  jdtls = {}, -- filetypes: java -- alternatives: java_language_server
  jsonls = {}, -- filetypes: json, jsonc -- alternatives: spectral
  kotlin_language_server = {}, -- filetypes: kotlin
  ltex = {}, -- filetypes: bib, gitcommit, markdown, org, plaintex, rst, rnoweb, tex, pandoc -- alternatives: texlab, textlsp
  lua_ls = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  }, -- filetypes: lua
  marksman = {}, -- filetypes: markdown -- alternatives: ltex, prosemd_lsp
  perlnavigator = {}, -- filetypes: perl -- alternatives: perlls, perlpls
  powershell_es = {}, -- filetypes: ps1
  --psalm = {}, -- filetypes: php -- alternatives: phpactor, phan
  pyright = {}, -- filetypes: python -- alternatives: pylsp, pylyzer, pyre, ruff_lsp, sourcery
  ruby_ls = {}, -- filetypes: ruby -- alternatives: solargraph, sorbet, standardrb, steep, syntax_tree, typeprof
  rust_analyzer = {}, -- filetypes: rust
  salt_ls = {}, -- filetypes: sls
  sqlls = {}, -- filetypes: sql, mysql -- alternatives: sqls
  svelte = {}, -- filetypes: svelte
  taplo = {}, -- filetypes: toml
  terraformls = {}, -- filetypes: terraform, hcl -- alternatives: terraform_lsp, tflint
  --tsserver = {}, -- filetypes: javascript, javascriptreact, javascript.jsx, typescript, typescriptreact, typescript.tsx
  vimls = {}, -- filetypes: vim
  volar = {}, -- filetypes: vue -- alternatives: eslint, tsserver, unocss, vtsls, vuels
  yamlls = {}, -- filetypes: yaml, yaml.docker-compose -- alternatives: docker_compose_language_service, spectral
}

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Ensure the servers above are installed
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
  automatic_installation = true,
  automatic_setup = true,
}

mason_lspconfig.setup_handlers {
  function(server_name)
    if servers[server_name] ~= nil and servers[server_name].filetypes ~= nil
    then
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
        filetypes = servers[server_name].filetypes,
      }
    else
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
      }
    end
  end,
}
