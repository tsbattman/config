-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- Options
-- ============================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "
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

-- ============================================================================
-- Keymaps
-- ============================================================================

local map = vim.keymap.set

-- Don't use Ex mode, use Q for formatting
map("n", "Q", "gq", { desc = "Format with gq" })

-- Centered paragraph movement
map("n", "}", "}zz", { desc = "Next paragraph (centered)" })
map("n", "{", "{zz", { desc = "Previous paragraph (centered)" })

-- File finder (fzf-lua)
map("n", "<leader>o", "<cmd>FzfLua files<cr>", { desc = "Find files" })

-- Live grep (fzf-lua)
map("n", "<leader>rg", "<cmd>FzfLua live_grep<cr>", { desc = "Live grep" })

-- Reload as GB18030 encoding
map("n", "<leader>cn", "<cmd>edit ++enc=gb18030<cr>", { desc = "Reload as GB18030" })

-- ============================================================================
-- Clipboard
-- ============================================================================

-- First try to use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Fallback pbcopy/pbpaste mappings for OSX
if vim.fn.has("mac") == 1 then
  map("v", "<leader>y", ":w !pbcopy<CR><CR>", { desc = "Copy to pbcopy" })
  map("n", "<leader>y", ":w !pbcopy<CR><CR>", { desc = "Copy to pbcopy" })
  map("v", "<leader>p", ":r!pbpaste<CR>", { desc = "Paste from pbpaste" })
  map("n", "<leader>p", ":r!pbpaste<CR>", { desc = "Paste from pbpaste" })
end

-- ============================================================================
-- Autocommands
-- ============================================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Disable visual bell on GUI enter
autocmd("GUIEnter", {
  group = augroup("DisableVisualBell", { clear = true }),
  callback = function()
    vim.opt.visualbell = true
    vim.opt.t_vb = ""
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- ============================================================================
-- Load plugins
-- ============================================================================

require("lazy").setup("plugins", {
  checker = { enabled = false },
  change_detection = { notify = false },
})
