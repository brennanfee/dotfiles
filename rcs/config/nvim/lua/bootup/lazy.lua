local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  require("core.bootstrap").lazy(lazypath)
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  ui = {
    border = "rounded",
  },
  checker = {
    enabled = true,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
})
