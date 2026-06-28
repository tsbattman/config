-- Python filetype settings
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.cmd("syntax sync fromstart")

-- Formatting and linting handled by conform.nvim and nvim-lint
-- Auto-format on save configured in lua/plugins/formatting.lua
