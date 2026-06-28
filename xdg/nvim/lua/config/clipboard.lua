-- OSX clipboard integration using pbcopy/pbpaste
-- This is a fallback in case system clipboard doesn't work

local map = vim.keymap.set

-- First try to use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Fallback pbcopy/pbpaste mappings for OSX
if vim.fn.has("mac") == 1 then
  -- Copy to clipboard
  map("v", "<leader>y", ":w !pbcopy<CR><CR>", { desc = "Copy to pbcopy" })
  map("n", "<leader>y", ":w !pbcopy<CR><CR>", { desc = "Copy to pbcopy" })

  -- Paste from clipboard
  map("v", "<leader>p", ":r!pbpaste<CR>", { desc = "Paste from pbpaste" })
  map("n", "<leader>p", ":r!pbpaste<CR>", { desc = "Paste from pbpaste" })
end
