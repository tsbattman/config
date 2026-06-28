-- Key mappings ported from .vimrc

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

-- LSP keymaps (set in lsp.lua on_attach)
-- gd - go to definition
-- gr - references
-- K - hover documentation
-- <leader>rn - rename
-- <leader>ca - code actions
-- <leader>f - format
