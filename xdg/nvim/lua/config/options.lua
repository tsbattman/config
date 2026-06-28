-- Core vim options ported from .vimrc

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable Python recommended style
vim.g.python_recommended_style = 0

-- UI
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.showmatch = true
vim.opt.laststatus = 2
vim.opt.ruler = true
vim.opt.shortmess = "aTI"
vim.opt.signcolumn = "yes"

-- Split behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Indentation
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.smartindent = true

-- Wrapping and scrolling
vim.opt.wrap = false
vim.opt.scrolloff = 2
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 5

-- Folding
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99

-- Completion
vim.opt.wildignore = "*.fasl,*.o,*.class,*.hi,*.pyc,*.so,*.exe"

-- Formatting
vim.opt.formatoptions = "tcroq"

-- Backups and swap
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- History
vim.opt.history = 50
vim.opt.viminfo = "'20,<500,\"500"

-- Misc
vim.opt.backspace = "2"
vim.opt.autoread = true
vim.opt.mouse = "a"

-- Grep
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"

-- Bell
vim.opt.errorbells = false
vim.opt.visualbell = true
