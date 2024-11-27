local M = {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  build = ":MasonUpdate", -- :MasonUpdate updates registry contents
}

function M.config()
  local mason = require("mason")
  local tool_lists = require("core.tool-lists")

  mason.setup({
    ensure_installed = tool_lists.all_tools,
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
    ensure_installed = tool_lists.lsp_servers,
  })

  require("mason-tool-installer").setup({
    ensure_installed = tool_lists.all_tools,
    run_on_start = true,
    -- auto_update = true,
    auto_update = false,
    integrations = {
      ["mason-lspconfig"] = true,
      ["mason-null-ls"] = false,
      ["mason-nvim-dap"] = true,
    },
  })

  vim.api.nvim_create_user_command("AutoUpdate", function()
    require("lazy").sync({ wait = true, show = false })
    vim.cmd("MasonUpdate")
    vim.cmd("MasonToolsUpdateSync")
    vim.cmd("MasonToolsClean")
  end, {})

  vim.api.nvim_create_user_command("DoUpdate", function()
    require("lazy").sync({ wait = true, show = false })
    vim.cmd("MasonUpdate")
    vim.cmd("MasonToolsUpdateSync")
    vim.cmd("MasonToolsClean")
  end, {})

  -- vim.g.mason_binaries_list = tool_lists.all_tools
end

return M
