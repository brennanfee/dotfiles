------ Plugin configurations should go first

require("configs/lsp")
require("configs/autocompletion")
require("configs/telescope")
require("configs/treesitter")

------ Non-plugin related options
-- Basic vim options\settings
require("configs/options")
-- Final keyboard mappings/overrides
require("configs/mappings")
-- Vim autocommands/autogroups
require("configs/autocmds")
