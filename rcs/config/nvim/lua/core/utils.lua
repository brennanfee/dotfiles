local M = {}

M.lazyPluginSpecs = {}

function M.plugin(item)
  table.insert(M.lazyPluginSpecs, { import = item })
end

-- check if a variable is not empty nor nil
M.isNotEmpty = function(s)
  return s ~= nil and s ~= ""
end

M.safeRead = function(s, default)
  if s == nil or s == "" then
    return default
  else
    return s
  end
end

M.file_exists = function(name)
  return vim.fn.filereadable(vim.fs.normalize(name)) ~= 0
end

M.bufdelete = function(bufnum)
  local ok, mini = pcall(require, "mini.bufremove")
  if ok then
    mini.delete(bufnum, true)
  else
    vim.cmd("bdelete " .. bufnum)
  end
end

M.keymap = function(mode, lhs, rhs, opts)
  local options = {} -- noremap already default to true for vim.keymap.set
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

M.theme_colors = function()
  local theme = M.themePackage
  local themeColors
  if theme == "oncedark" then
    themeColors = require("oncedark.helpers").get_colors()
  elseif theme == "onedark" then
    themeColors = require("onedark.colors")
  elseif theme == "onedarkpro" then
    themeColors = require("onedarkpro.helpers").get_colors()
  else
    -- these should match the default Neovim theme
    themeColors = {
      black = "#0e1013",
      bg0 = "#1f2329",
      bg1 = "#282c34",
      bg2 = "#30363f",
      bg3 = "#323641",
      bg_d = "#181b20",
      bg_blue = "#61afef",
      bg_yellow = "#e8c88c",
      fg = "#a0a8b7",
      purple = "#bf68d9",
      green = "#8ebd6b",
      orange = "#cc9057",
      blue = "#4fa6ed",
      yellow = "#e2b86b",
      cyan = "#48b0bd",
      red = "#e55561",
      grey = "#535965",
      light_grey = "#7a818e",
      dark_cyan = "#266269",
      dark_red = "#8b3434",
      dark_yellow = "#835d1a",
      dark_purple = "#7e3992",
      diff_add = "#272e23",
      diff_delete = "#2d2223",
      diff_change = "#172a3a",
      diff_text = "#274964",
    }
  end

  return themeColors
end

return M
