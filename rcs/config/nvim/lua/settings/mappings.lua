local utils = require("core.utils")
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- TODO: Convert all to new method and remove this local variable
-- Shorten function name
local k = vim.keymap

------ Multiple Mode Mappings ------
-- Make sure the leader key doesn't do anything else
k.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with line wrap
k.set({ 'n', 'x' }, 'j', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
  { expr = true, silent = true }) -- move down
k.set({ 'n', 'x' }, 'k', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
  { expr = true, silent = true }) -- move up
k.set({ 'n', 'v' }, '<Down>', 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
  { expr = true, silent = true }) -- move down
k.set({ 'n', 'v' }, '<Up>', 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
  { expr = true, silent = true }) -- move up

------ Normal Mode Mappings ------
-- Diagnostic keymaps
-- These are now attached to the buffer by LSP
--k.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
--k.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
--k.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
--k.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Better window navigation
k.set('n', "<C-h>", "<C-w>h", opts) -- window left
k.set('n', "<C-j>", "<C-w>j", opts) -- window down
k.set('n', "<C-k>", "<C-w>k", opts) -- window up
k.set('n', "<C-l>", "<C-w>l", opts) -- window right

-- Resize with arrows
k.set("n", "<C-Up>", ":resize -2<CR>", opts)
k.set("n", "<C-Down>", ":resize +2<CR>", opts)
k.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
k.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Also resize with ctrl+shift+hjkl
k.set("n", "<C-S-h>", ":resize -2<CR>", opts)
k.set("n", "<C-S-j>", ":resize +2<CR>", opts)
k.set("n", "<C-S-k>", ":vertical resize -2<CR>", opts)
k.set("n", "<C-S-l>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
-- k.set("n", "<S-l>", ":bnext<CR>", opts)
-- k.set("n", "<S-h>", ":bprevious<CR>", opts)
--k.set("n", "gt", ":bnext<CR>", opts)
--k.set("n", "gT", ":bprevious<CR>", opts)
k.set("n", "<S-l>", "<cmd> BufferLineCycleNext <CR>", opts)
k.set("n", "<S-h>", "<cmd> BufferLineCyclePrev <CR>", opts)
k.set("n", "gt", "<cmd> BufferLineCycleNext <CR>", opts)
k.set("n", "gT", "<cmd> BufferLineCyclePrev <CR>", opts)
k.set("n", "gx", ":lua require('mini.bufremove').delete()<CR>", opts)
-- Alternates
-- k.set("n", "gn", ":bnext<CR>", opts)
-- k.set("n", "gN", ":bprevious<CR>", opts)
k.set("n", "gn", "<cmd> BufferLineCycleNext <CR>", opts)
k.set("n", "gN", "<cmd> BufferLineCyclePrev <CR>", opts)

-- Move text up and down
k.set("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
k.set("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Add add blank line above/below current line
k.set("n", "gO", "O<Esc>", opts)
k.set("n", "go", "o<Esc>2k", opts)

-- Better movements to start and end of line
k.set("n", "gh", "0", opts)
k.set("n", "gl", "$", opts)
k.set("n", "gs", "^", opts)

-- Toggle spelling
utils.map_key("n", "<leader>z", function()
  vim.opt_local.spell = not vim.opt_local.spell:get()
end, { desc = "Toggle Spell Checking" })

-- From NvChad
k.set('n', "<Esc>", ":noh <CR>", opts) -- clear highlights

k.set('n', "<C-s>", "<cmd> w <CR>", opts) -- save file

k.set('n', "<C-c>", "<cmd> %y+ <CR>", opts) -- copy whole file

k.set('n', "<leader>n", "<cmd> set nu! <CR>", opts) -- toggle line number
k.set('n', "<leader>rn", "<cmd> set rnu! <CR>", opts) -- toggle relative number

k.set('n', "<leader>en", "<cmd> enew <CR>", opts) -- new buffer

------ Insert Mode Mappings ------
-- Press jk fast to exit insert mode
k.set("i", "jk", "<ESC>", opts)
-- (From NvChad)
-- remap C-K for unicode "[C]haracter" entry
k.set("i", "<C-c>", "<C-k>", opts)
-- beginning and end of line
k.set("i", "<C-b>", "<ESC>^i", opts) -- beginning of line
k.set("i", "<C-e>", "<End>", opts) -- end of line
-- navigate within insert mode
k.set("i", "<C-h>", "<Left>", opts) -- move left
k.set("i", "<C-j>", "<Right>", opts) -- move right
k.set("i", "<C-k>", "<Down>", opts) -- move down
k.set("i", "<C-l>", "<Up>", opts) -- move up

------ Visual Mode Mappings ------
-- Stay in indent mode
k.set("v", "<", "<gv", opts)
k.set("v", ">", ">gv", opts)

-- Move text up and down
k.set("v", "<A-j>", ":m .+1<CR>==", opts)
k.set("v", "<A-k>", ":m .-2<CR>==", opts)
k.set("v", "p", '"_dP', opts)

------ Visual Block Mode Mappings ------
-- Move text up and down
k.set("x", "J", ":move '>+1<CR>gv-gv", opts)
k.set("x", "K", ":move '<-2<CR>gv-gv", opts)
k.set("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
k.set("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
k.set("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', opts) -- don't copy replaced text

------ Terminal Mode Mappings ------
-- From NvChad
k.set("t", "<C-x>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true),
  term_opts) -- escape terminal mode

-- Better terminal navigation
-- k.set("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- k.set("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- k.set("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- k.set("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Ideas
-- =, format entire document
-- ={motion}, format Nmove text
-- visual mode, =, format selection
-- gy, go to type definition (lsp)
-- gr, go to references (lsp)
-- gi, to to implementation (LSP)
