-- Directories for backup files, swaps, and undo files
vim.o.backupdir = vim.fn.stdpath("cache") .. "/backup//"
vim.o.directory = vim.fn.stdpath("cache") .. "/swap//"
vim.o.undodir = vim.fn.stdpath("cache") .. "/undo//"

vim.opt.backup = false -- creates a backup file
vim.opt.writebackup = true
vim.opt.swapfile = true
vim.opt.undofile = true

-- Ensure editorconfig integration is turned on
vim.g.editorconfig = true
vim.g.awk_is_gawk = 1

vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard

vim.opt.fileencodings = "utf-8,ucs-bom,default,latin1" -- prefer utf-8 over all others
vim.opt.bomb = false -- do not use a byte order mark
vim.opt.fileformats = "unix" -- only work in "unixy" files with <CR>
vim.opt.endofline = true
vim.opt.endoffile = false
vim.opt.fixendofline = true
vim.opt.modeline = true

vim.opt.conceallevel = 0 -- so that `` is visible in markdown files

-- Tweak performance
vim.opt.timeout = true
vim.opt.timeoutlen = 400 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.updatetime = 200 -- faster completion
vim.g.cursorhold_updatetime = 300 -- faster completion

-- Line numbers
-- if vim.api.nvim_buf_get_var(0, "modifiable") then
--   vim.opt.number = true
--   vim.opt.relativenumber = false
-- end
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.numberwidth = 5 -- set number column width {default 4}
vim.opt.ruler = false
vim.opt.signcolumn = "yes:2" -- always show signcolumns

vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- how many columns a tab counts for
vim.opt.softtabstop = 2
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.shiftround = true -- Round indent

vim.opt.cursorline = true -- highlight the current line
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)

vim.opt.showcmd = false
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
--vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.pumblend = 10

-- vim.opt.showtabline = 2 -- always show tabs
vim.opt.showtabline = 1 -- always show tabs
vim.opt.laststatus = 3

vim.opt.hlsearch = true
vim.opt.gdefault = true
vim.opt.smartcase = true
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.inccommand = "split" -- Get a preview of replacements

vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window

vim.opt.scrolloff = 5 -- Minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 5 -- The minimal number of columns to scroll horizontally

vim.opt.hidden = true
vim.opt.visualbell = true

vim.opt.mouse = "a" -- Enable mouse mode

vim.opt.foldenable = false -- disable folding; enable with zi
local status_ok, _ = pcall(require, "nvim-treesitter")
if not status_ok then
  vim.opt.foldmethod = "indent"
else
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
end

vim.opt.list = true
--o.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣"
--o.listchars = "tab:>·,trail:~,extends:>,precedes:<"
vim.opt.listchars = { tab = " ", trail = "~", extends = ">", precedes = "<", nbsp = "␣", lead = "⋅" }

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = "++ "

vim.opt.iskeyword:remove("_")

vim.opt.shortmess:append("c") -- prevent "pattern not found" messages

vim.opt.colorcolumn = "80,100"
vim.opt.breakindent = true -- Enable break indent

-- Allows neovom to send the Terminal details of the current window, instead of just getting 'v'
vim.opt.title = true

vim.opt.grepprg = "rg --hidden --vimgrep --smart-case --"

vim.opt.spelllang = { "en_us,en" }
vim.opt.spell = false -- off by default

-- A comma separated list of options for Insert mode completion
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }

vim.opt.fillchars = vim.opt.fillchars + "eob: "
vim.opt.fillchars:append({
  stl = " ",
})

vim.opt.wildignorecase = true -- When set case is ignored when completing file names and directories
vim.opt.wildignore = [[
.git,.hg,.svn
*.aux,*.out,*.toc
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
*.mp3,*.oga,*.ogg,*.wav,*.flac
*.eot,*.otf,*.ttf,*.woff
*.doc,*.pdf,*.cbr,*.cbz
*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
*.swp,.lock,.DS_Store,.directory,._*
*/tmp/*,*.so,*.swp,*.zip,**/node_modules/**,**/target/**,**.terraform/**"
]]

vim.opt.whichwrap:append("<,>,[,]") -- Wrap movement between lines in edit mode with arrows
vim.opt.iskeyword:append("-") -- Add dash to the match keywords

vim.g.netrw_banner = 0
vim.g.netrw_mouse = 2
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath("data") .. "/mason/bin"
