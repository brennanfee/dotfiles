local api = vim.api

--- Remove all trailing whitespace on save
--- Note: In neovim 0.9+ this was made more complicated by the editorconfig integration.
--- I am respecting the editor config settings here and am only performing the
--- trim when there are no editorconfig values set (and thus no editorconfig settings
--- were found).  If there were editorconfig values set the integration will have already
--- done the trim or skipped the trim based on the values in the configs.
local TrimWhiteSpaceGrp = api.nvim_create_augroup("TrimWhiteSpaceGrp", { clear = true })
api.nvim_create_autocmd("BufWritePre", {
  group = TrimWhiteSpaceGrp,
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.b[bufnr].editorconfig == nil or
      vim.b[bufnr].editorconfig["trim_trailing_whitespace"] == nil
    then
      local view = vim.fn.winsaveview()
      vim.api.nvim_command('silent! undojoin')
      vim.api.nvim_command('silent keepjumps keeppatterns %s/\\s\\+$//e')
      vim.fn.winrestview(view)
    end
  end,
})

-- don't auto comment new line
local NoAutoCommentGrp = api.nvim_create_augroup("NoAutoCommentGrp", { clear = true })
api.nvim_create_autocmd("BufEnter", {
  group = NoAutoCommentGrp,
  command = [[set formatoptions-=cro]],
})
api.nvim_create_autocmd("BufWinEnter", {
  group = NoAutoCommentGrp,
  command = [[set formatoptions-=cro]],
})

-- Only show the cursor in the active buffer
local CursorActiveBufferGrp = api.nvim_create_augroup("CursorActiveBufferGrp", { clear = true })
api.nvim_create_autocmd("BufEnter", {
  group = CursorActiveBufferGrp,
  command = [[setlocal cursorline]],
})
api.nvim_create_autocmd("BufLeave", {
  group = CursorActiveBufferGrp,
  command = [[setlocal nocursorline]],
})

local WrapAndSpellFileSettingsGrp = api.nvim_create_augroup("WrapAndSpellFileSettingsGrp", { clear = true })
api.nvim_create_autocmd("FileType", {
  group = WrapAndSpellFileSettingsGrp,
  pattern = { "gitcommit", "text", "markdown" },
  command = [[
    setlocal wrap
    setlocal spell
  ]],
})

local AutoResizeGrp = api.nvim_create_augroup("AutoResizeGrp", { clear = true })
api.nvim_create_autocmd("VimResized", {
  group = AutoResizeGrp,
  command = [[tabdo wincmd =]],
})

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = highlight_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ timeout = 250 })
  end,
})

-- TODO: Convert to lua
vim.cmd [[
  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end
]]

-- vim.cmd [[
--   " Close vim if buffer is closed and there are no more buffers
--   function! CloseOnLastBuffer()
--     let cnt = 0
--     for nr in range(1, bufnr("$"))
--       if buflisted(nr) && ! empty(bufname(nr)) || getbufvar(nr, '&buftype') ==# 'help'
--         let cnt += 1
--       endif
--     endfor

--     if cnt == 1
--       :q
--     endif
--   endfunction

--   augroup close_on_last_buffer
--     autocmd!
--     autocmd BufDelete * call CloseOnLastBuffer()
--   augroup END
-- ]]

-- File specific settings
-- TODO: Convert to lua
vim.cmd [[
  augroup filetypes_mappings
    autocmd!
    autocmd BufNewFile,BufFilePre,BufRead LICENSE setlocal filetype=text
    autocmd BufNewFile,BufFilePre,BufRead license setlocal filetype=text
    autocmd BufNewFile,BufFilePre,BufRead * if match(getline(1), "---") >= 0 | setlocal filetype=yaml | endif
  augroup END
]]

vim.cmd[[
  " Git commits - Turn spellcheck on
  augroup gitcommit_group
    autocmd!
    autocmd FileType git,gitcommit,gitsendemail,*commit*,*COMMIT* setlocal spell
  augroup END
]]

local function open_nvim_tree(data)
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

local dir_tree_group = vim.api.nvim_create_augroup('DirTreeGroup', { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = dir_tree_group,
  callback = open_nvim_tree,
})
