-- Formatting with conform.nvim
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      python = { "ruff_format" },
      nix = { "nixfmt" },
    },
    format_on_save = function(bufnr)
      -- Auto-format on save for Python, Nix, TOML
      local ft = vim.bo[bufnr].filetype
      if ft == "python" or ft == "nix" or ft == "toml" then
        return { timeout_ms = 500, lsp_fallback = true }
      end
      return nil
    end,
    formatters = {
      ruff_format = {
        command = "ruff",
        args = { "format", "--stdin-filename", "$FILENAME", "-" },
      },
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)

    -- Manual format keymap
    vim.keymap.set({ "n", "v" }, "<leader>f", function()
      require("conform").format({ lsp_fallback = true })
    end, { desc = "Format buffer" })
  end,
}
