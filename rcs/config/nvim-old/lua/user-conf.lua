-- Custom settings that can be set here and read from other scripts as needed
-- Basically, this saves me from having to hunt around for where these are set
local userConf = {}

-- theme options: onedark, darkplus, onedarker, plus any built-in theme
userConf.theme = "onedark"
-- theme variant, if the theme supports variants
userConf.themeVariant = "darker"

-- Toggle global status line
userConf.global_statusline = true
-- use rg instead of grep
userConf.grepprg = "rg --hidden --vimgrep --smart-case --"
-- set numbered lines
userConf.number = true
-- set relative numbered lines
userConf.relative_number = true

return userConf
