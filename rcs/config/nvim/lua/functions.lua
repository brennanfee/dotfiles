local cmd = vim.cmd
local fn = vim.fn
local fs = vim.fs

local funcs = {}

funcs.appName = function()
  local envVar = os.getenv("NVIM_APPNAME")
  if funcs.isNotEmpty(envVar) then
    return envVar
  else
    return "nvim"
  end
end

-- check if a variable is not empty nor nil
funcs.isNotEmpty = function(s)
  return s ~= nil and s ~= ""
end

funcs.safeRead = function(s, default)
  if s == nill or s == "" then
    return default
  else
    return s
  end
end

funcs.file_exists = function(name)
  return fn.filereadable(fs.normalize(name)) ~= 0
end

funcs.bufdelete = function(bufnum)
  require('mini.bufremove').delete(bufnum, true)
end

return funcs
