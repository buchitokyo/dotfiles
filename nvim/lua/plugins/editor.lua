return {
  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- Comment
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n",          desc = "Comment line" },
      { "gc",  mode = { "n", "v" }, desc = "Comment" },
    },
    config = true,
  },

  -- comment-box (コメントボックス)
  {
    "LudoPinelli/comment-box.nvim",
    keys = {
      { "<Leader>cb", "<cmd>CBccbox<cr>",  mode = { "n", "v" }, desc = "Comment box" },
      { "<Leader>cl", "<cmd>CBccline<cr>", mode = { "n", "v" }, desc = "Comment line" },
    },
  },

  -- accelerated-jk (j/k 加速移動)
  {
    "rainbowhxch/accelerated-jk.nvim",
    keys = {
      { "j", "<Plug>(accelerated_jk_gj)", desc = "Accelerated j" },
      { "k", "<Plug>(accelerated_jk_gk)", desc = "Accelerated k" },
    },
  },

  -- vim-visual-multi (マルチカーソル)
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
    init = function()
      vim.g.VM_mouse_mappings = 1
    end,
  },

  -- muren (複数検索置換)
  {
    "AckslD/muren.nvim",
    cmd = { "MurenToggle", "MurenOpen", "MurenFresh", "MurenUnique" },
    keys = {
      { "<Leader>mut", "<cmd>MurenToggle<cr>", desc = "Muren toggle" },
      { "<Leader>muf", "<cmd>MurenFresh<cr>",  desc = "Muren fresh" },
      { "<Leader>mu",  "<cmd>MurenUnique<cr>", desc = "Muren unique" },
    },
    config = true,
  },

  -- scope (タブごとにバッファを分離)
  {
    "tiagovla/scope.nvim",
    event = "VeryLazy",
    config = true,
  },

  -- close-buffers (バッファ一括削除)
  {
    "kazhala/close-buffers.nvim",
    keys = {
      { "<Leader>bo", function() require("close_buffers").delete({ type = "other" }) end,                desc = "Close other buffers" },
      { "<Leader>bh", function() require("close_buffers").delete({ type = "hidden", force = true }) end, desc = "Close hidden buffers" },
      { "<Leader>ba", function() require("close_buffers").delete({ type = "all", force = true }) end,    desc = "Close all buffers" },
    },
    opts = {},
  },
}
