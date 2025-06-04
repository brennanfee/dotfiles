local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "creativenull/efmls-configs-nvim",
    "onsails/lspkind.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
}

M.init = function()
  -- Key Mappings
  local wk_installed, wk = pcall(require, "which-key")
  if wk_installed then
    wk.add({ { "<leader>l", group = "LSP" } })
  end

  vim.keymap.set("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Next Diagnostic" })
  vim.keymap.set({ "n", "v" }, "<leader>lf", function()
    vim.lsp.buf.format({
      async = true,
      -- filter = function(client)
      --   return client.name ~= 'typescript-tools'
      -- end,
    })
  end, { desc = "Format" })
end

M.config = function()
  local tool_lists = require("data.tool-lists")

  -- LspKind
  require("lspkind").setup({
    mode = "symbol_text",
  })

  -- Default
  vim.lsp.config("*", {
    capabilities = {
      textDocument = {
        semanticTokens = {
          multilineTokenSupport = true,
        },
      },
    },
    root_markers = { ".git/" },
  })

  -- Loop the LSP servers and configure and enable them
  for _, server in pairs(tool_lists.lsp_servers) do
    local server_config = {}
    local lsp_has_config, lsp_config = pcall(require, "lspconfigs." .. server.lsp_name)
    if lsp_has_config then
      if type(lsp_config) == "function" then
        server_config = lsp_config()
      else
        server_config = lsp_config
      end
    end

    vim.lsp.config(server.lsp_name, server_config)
    vim.lsp.enable(server.lsp_name)
  end

  -- Set up an LspAttach handler
  vim.api.nvim_create_autocmd("LspAttach", { callback = M.on_attach })
end

-- local function lsp_keymaps(bufnr)
--   local opts = { noremap = true, silent = true }
--   local keymap = vim.api.nvim_buf_set_keymap
--   keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
--   keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
--   keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
--   keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
--   keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
-- end

M.on_attach = function(args)
  local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
  local bufnr = args.buf

  -- lsp_keymaps(bufnr)

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  -- Auto format on save
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function(callback_args)
        -- Must be sync (async = false) because if doing an "x" or "wq", Neovim quits without finishing
        -- the format (and without the second write when needed)
        vim.lsp.buf.format({ async = false, id = args.data.client_id })
        -- Need to check to see if format modified the buffer and if so write a second time
        local buf_modified = vim.api.nvim_buf_get_option(callback_args.buf, "modified")
        if buf_modified then
          vim.api.nvim_command("write")
        end
      end,
    })
  end
end

return M

-- local M = {
--   "neovim/nvim-lspconfig",
--   event = { "BufReadPre", "BufNewFile" },
--   dependencies = {
--     {
--       "folke/neodev.nvim",
--     },
--   },
-- }

-- local function lsp_keymaps(bufnr)
--   local opts = { noremap = true, silent = true }
--   local keymap = vim.api.nvim_buf_set_keymap
--   keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
--   keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
--   keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
--   keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
--   keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
-- end

-- M.on_attach = function(client, bufnr)
--   lsp_keymaps(bufnr)

--   if client.server_capabilities.inlayHintProvider then
--     vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
--   end
-- end

-- function M.common_capabilities()
--   local capabilities = vim.lsp.protocol.make_client_capabilities()

--   capabilities.textDocument.completion.completionItem.snippetSupport = true
--   -- capabilities.offsetEncoding = { "utf-16" }
--   capabilities.general.positionEncodings = { "utf-16" }

--   return capabilities
-- end

-- M.toggle_inlay_hints = function()
--   vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
-- end

-- function M.config()
--   -- TODO: Make pcall

--   local wk = require("which-key")
--   wk.add({
--     { "<leader>l", group = "LSP" },
--     { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
--     { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", mode = "v" },
--     -- {
--     --   "<leader>lf",
--     --   "<cmd>lua vim.lsp.buf.format({async = true,
--               filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
--     --   desc = "Format",
--     -- },
--     { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
--     { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic" },
--     {
--       "<leader>lh",
--       "<cmd>lua require('plugins.lspconfig').toggle_inlay_hints()<cr>",
--       desc = "Hints",
--     },
--     { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
--     { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
--     { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
--     { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
--   })

--   local lspconfig = require("lspconfig")
--   local icons = require("core.icons")
--   local tool_lists = require("core.tool-lists")

--   local default_diagnostic_config = {
--     signs = {
--       text = {
--         [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
--         [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
--         [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
--         [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
--       },
--       texthl = {
--         [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
--         [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
--         [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
--         [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
--       },
--       numhl = {
--         [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
--         [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
--         [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
--         [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
--       },
--     },
--     virtual_text = false,
--     virtual_lines = {
--       current_line = false,
--     },
--     update_in_insert = false,
--     underline = true,
--     severity_sort = true,
--     float = {
--       focusable = true,
--       style = "minimal",
--       border = "rounded",
--       source = "always",
--       header = "",
--       prefix = "",
--     },
--   }

--   vim.diagnostic.config(default_diagnostic_config)

--   vim.keymap.set("n", "gK", function()
--     local new_config = not vim.diagnostic.config().virtual_lines
--     vim.diagnostic.config({ virtual_lines = new_config })
--   end, { desc = "Toggle diagnostic virtual_lines" })

--   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
--   vim.lsp.handlers["textDocument/signatureHelp"] =
--       vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
--   require("lspconfig.ui.windows").default_options.border = "rounded"

--   for _, server in pairs(tool_lists.lsp_servers) do
--     local opts = {
--       on_attach = M.on_attach,
--       capabilities = M.common_capabilities(),
--       offset_encoding = "utf-16",
--     }

--     local require_ok, settings = pcall(require, "lspsettings." .. server)
--     if require_ok then
--       opts = vim.tbl_deep_extend("force", settings, opts)
--     end

--     if server == "lua_ls" then
--       require("neodev").setup({})
--     end

--     lspconfig[server].setup(opts)
--   end
-- end

-- return M
