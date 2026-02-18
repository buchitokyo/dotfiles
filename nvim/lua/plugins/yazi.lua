return {
  "mikavilpas/yazi.nvim",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "-",         "<cmd>Yazi<cr>",     desc = "Open yazi (current file)" },
    { "<Leader>e", "<cmd>Yazi cwd<cr>", desc = "File explorer (cwd)" },
  },
  opts = {
    open_for_directories = false,
  },
}
