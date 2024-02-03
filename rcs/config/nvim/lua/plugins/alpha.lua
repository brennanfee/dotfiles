local M = {
  "goolord/alpha-nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VimEnter",
}

function M.config()
  local dashboard = require("alpha.themes.dashboard")
  local icons = require("core.icons")

  local function button(sc, txt, keybind, keybind_opts)
    local b = dashboard.button(sc, txt, keybind, keybind_opts)
    b.opts.hl_shortcut = "Include"
    return b
  end

  dashboard.section.header.val = {
    "    ███    ██ ██    ██ ██ ███    ███",
    "    ████   ██ ██    ██ ██ ████  ████",
    "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
    "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
    "    ██   ████   ████   ██ ██      ██",
  }

  dashboard.section.buttons.val = {
    button("f", icons.ui.Files .. " Find file", ":Telescope find_files <CR>"),
    button("n", icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>"),
    button(
      "p",
      icons.git.Repo .. " Find project",
      ":lua require('telescope').extensions.projects.projects()<CR>"
      --":Telescope projects <CR>"
    ),
    button("r", icons.ui.History .. " Recent files", ":Telescope oldfiles <CR>"),
    button("t", icons.ui.Text .. " Find text", ":Telescope live_grep <CR>"),
    button(
      "c",
      icons.ui.Gear .. " Config",
      ":lua vim.cmd('e ' .. vim.fn.stdpath('config') .. '/init.lua') <CR>"
    ),
    button("q", icons.ui.SignOut .. " Quit", ":qa<CR>"),
  }

  local function footer()
    -- NOTE: requires the fortune-mod package to work
    local handle = io.popen("fortune")
    local fortune
    if handle ~= nil then
      fortune = handle:read("*a")
      handle:close()
    else
      fortune = "You need to install the 'fortune-mod' package for this message to change."
    end
    return fortune
  end

  dashboard.section.footer.val = footer()

  dashboard.section.header.opts.hl = "Keyword"
  dashboard.section.buttons.opts.hl = "Include"
  dashboard.section.footer.opts.hl = "Type"

  dashboard.opts.opts.noautocmd = true
  require("alpha").setup(dashboard.opts)

  local alpha_group = vim.api.nvim_create_augroup("AlphaGroup", { clear = true })

  vim.api.nvim_create_autocmd("User", {
    group = alpha_group,
    pattern = "LazyVimStarted",
    callback = function()
      local ok, lazy = pcall(require, "lazy")
      if ok then
        local stats = lazy.stats()

        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

        local msg = "Loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        vim.notify(msg)
      end
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    group = alpha_group,
    pattern = "AlphaReady",
    callback = function()
      -- TODO: Convert to lua
      vim.cmd([[
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]])
    end,
  })
end

return M
