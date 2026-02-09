-- avante.nvim: AI-powered code assistant (Cursor-like experience in Neovim)
return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      provider = "claude",
    },
    keys = {
      { "<Leader>aa", "<cmd>AvanteToggle<cr>", desc = "Toggle Avante" },
    },
  },
}
