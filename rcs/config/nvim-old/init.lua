-- Early settings
require("early")
-- Plugin management and settings should be first
require("plugins")
-- Color scheme
require("colorscheme")
-- Non-plugin related options
require("options")
-- Final keyboard mappings/overrides
require("mappings")
-- Vim autocommands/autogroups
require("autocmds")

-- Override the whitespace highlight group
--vim.cmd([[highlight Whitespace guifg=#223E55 gui=nocombine]])
