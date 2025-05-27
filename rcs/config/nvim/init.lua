require("bootup.providers")
require("bootup.options")
require("bootup.options-gui")

-- And now, the plugin manager and plugins
require("bootup.lazy")

require("bootup.keymaps")
require("bootup.autocmds")

vim.o.background = "dark"
vim.cmd.colorscheme("catppuccin-mocha")
