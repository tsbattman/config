-- Fuzzy finder with fzf-lua
return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua",
  keys = {
    { "<leader>o", "<cmd>FzfLua files<cr>", desc = "Find files" },
    { "<leader>rg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
  },
  opts = {
    winopts = {
      height = 0.85,
      width = 0.85,
      preview = {
        default = "bat",
        layout = "vertical",
        vertical = "up:45%",
      },
    },
    files = {
      prompt = "Files> ",
      cmd = "fd --type f --hidden --follow --exclude .git",
    },
    grep = {
      prompt = "Grep> ",
      cmd = "rg --vimgrep",
    },
  },
}
