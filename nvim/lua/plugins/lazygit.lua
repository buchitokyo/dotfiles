-- lazygit.nvim: Git UI in Neovim
return {
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<Leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
    },
  },
}
