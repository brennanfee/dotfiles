local NoAutoCommentGrp = vim.api.nvim_create_augroup("NoAutoCommentGrp", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  group = NoAutoCommentGrp,
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

-- Allow q to close certain windows
local QToCloseGrp = vim.api.nvim_create_augroup("QToCloseGrp", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = QToCloseGrp,
  pattern = {
    "netrw",
    "Jaq",
    "qf",
    "git",
    "help",
    "man",
    "lspinfo",
    "oil",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
    "TelescopePrompt",
    "",
  },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
  end,
})

local CmdWinEnterClose = vim.api.nvim_create_augroup("CmdWinEnterClose", { clear = true })
vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
  group = CmdWinEnterClose,
  callback = function()
    vim.cmd("quit")
  end,
})

-- Auto resize vim window
local AutoResizeGrp = vim.api.nvim_create_augroup("AutoResizeGrp", { clear = true })
vim.api.nvim_create_autocmd("VimResized", {
  group = AutoResizeGrp,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

local CheckTimeGrp = vim.api.nvim_create_augroup("CheckTimeGrp", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  group = CheckTimeGrp,
  pattern = { "*" },
  callback = function()
    vim.cmd("checktime")
  end,
})

-- Highlight on yank
local YankHighlightGrp = vim.api.nvim_create_augroup("YankHighlightGrp", { clear = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = YankHighlightGrp,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- Filetypes to turn spelling and wrapping on
local SpellAndWrapGrp = vim.api.nvim_create_augroup("SpellAndWrapGrp", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = SpellAndWrapGrp,
  pattern = {
    "git",
    "gitcommit",
    "gitsendemail",
    "*commit*",
    "*COMMIT*",
    "NeogitCommitMessage",
    "markdown",
  },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- File specific settings
-- TODO: Convert to lua
vim.cmd([[
  augroup filetypes_mappings
    autocmd!
    autocmd BufNewFile,BufFilePre,BufRead LICENSE setlocal filetype=text
    autocmd BufNewFile,BufFilePre,BufRead license setlocal filetype=text
    autocmd BufNewFile,BufFilePre,BufRead License setlocal filetype=text
  augroup END
]])
