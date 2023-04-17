-- Custom settings that can be set here and read from other scripts as needed
-- Basically, this saves me from having to hunt around for where these are set
local userSettings = {}

-- theme method: builtin or plugin
userSettings.themeMethod = "plugin"
-- theme options: onedark, darkplus, onedarker, plus any built-in theme
userSettings.theme = "onedark"
-- theme variant, if the theme supports variants
userSettings.themeVariant = "darker"
-- theme for the line bar at bottom (lualine or other plugin)
userSettings.lineTheme = "onedark"

-- Toggle global status line
userSettings.global_statusline = true
-- use rg instead of grep
userSettings.grepprg = "rg --hidden --vimgrep --smart-case --"
-- set numbered lines
userSettings.number = true
-- set relative numbered lines
userSettings.relative_number = true

-- Should files be auto formatted
userSettings.formatOnSave = true

return userSettings
