local settings = require("user-conf")
local utils = require("functions")

local colorscheme = "default"
if utils.isNotEmpty(settings.theme) then
  colorscheme = settings.theme
end

-- load the colorscheme without a config
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
