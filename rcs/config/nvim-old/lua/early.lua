-- Keep only to settings required early in the load process
local utils = require("functions")

-- Python interpreter
if utils.file_exists("~/.local/share/asdf/shims/python") then
  vim.cmd "let g:python3_host_prog = expand('~/.local/share/asdf/shims/python')"
elseif utils.file_exists("/usr/bin/python3") then
  vim.cmd "let g:python3_host_prog = '/usr/bin/python3'"
elseif utils.file_exists("/bin/python3") then
  vim.cmd "let g:python3_host_prog = '/bin/python3'"
-- TODO: Add windows paths
end

-- Load impatient if it is available
local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
  return
end

impatient.enable_profile()
