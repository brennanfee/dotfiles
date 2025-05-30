local M = {
  "williamboman/mason.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  build = ":MasonUpdate", -- :MasonUpdate updates registry contents
}

function M.config()
  local mason = require("mason")
  local tool_lists = require("data.tool-lists")

  mason.setup({
    ensure_installed = tool_lists.all_mason_tools,
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

  require("mason-tool-installer").setup({
    ensure_installed = tool_lists.all_mason_tools,
    run_on_start = true,
    -- auto_update = true,
    auto_update = false,
    integrations = {
      ["mason-lspconfig"] = true,
      ["mason-null-ls"] = false,
      ["mason-nvim-dap"] = true,
    },
  })

  vim.api.nvim_create_user_command("MasonDoUpdate", function()
    require("lazy").sync({ wait = true, show = false })
    vim.cmd("MasonUpdate")
    vim.cmd("MasonToolsUpdateSync")
    vim.cmd("MasonToolsClean")
  end, {})
end

return M
