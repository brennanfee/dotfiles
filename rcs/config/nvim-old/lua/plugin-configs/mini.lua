local status_ok, miniSurround = pcall(require, "mini.surround")
if not status_ok then
  return
end

miniSurround.setup({})

require('mini.bufremove').setup({})
