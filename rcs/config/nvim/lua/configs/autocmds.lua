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
    bufnr = vim.api.nvim_get_current_buf()
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

vim.cmd [[
  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end
]]
