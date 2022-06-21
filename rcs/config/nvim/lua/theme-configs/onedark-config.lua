local settings = require("user-conf")
local utils = require("functions")
local onedark = require("onedark")

local colorscheme = "default"
if utils.isNotEmpty(settings.theme) then
  colorscheme = settings.theme
end

if colorscheme ~= "onedark" then
  return
end

local variant = "darker"
if utils.isNotEmpty(settings.themeVariant) then
  variant = settings.themeVariant
end

onedark.setup{
  style = variant
}

onedark.load()
