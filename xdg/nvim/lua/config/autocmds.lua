-- Autocommands ported from .vimrc

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
