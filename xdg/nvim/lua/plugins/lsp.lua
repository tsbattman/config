-- LSP configuration using native vim.lsp.config API
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- LSP keymaps
    local on_attach = function(_, bufnr)
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      map("n", "gd", vim.lsp.buf.definition, "Go to definition")
      map("n", "gr", vim.lsp.buf.references, "Go to references")
      map("n", "K", vim.lsp.buf.hover, "Hover documentation")
      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
      map("n", "<leader>ca", vim.lsp.buf.code_action, "Code actions")
      map("n", "<leader>f", vim.lsp.buf.format, "Format buffer")
    end

    -- Python: pyright + ruff
    vim.lsp.config.pyright = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          },
        },
      },
    }

    vim.lsp.config.ruff = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- C++: clangd
    vim.lsp.config.clangd = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- Haskell: hls
    vim.lsp.config.hls = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- Nix: nil_ls
    vim.lsp.config.nil_ls = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- R: r-language-server
    vim.lsp.config.r_language_server = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- TeX: texlab
    vim.lsp.config.texlab = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- Enable all LSP servers
    vim.lsp.enable({ 'pyright', 'ruff', 'clangd', 'hls', 'nil_ls', 'r_language_server', 'texlab' })

    -- Diagnostic configuration
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    -- Diagnostic signs
    local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "»" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
  end,
}
