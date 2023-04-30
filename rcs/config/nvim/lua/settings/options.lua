local utils = require("core/utils")
local settings = require("core/user-settings")
local o = vim.opt
local fs = vim.fs
local fn = vim.fn

-- Directories for backup files, swaps, and undo files
o.backupdir = fn.stdpath('cache') .. '/backup//'
o.directory = fn.stdpath('cache') .. '/swap//'
o.undodir = fn.stdpath('cache') .. '/undo//'

o.backup = false
o.writebackup = true
o.swapfile = true
o.undofile = true

-- Colorscheme (this is a fallback for when a plugin based theme is not being used)
if utils.safeRead(settings.themeMethod, "builtin") == "builtin" then
  local colorscheme = utils.safeRead(settings.theme, "default")

  -- load the colorscheme without a config
  local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
  if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
  end
end

-- Ensure editorconfig integration is turned on
vim.g.editorconfig = true

o.clipboard = "unnamedplus" -- allows neovim to access the system clipboard

o.fileencodings = "utf-8,ucs-bom,default,latin1" -- prefer utf-8 over all others
o.bomb = false -- do not use a byte order mark

o.fileformats = "unix" -- only work in "unixy" files with <CR>
o.endofline = true
o.endoffile = false
o.fixendofline = true

o.conceallevel = 0 -- so that `` is visible in markdown files

-- Tweak performance
o.timeout = true
o.timeoutlen = 400 -- time to wait for a mapped sequence to complete (in milliseconds)
o.updatetime = 250 -- faster completion
vim.g.cursorhold_updatetime = 300 -- faster completion

-- Line numbers
if vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "modifiable")
then
  o.number = utils.safeRead(settings.number, true)
  o.relativenumber = utils.safeRead(settings.relative_number, false)
end
o.ruler = false

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
if utils.safeRead(settings.global_statusline, true) then
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

o.mouse = "a" -- Enable mouse mode

o.foldenable = false -- disable folding; enable with zi
local status_ok, ts = pcall(require, "nvim-treesitter")
if not status_ok then
  o.foldmethod = "indent"
else
  o.foldmethod = "expr"
  o.foldexpr = "nvim_treesitter#foldexpr()"
end

o.numberwidth = 4 -- set line number column width
o.signcolumn = "yes:2" -- always show signcolumns

o.list = true
--o.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣"
--o.listchars = "tab:>·,trail:~,extends:>,precedes:<"
o.listchars = { tab = " ", trail = "~", extends = ">", precedes = "<", nbsp = "␣", lead = "⋅" }

o.wrap = true
o.linebreak = true
o.showbreak = "++ "

o.shortmess:append "c" -- prevent "pattern not found" messages

o.colorcolumn = "80,100"
vim.o.breakindent = true -- Enable break indent

-- Allows neovom to send the Terminal details of the current window, instead of just getting 'v'
o.title = true

if utils.isNotEmpty(settings.grepprg) then
  o.grepprg = settings.grepprg
end

o.spelllang = { "en_us,en" }

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

o.whichwrap:append "<,>,[,]" -- Wrap movement between lines in edit mode with arrows
o.iskeyword:append "-" -- Add dash to the match keywords

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath "data" .. "/mason/bin"

-- GUI settings
-- Block cursor in nomral modes, vertical beam in insert modes
--o.guicursor = "n-v-c-sm:block-blinkwait50-blinkon50-blinkoff50,i-ci-ve:ver25-Cursor-blinkon100-blinkoff100,r-cr-o:hor20"

--o.guifont = "monospace:h17" -- the font used in graphical neovim applications
