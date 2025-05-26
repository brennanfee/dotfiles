local M = {}

-- Check if a variable is not empty nor nil
M.isNotEmpty = function(s)
  return s ~= nil and s ~= ""
end

-- Check if a variable is empty or nil
M.isEmpty = function(s)
  return s == nil or s == ""
end

-- Append a table to another table
M.tableAppendList = function(t1, t2)
  for _, v in pairs(t2) do
    table.insert(t1, v)
  end
  return t1
end

return M
