return {
  -- File icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- dropbar (winbar breadcrumbs)
  {
    "Bekaboo/dropbar.nvim",
    enabled = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      bar = {
        enable = function(buf, win, _)
          if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_win_is_valid(win) then
            return false
          end
          local ft = vim.bo[buf].filetype
          if ft == "neo-tree" or ft == "neo-tree-popup" then
            return false
          end
          return vim.fn.win_gettype(win) == ""
        end,
      },
    },
  },

  -- nvim-navic (LSP breadcrumbs)
  {
    "SmiteshP/nvim-navic",
    event = { "BufNewFile", "BufReadPre" },
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      lsp = { auto_attach = true },
      highlight = true,
      depth_limit = 9,
    },
  },

  -- scrollbar (スクロールバー + 診断表示)
  {
    "petertriho/nvim-scrollbar",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- which-key (keybinding help)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps",
      },
    },
  },

  -- nvim-hlslens (検索ハイライト強化)
  {
    "kevinhwang91/nvim-hlslens",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<Leader>L" },
    },
    config = function()
      require("hlslens").setup({
        calm_down = true,
        nearest_only = true,
      })
      vim.keymap.set({ "n", "x" }, "<Leader>L", function()
        vim.schedule(function()
          if require("hlslens").exportLastSearchToQuickfix() then
            vim.cmd("cw")
          end
        end)
        return ":noh<CR>"
      end, { expr = true })
    end,
  },

  -- treesitter-context (関数/クラスのコンテキスト表示)
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      max_lines = 3,
    },
  },

  -- tiny-inline-diagnostic (インライン診断表示)
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
      require("tiny-inline-diagnostic").setup()
      vim.diagnostic.config({ virtual_text = false })
    end,
  },

  -- todo-comments (TODO/FIXME/HACK 等のハイライト)
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- vim-doge (ドキュメント生成)
  {
    "kkoomen/vim-doge",
    build = ":call doge#install()",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.g.doge_enable_mappings = 1
      vim.g.doge_doc_standard_python = "google"
    end,
  },

  -- namu (シンボルナビゲーション)
  {
    "bassamsdata/namu.nvim",
    keys = {
      { "<Leader>ns", "<cmd>Namu symbols<cr>", desc = "Namu symbols" },
    },
    opts = {},
  },
}
