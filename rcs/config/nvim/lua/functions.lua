local cmd = vim.cmd
local fn = vim.fn
local fs = vim.fs

local funcs = {}

-- check if a variable is not empty nor nil
funcs.isNotEmpty = function(s)
  return s ~= nil and s ~= ""
end

funcs.file_exists = function(name)
  return fn.filereadable(fs.normalize(name)) ~= 0
end

funcs.bufdelete = function(bufnum)
  require('mini.bufremove').delete(bufnum, true)
end

return funcs
