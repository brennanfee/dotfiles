local settings = require("user-conf")
local utils = require("functions")
local o = vim.opt
local fn = vim.fn

-- Directories for backup files, swaps, and undo files
o.backupdir = "$XDG_DATA_HOME/nvim/backup//,$HOME/.local/share/nvim/backup//," .. fn.stdpath("data") .. "/backup//,."
o.directory = "$XDG_DATA_HOME/nvim/swap//,$HOME/.local/share/nvim/swap//," .. fn.stdpath("data") .. "/swap//"
o.undodir = "$XDG_DATA_HOME/nvim/undo//,$HOME/.local/share/nvim/undo//," .. fn.stdpath("data") .. "/undo//"

o.backup = false
--o.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
o.swapfile = false
o.undofile = true

-- Block cursor in nomral modes, vertical bean in insert modes
o.guicursor = "n-v-c-sm:block-blinkwait50-blinkon50-blinkoff50,i-ci-ve:ver25-Cursor-blinkon100-blinkoff100,r-cr-o:hor20"

o.clipboard = "unnamedplus" -- allows neovim to access the system clipboard

o.fileencoding = "utf-8" -- the encoding written to a file

o.conceallevel = 0 -- so that `` is visible in markdown files

-- Tweak performance
o.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds)
o.updatetime = 300 -- faster completion
vim.g['cursorhold_updatetime'] = '300' -- faster completion

-- Line numbers
if utils.isNotEmpty(settings.number) then
  o.number = settings.number
else
  o.number = true
end

if utils.isNotEmpty(settings.relative_number) then
  o.relativenumber = settings.relative_number
else
  o.relativenumber = false
end

o.expandtab = true -- Use spaces instead of tabs
o.shiftwidth = 2 -- the number of spaces inserted for each indentation
o.tabstop = 2 -- how many columns a tab counts for
o.softtabstop = 2
o.smartindent = true -- make indenting smarter again
o.shiftround = true -- Round indent

o.cursorline = true -- highlight the current line
o.termguicolors = true -- set term gui colors (most terminals support this)

o.lazyredraw = true -- do not redraw screen while running macros

o.showmode = false -- we don't need to see things like -- INSERT -- anymore
--o.cmdheight = 2 -- more space in the neovim command line for displaying messages
o.pumheight = 10 -- pop up menu height

o.showtabline = 2 -- always show tabs
if utils.isNotEmpty(settings.global_statusline) and settings.global_statusline then
  o.laststatus = 3
else
  o.laststatus = 2
end

o.hlsearch = true
o.smartcase = true
o.ignorecase = true -- ignore case in search patterns
o.inccommand = "split" -- Get a preview of replacements

o.splitbelow = true -- force all horizontal splits to go below current window
o.splitright = true -- force all vertical splits to go to the right of current window

o.scrolloff = 5 -- Minimal number of screen lines to keep above and below the cursor
o.sidescrolloff = 5 -- The minimal number of columns to scroll horizontally

o.mouse = "a"

o.foldenable = false -- disable folding; enable with zi
o.foldmethod = "indent"
--o.foldmethod = "expr"
--o.foldexpr = "nvim_treesitter#foldexpr()"

o.numberwidth = 4 -- set line number column width
o.signcolumn = "yes" -- always show signcolumns
--o.signcolumn = "yes:1" -- always show signcolumns

o.list = true
--o.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣"
--o.listchars = "tab:>·,trail:~,extends:>,precedes:<"
o.listchars = { tab = " ", trail = "~", extends = ">", precedes = "<", nbsp = "␣", lead = "⋅" }

o.wrap = true
o.linebreak = true
o.showbreak = "++ "

o.shortmess:append "c" -- prevent "pattern not found" messages
--o.shortmess = o.shortmess + "c" -- prevent "pattern not found" messages

o.colorcolumn = "100"

o.title = true -- Allows neovom to send the Terminal details of the current window, instead of just getting 'v'

if utils.isNotEmpty(settings.grepprg) then
  o.grepprg = settings.grepprg
end

o.spelllang = { "en_us,en-rare" }

o.completeopt = { "menu", "menuone", "noselect", "noinsert" } -- A comma separated list of options for Insert mode completion

o.wildignorecase = true -- When set case is ignored when completing file names and directories
o.wildignore = [[
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

o.guifont = "monospace:h17" -- the font used in graphical neovim applications

vim.cmd "set whichwrap+=<,>,[,]" -- Wrap movement between lines in edit mode with arrows
vim.cmd "set iskeyword+=-" -- Add dash to the match keywords

-- enable filetype.lua
-- This feature is currently opt-in
-- as it does not yet completely match all of the filetypes covered by filetype.vim
vim.g.do_filetype_lua = 1
-- disable filetype.vim
vim.g.did_load_filetypes = 0
