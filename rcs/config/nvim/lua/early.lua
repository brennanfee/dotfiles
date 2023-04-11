-- Keep only to settings required early in the load process
local utils = require("functions")

-- Python interpreter
if utils.file_exists('${XDG_DATA_HOME}/asdf/shims/python') then
  vim.g.python3_host_prog = vim.fs.normalize('${XDG_DATA_HOME}/asdf/shims/python')
elseif utils.file_exists('~/.local/share/asdf/shims/python') then
  vim.g.python3_host_prog = vim.fs.normalize('~/.local/share/asdf/shims/python')
elseif utils.file_exists("/usr/bin/python3") then
  vim.g.python3_host_prog = vim.fs.normalize('/usr/bin/python3')
elseif utils.file_exists("/bin/python3") then
  vim.g.python3_host_prog = vim.fs.normalize('/bin/python3')
-- TODO: Add windows paths
end

-- Ruby interpreter
if utils.file_exists('${XDG_DATA_HOME}/asdf/shims/neovim-ruby-host') then
  vim.g.ruby_host_prog = vim.fs.normalize('${XDG_DATA_HOME}/asdf/shims/neovim-ruby-host')
elseif utils.file_exists('~/.local/share/asdf/shims/neovim-ruby-host') then
  vim.g.ruby_host_prog = vim.fs.normalize('~/.local/share/asdf/shims/neovim-ruby-host')
elseif utils.file_exists("/usr/bin/neovim-ruby-host") then
  vim.g.ruby_host_prog = vim.fs.normalize('/usr/bin/neovim-ruby-host')
-- TODO: Add windows paths
end

-- Node interpreter
if utils.file_exists('${XDG_DATA_HOME}/asdf/shims/neovim-node-host') then
  vim.g.node_host_prog = vim.fs.normalize('${XDG_DATA_HOME}/asdf/shims/neovim-node-host')
elseif utils.file_exists('~/.local/share/asdf/shims/neovim-node-host') then
  vim.g.node_host_prog = vim.fs.normalize('~/.local/share/asdf/shims/neovim-node-host')
elseif utils.file_exists("/usr/bin/neovim-node-host") then
  vim.g.node_host_prog = vim.fs.normalize('/usr/bin/neovim-node-host')
-- TODO: Add windows paths
end

-- Load impatient if it is available
--local status_ok, impatient = pcall(require, "impatient")
--if not status_ok then
--  return
--end

--impatient.enable_profile()
