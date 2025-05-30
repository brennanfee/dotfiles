local M = {}

M.echo = function(str)
  vim.cmd("redraw")
  vim.api.nvim_echo({ { str, "Bold" } }, true, {})
end

M.lazy = function(install_path)
  M.echo("This is the initial run of NeoVim, please wait will plugins are installed.\nPress any key to continue...")
  vim.fn.getchar()

  M.echo("  Installing lazy.nvim & plugins ...")

  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, install_path })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end

  M.post_bootstrap()
end

M.post_bootstrap = function()
  -- install mason pkgs & show notes\reminder to restart NeoVim on screen

  vim.api.nvim_buf_delete(0, { force = true }) -- close previously opened lazy window
  vim.cmd("echo '' | redraw") -- clear cmdline
  M.screen()

  -- vim.schedule(function()
  --   vim.cmd("MasonToolsInstall")

  --   -- Keep track of which mason pkgs get installed
  --   local packages = table.concat(vim.g.mason_binaries_list, " ")

  --   require("mason-registry"):on("package:install:success", function(pkg)
  --     packages = string.gsub(packages, pkg.name:gsub("%-", "%%-"), "") -- rm package name

  --     -- run screen func after all pkgs are installed
  --     if packages:match("%S") == nil then
  --       vim.schedule(function()
  --         vim.api.nvim_buf_delete(0, { force = true }) -- Close Mason screen
  --         vim.cmd("echo '' | redraw") -- clear cmdline
  --         M.screen()
  --       end)
  --     end
  --   end)
  -- end)
end

M.screen = function()
  local text_on_screen = {
    "",
    "",
    "",
    "NeoVim plugins have been downloaded by lazy.nvim and Mason has installed",
    "",
    "binaries for LSP, Linting, Debugging, etc.",
    "",
    "You MUST quit NeoVim and reload.  Please do so now!",
    "",
  }

  local buf = vim.api.nvim_create_buf(false, true)
  vim.opt_local.filetype = "baf_postbootstrap_window"
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, text_on_screen)

  local bafpostscreen = vim.api.nvim_create_namespace("bafpostscreen")

  vim.hl.range(buf, bafpostscreen, "LazyCommit", 1, #text_on_screen, {})
  vim.api.nvim_win_set_buf(0, buf)

  -- buf only options
  vim.opt_local.buflisted = false
  vim.opt_local.modifiable = false
  vim.opt_local.number = false
  vim.opt_local.list = false
  vim.opt_local.relativenumber = false
  vim.opt_local.wrap = false
  vim.opt_local.cul = false
end

return M
