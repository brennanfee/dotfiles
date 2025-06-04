local M = {}

-- Check if a variable is not empty nor nil
M.isNotEmpty = function(s)
  return s ~= nil and s ~= ""
end

-- Check if a variable is empty or nil
M.isEmpty = function(s)
  return s == nil or s == ""
end

M.trimString = function(s)
  return s:match("^()%s*$") and "" or s:match("^%s*(.*%S)")
end

M.stringStartsWith = function(s, start)
  return s:sub(1, #start) == start
end

-- Append a table to another table
M.tableAppendList = function(t1, t2)
  for _, v in pairs(t2) do
    table.insert(t1, v)
  end
  return t1
end

M.systemNotification = function(s)
  vim.fn.system("notify-send '" .. s .. "'")
end

M.getSystemExe = function(s)
  local path = M.trimString(vim.fn.system("mise which " .. s))
  if M.isEmpty(path) or M.stringStartsWith(path, "mise ERROR") then
    path = M.trimString(vim.fn.system("which " .. s))
  end

  return path
end

M.tableToString = function(tbl)
  local result = "{"
  for k, v in pairs(tbl) do
    -- Check the key type (ignore any numerical keys - assume its an array)
    if type(k) == "string" then
      result = result .. '["' .. k .. '"]' .. "="
    end

    -- Check the value type
    if type(v) == "table" then
      result = result .. M.tableToString(v)
    elseif type(v) == "boolean" then
      result = result .. tostring(v)
    else
      result = result .. '"' .. v .. '"'
    end
    result = result .. ","
  end
  -- Remove leading commas from the result
  if result ~= "" then
    result = result:sub(1, result:len() - 1)
  end
  return result .. "}"
end

return M
