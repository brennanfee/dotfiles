local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local k = vim.keymap

-- Make sure the leader key doesn't do anything else
k.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

------ Normal Mode Mappings ------
-- Remap for dealing with line wrap
k.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
k.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Diagnostic keymaps
k.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
k.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
k.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
k.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Better window navigation
k.set('n', "<C-h>", "<C-w>h", opts)
k.set('n', "<C-j>", "<C-w>j", opts)
k.set('n', "<C-k>", "<C-w>k", opts)
k.set('n', "<C-l>", "<C-w>l", opts)

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
k.set("n", "<S-l>", ":bnext<CR>", opts)
k.set("n", "<S-h>", ":bprevious<CR>", opts)
--k.set("n", "gt", ":bnext<CR>", opts)
--k.set("n", "gT", ":bprevious<CR>", opts)
k.set("n", "gt", "<cmd> BufferLineCycleNext <CR>", opts)
k.set("n", "gT", "<cmd> BufferLineCyclePrev <CR>", opts)
k.set("n", "gx", ":lua require('mini.bufremove').delete()<CR>", opts)
-- Alternates
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

------ Insert Mode Mappings ------
-- Press jk fast to exit insert mode
k.set("i", "jk", "<ESC>", opts)

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

------ Terminal Mode Mappings ------
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
