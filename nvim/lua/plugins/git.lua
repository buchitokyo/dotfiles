return {
  -- diffview (git diff / マージ / ファイル履歴)
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<Leader>gd", "<cmd>DiffviewOpen<cr>",          desc = "Git diff view" },
      { "<Leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File git history" },
      { "<Leader>gH", "<cmd>DiffviewFileHistory<cr>",   desc = "Project git history" },
    },
  },

  -- trouble.nvim (診断・LSP結果リスト)
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<Leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (project)" },
      { "<Leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Diagnostics (buffer)" },
      { "<Leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols" },
      { "<Leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP" },
    },
  },
}
