-- C++ filetype settings
vim.opt_local.cindent = true
vim.cmd("syntax sync fromstart")

-- LSP clangd configured in lua/plugins/lsp.lua
-- No auto-format on save for C++ (as per plan)
