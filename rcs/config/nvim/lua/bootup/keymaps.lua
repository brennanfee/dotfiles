-- These are the global key mappings. Any plugin specific key mappings
-- should be found in the plugins setup script. This way those mappings
-- turn off when the plugin is disabled or removed.

local opts = { noremap = true, silent = true }

-- TODO: Convert all to new method and remove this local variable
-- Shorten function name
local keymap = vim.keymap.set

keymap("n", "<C-i>", "<C-i>", opts)

------ Multiple Mode Mappings ------

-- Remap for dealing with line wrap
keymap({ "n", "x" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true, silent = true }) -- Move down
keymap({ "n", "x" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true, silent = true }) -- Move up
keymap({ "n", "v" }, "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true, silent = true }) -- Move down
keymap({ "n", "v" }, "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true, silent = true }) -- Move up

-- Better movements to start and end of line
keymap({ "n", "o", "x" }, "<s-u>", "0", opts)
keymap({ "n", "o", "x" }, "<s-h>", "^", opts)
keymap({ "n", "o", "x" }, "<s-l>", "g_", opts)

------ Normal Mode Mappings ------

-- Better window navigation
-- Now handled by Vim Tmux Navigator plugin
-- keymap('n', "<C-h>", "<C-w>h", opts) -- window left
-- keymap('n', "<C-j>", "<C-w>j", opts) -- window down
-- keymap('n', "<C-k>", "<C-w>k", opts) -- window up
-- keymap('n', "<C-l>", "<C-w>l", opts) -- window right

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Also resize with ctrl+shift+hjkl
keymap("n", "<C-S-h>", ":resize -2<CR>", opts)
keymap("n", "<C-S-j>", ":resize +2<CR>", opts)
keymap("n", "<C-S-k>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-S-l>", ":vertical resize +2<CR>", opts)

-- Keep centered while searching
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Add add blank line above/below current line
keymap("n", "gO", "O<Esc>j", opts)
keymap("n", "go", "o<Esc>k", opts)

-- Add a space before and after the cursor
keymap("n", "]<Space>", "a<Space><Esc>h", opts)
keymap("n", "[<Space>", "i<Space><Esc>l", opts)

-- Better movements to start and end of line
-- keymap("n", "gh", "0", opts)
-- keymap("n", "gl", "$", opts)
-- keymap("n", "gs", "^", opts)

-- Toggle spelling
keymap("n", "<leader>z", function()
  vim.opt_local.spell = not vim.opt_local.spell:get()
end, { noremap = true, desc = "Toggle Spell Checking" })

keymap("n", "zy", "1z=e", { noremap = true, desc = "Fix spelling with first word" })

-- Toggle wrapping
keymap("n", "<leader>w", ":lua vim.wo.wrap = not vim.wo.wrap<CR>", opts)

-- TODO: Convert to Lua
vim.cmd([[
  " :w!! to save a file as sudo when you forgot to open the file as sudo
  command WriteSudo w !sudo tee % > /dev/null
  cnoremap w!! WriteSudo
]])

-- Inspired by settings in NvChad
keymap("n", "<Esc>", ":noh <CR>", opts) -- Clear highlights

keymap("n", "<C-s>", "<cmd> w <CR>", opts) -- Save file

keymap("n", "<C-c>", "<cmd> %y+ <CR>", opts) -- Copy whole file

keymap("n", "<leader>n", "<cmd> set nu! <CR>", opts) -- Toggle line number
keymap("n", "<leader>rn", "<cmd> set rnu! <CR>", opts) -- Toggle relative number

-- Mouse mappings
vim.cmd([[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]])
vim.cmd([[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]])
-- vim.cmd [[:amenu 10.120 mousemenu.-sep- *]]

vim.keymap.set("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>:popup mousemenu<CR>")

------ Insert Mode Mappings ------
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
-- (From NvChad)
-- remap C-K for Unicode "[C]haracter" entry
keymap("i", "<C-c>", "<C-k>", opts)
-- Beginning and end of line, emacs like
keymap("i", "<C-b>", "<ESC>^i", opts) -- Beginning of line
keymap("i", "<C-e>", "<End>", opts) -- End of line
-- navigate within insert mode
keymap("i", "<C-h>", "<Left>", opts) -- Move left
keymap("i", "<C-j>", "<Right>", opts) -- Move right
keymap("i", "<C-k>", "<Down>", opts) -- Move down
keymap("i", "<C-l>", "<Up>", opts) -- Move up

------ Visual Mode Mappings ------
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

------ Visual Block Mode Mappings ------
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
keymap("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', opts) -- Don't copy replaced text
-- keymap("x", "p", [["_dP]])

-- Ideas
-- =, format entire document
-- ={motion}, format Nmove text
-- visual mode, =, format selection
-- gy, go to type definition (lsp)
-- gr, go to references (lsp)
-- gi, to to implementation (LSP)
