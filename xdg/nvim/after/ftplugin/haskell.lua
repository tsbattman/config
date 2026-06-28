-- Haskell filetype settings
vim.opt_local.makeprg = "cabal new-build"
vim.cmd("syntax sync fromstart")

-- LSP hls configured in lua/plugins/lsp.lua
-- Linting with hlint configured in lua/plugins/linting.lua
-- No auto-format on save for Haskell (as per plan)
