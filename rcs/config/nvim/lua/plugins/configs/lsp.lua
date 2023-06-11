-- LSP plugins and config
local utils = require("core.utils")
local settings = require("core.user-settings")

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- Useful status updates for LSP
      { "j-hui/fidget.nvim", opts = {}, tag = "legacy" },
      -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
    init = function()
      utils.lazy_load("nvim-lspconfig")
      local map = utils.map_key

      -- Global mappings
      map("n", "<leader>of", function()
        vim.diagnostic.open_float({ border = "rounded" })
      end, { desc = "LSP: [F]loating Diagnostics" })
      map("n", "[d", function()
        vim.diagnostic.goto_prev()
      end, { desc = "LSP: Goto Previous [D]iagnostic" })
      map("n", "]d", function()
        vim.diagnostic.goto_next()
      end, { desc = "LSP: Goto Next [D]iagnostic" })
      map("n", "<leader>q", function()
        vim.diagnostic.setloclist()
      end, { desc = "LSP: Diagnostics Setloclist" })
    end,
    config = function()
      require("fidget").setup()
      require("neodev").setup()

      -- Language Server customizations
      --   Add any additional override configuration will be passed to the `settings`
      --   field of the server config.
      local server_configs = {
        lua_ls = { -- filetypes: lua
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = { enable = false },
          },
        },
        docker_compose_language_service = {
          filetypes = { "none" },
        },
        yamlls = {
          yaml = {
            format = {
              enable = false, -- using prettier instead
            },
            keyOrdering = false,
            redhat = {
              telemetry = {
                enabled = false,
              },
            },
          },
          redhat = {
            telemetry = {
              enabled = false,
            },
          },
        },
      }

      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach_callback = function(_, bufnr)
        -- vim.notify("attach client: " .. vim.inspect(client.id))
        -- vim.notify("attach buffer: " .. vim.inspect(bufnr))
        local map = utils.map_key

        map("n", "gD", function()
          vim.lsp.buf.declaration()
        end, { buffer = bufnr, desc = "LSP: [G]oto [D]eclaration" })
        map("n", "gd", function()
          vim.lsp.buf.definition()
        end, { buffer = bufnr, desc = "[G]oto [D]efinition" })
        map("n", "K", function()
          vim.lsp.buf.hover()
        end, { buffer = bufnr, desc = "Hover" })
        map("n", "gi", function()
          vim.lsp.buf.implementation()
        end, { buffer = bufnr, desc = "[G]oto [I]mplementation" })
        map("n", "<leader>ls", function()
          vim.lsp.buf.signature_help()
        end, { buffer = bufnr, desc = "[L]sp [S]ignature" })
        map("n", "<leader>D", function()
          vim.lsp.buf.type_definition()
        end, { buffer = bufnr, desc = "Type [D]efinition" })
        --nmap("<leader>ra", equire("nvchad_ui.renamer").open(), "[R]en[a]me")
        map("n", "<leader>ca", function()
          vim.lsp.buf.code_action()
        end, { buffer = bufnr, desc = "[C]ode [A]ction" })
        map("n", "gr", function()
          vim.lsp.buf.references()
        end, { buffer = bufnr, desc = "[G]oto [R]eferences" })
        map("n", "<leader>fm", function()
          vim.lsp.buf.format({ async = true })
        end, { buffer = bufnr, desc = "[F]ormat" })
        map("n", "<leader>wa", function()
          vim.lsp.buf.add_workspace_folder()
        end, { buffer = bufnr, desc = "[A]dd [W]orkspace Folder" })
        map("n", "<leader>wr", function()
          vim.lsp.buf.remove_workspace_folder()
        end, { buffer = bufnr, desc = "[R]emove [W]orkspace Folder" })
        map("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, { buffer = bufnr, desc = "[L]ist [W]orkspace Folders" })

        -- nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        -- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        -- nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        -- nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        -- nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- -- See `:help K` for why this keymap
        -- nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- -- Lesser used LSP functionality
        -- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        -- nmap('<leader>wl', function()
        --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
          vim.lsp.buf.format()
        end, { desc = "LSP: Format current buffer with LSP" })

        -- vim.notify("attach done: " .. vim.inspect(bufnr))
      end

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capability_settings = vim.lsp.protocol.make_client_capabilities()
      capability_settings = require("cmp_nvim_lsp").default_capabilities(capability_settings)
      capability_settings.textDocument.completion.completionItem.snippetSupport = true

      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        --        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = false,
        automatic_setup = false,
      })

      local get_servers = mason_lspconfig.get_installed_servers

      for _, server_name in ipairs(get_servers()) do
        settings = {}
        if server_configs[server_name] ~= nil then
          settings = server_configs[server_name]
        end

        if settings.filetypes ~= nil then
          require("lspconfig")[server_name].setup({
            capabilities = capability_settings,
            on_attach = on_attach_callback,
            settings = settings,
            filetypes = settings.filetypes,
          })
        else
          require("lspconfig")[server_name].setup({
            capabilities = capability_settings,
            on_attach = on_attach_callback,
            settings = settings,
          })
        end
      end
    end,
  },
}
