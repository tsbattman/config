-- Solarized colorscheme
return {
  "craftzdog/solarized-osaka.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = false,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = false },
      functions = {},
      variables = {},
    },
  },
  config = function(_, opts)
    require("solarized-osaka").setup(opts)
    vim.cmd.colorscheme("solarized-osaka")
  end,
}
