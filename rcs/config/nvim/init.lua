-- Early settings (must be loaded before everything else)
require("core.early")

-- Bootstrap lazy.nvim if needed
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").lazy(lazypath)
end

vim.opt.rtp:prepend(lazypath)

-- Load the plugins
require ("plugins")

-- Now all the my settings
require("settings")
