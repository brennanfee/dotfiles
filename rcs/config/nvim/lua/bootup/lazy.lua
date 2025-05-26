local utils = require("tools.utils")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").lazy(lazypath)
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- spec = utils.lazyPluginSpecs,
  spec = {
    { import = "plugins" },
    -- TODO: Remove the extras folder and merge plugins into main area, use 'enabled = false' to turn on experimental
    -- plugins
    { import = "plugins.extras" },
  },
  install = {
    colorscheme = { utils.theme, "default" },
  },
  ui = {
    border = "rounded",
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
})
