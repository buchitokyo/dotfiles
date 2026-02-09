-- Plugin definitions for lazy.nvim
return {
  -- Colorscheme
  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme onedark]])
    end,
  },

  -- LSP
  { import = "plugins.lsp" },

  -- Completion
  { import = "plugins.cmp" },

  -- Treesitter
  { import = "plugins.treesitter" },

  -- Snacks (fuzzy picker)
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 900,
    keys = {
      -- f系（従来のTelescope互換）
      { "<Leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
      { "<Leader>fg", function() Snacks.picker.grep() end, desc = "Live grep" },
      { "<Leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<Leader>fw", function() Snacks.picker.grep_word() end, desc = "Grep word", mode = { "n", "v" } },
      { "<Leader>fh", function() Snacks.picker.help() end, desc = "Help tags" },
      { "<Leader>fr", function() Snacks.picker.lsp_references() end, desc = "LSP references" },
      { "<Leader>fs", function() Snacks.picker.lsp_symbols() end, desc = "Document symbols" },
      -- s系（Snacks Picker拡張）
      { "<Leader><Leader>", function() Snacks.picker.smart() end, desc = "Smart picker" },
      { "<Leader>sf", function() Snacks.picker.files() end, desc = "Find files" },
      { "<Leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<Leader>sw", function() Snacks.picker.grep_word() end, desc = "Grep cursor word" },
      { "<Leader>sb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<Leader>sr", function() Snacks.picker.recent() end, desc = "Recent files" },
      { "<Leader>sc", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<Leader>sh", function() Snacks.picker.help() end, desc = "Help" },
      { "<Leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<Leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<Leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP symbols" },
      { "<Leader>sR", function() Snacks.picker.resume() end, desc = "Resume last picker" },
    },
    opts = {
      picker = {
        enabled = true,
      },
      indent = {
        enabled = false,
      },
    },
  },

  -- oil.nvim (file explorer)
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
      { "<Leader>e", "<cmd>Oil<cr>", desc = "File explorer" },
    },
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "onedark",
        },
      })
    end,
  },

  -- File icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

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
      { "gcc", mode = "n", desc = "Comment line" },
      { "gc", mode = { "n", "v" }, desc = "Comment" },
    },
    config = true,
  },

  -- AI assistant (Avante)
  { import = "plugins.avante" },

  -- indent-blankline (indent guide)
--   {
--     "lukas-reineke/indent-blankline.nvim",
--     main = "ibl",
--     event = { "BufReadPre", "BufNewFile" },
--     opts = {
--       indent = { char = "│" },
--       scope = { enabled = true, show_start = true, show_end = false },
--       exclude = { filetypes = { "help", "dashboard", "lazy", "mason", "oil" } },
--     },
--   },

  -- hlchunk (chunk highlight)
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          style = {
            { fg = "#61afef" },
            { fg = "#e06c75" },
          },
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = ">",
          },
          textobject = "ic",
          duration = 150,
          delay = 200,
        },
        indent = {
          enable = true,
          chars = { "│", "¦", "┆", "┊" },
          style = {
            { fg = "#3b4048" },
          },
        },
        line_num = {
          enable = true,
          style = "#61afef",
          use_treesitter = true,
        },
        blank = {
          enable = true,
          chars = { "·" },
          style = {
            { fg = "#5c6370" },
          },
        },
      })
    end,
  },

  -- noice (UI enhancement)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
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

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })
    end,
  },

  -- dropbar (breadcrumbs)
  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<Leader>wp", function() require("dropbar.api").pick() end, desc = "Winbar pick" },
    },
    opts = {
      bar = {
        sources = function(buf, _)
          local sources = require("dropbar.sources")
          local utils = require("dropbar.utils")
          if vim.bo[buf].ft == "markdown" then
            return { sources.path, sources.markdown }
          end
          if vim.bo[buf].buftype == "terminal" then
            return { sources.terminal }
          end
          return {
            sources.path,
            utils.source.fallback({
              sources.lsp,
              sources.treesitter,
            }),
          }
        end,
      },
      icons = {
        ui = {
          bar = {
            separator = "  ",
            extends = "…",
          },
          menu = {
            separator = " ",
            indicator = " ",
          },
        },
        kinds = {
          symbols = {
            File = "󰈙 ",
            Module = "󰏗 ",
            Namespace = "󰅩 ",
            Package = "󰏗 ",
            Class = "󰠱 ",
            Method = "󰊕 ",
            Property = "󰜢 ",
            Field = "󰜢 ",
            Constructor = " ",
            Enum = " ",
            Interface = " ",
            Function = "󰊕 ",
            Variable = "󰀫 ",
            Constant = "󰏿 ",
            String = "󰀬 ",
            Number = "󰎠 ",
            Boolean = " ",
            Array = "󰅪 ",
            Object = "󰅩 ",
            Key = "󰌋 ",
            Null = "󰟢 ",
            EnumMember = " ",
            Struct = "󰙅 ",
            Event = " ",
            Operator = "󰆕 ",
            TypeParameter = "󰊄 ",
          },
        },
      },
    },
    config = function(_, opts)
      require("dropbar").setup(opts)

      -- onedark に合わせたハイライト設定
      local colors = {
        blue = "#61afef",
        green = "#98c379",
        yellow = "#e5c07b",
        orange = "#d19a66",
        purple = "#c678dd",
        cyan = "#56b6c2",
        red = "#e06c75",
        fg = "#abb2bf",
        bg_dark = "#21252b",
      }

      -- Winbar 背景
      vim.api.nvim_set_hl(0, "WinBar", { fg = colors.fg, bg = "NONE" })
      vim.api.nvim_set_hl(0, "WinBarNC", { fg = "#5c6370", bg = "NONE" })

      -- セパレータ
      vim.api.nvim_set_hl(0, "DropBarIconUISeparator", { fg = "#5c6370" })

      -- シンボル種別ごとの色
      vim.api.nvim_set_hl(0, "DropBarIconKindFile", { fg = colors.fg })
      vim.api.nvim_set_hl(0, "DropBarIconKindFolder", { fg = colors.yellow })
      vim.api.nvim_set_hl(0, "DropBarIconKindFunction", { fg = colors.blue })
      vim.api.nvim_set_hl(0, "DropBarIconKindMethod", { fg = colors.blue })
      vim.api.nvim_set_hl(0, "DropBarIconKindConstructor", { fg = colors.blue })
      vim.api.nvim_set_hl(0, "DropBarIconKindClass", { fg = colors.yellow })
      vim.api.nvim_set_hl(0, "DropBarIconKindInterface", { fg = colors.cyan })
      vim.api.nvim_set_hl(0, "DropBarIconKindStruct", { fg = colors.yellow })
      vim.api.nvim_set_hl(0, "DropBarIconKindModule", { fg = colors.orange })
      vim.api.nvim_set_hl(0, "DropBarIconKindNamespace", { fg = colors.orange })
      vim.api.nvim_set_hl(0, "DropBarIconKindPackage", { fg = colors.orange })
      vim.api.nvim_set_hl(0, "DropBarIconKindProperty", { fg = colors.green })
      vim.api.nvim_set_hl(0, "DropBarIconKindField", { fg = colors.green })
      vim.api.nvim_set_hl(0, "DropBarIconKindEnum", { fg = colors.purple })
      vim.api.nvim_set_hl(0, "DropBarIconKindEnumMember", { fg = colors.purple })
      vim.api.nvim_set_hl(0, "DropBarIconKindVariable", { fg = colors.red })
      vim.api.nvim_set_hl(0, "DropBarIconKindConstant", { fg = colors.orange })
      vim.api.nvim_set_hl(0, "DropBarIconKindString", { fg = colors.green })
      vim.api.nvim_set_hl(0, "DropBarIconKindEvent", { fg = colors.purple })
      vim.api.nvim_set_hl(0, "DropBarIconKindOperator", { fg = colors.cyan })
      vim.api.nvim_set_hl(0, "DropBarIconKindTypeParameter", { fg = colors.cyan })

      -- ドロップダウンメニューのスタイル
      vim.api.nvim_set_hl(0, "DropBarMenuHoverEntry", { bg = "#2c313a" })
      vim.api.nvim_set_hl(0, "DropBarMenuCurrentContext", { fg = colors.blue, bold = true })
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

  -- scrollbar (スクロールバー + 診断表示)
  {
    "petertriho/nvim-scrollbar",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- accelerated-jk (j/k 加速移動)
  {
    "rainbowhxch/accelerated-jk.nvim",
    keys = {
      { "j", "<Plug>(accelerated_jk_gj)", desc = "Accelerated j" },
      { "k", "<Plug>(accelerated_jk_gk)", desc = "Accelerated k" },
    },
  },

  -- comment-box (コメントボックス)
  {
    "LudoPinelli/comment-box.nvim",
    keys = {
      { "<Leader>cb", "<cmd>CBccbox<cr>", mode = { "n", "v" }, desc = "Comment box" },
      { "<Leader>cl", "<cmd>CBccline<cr>", mode = { "n", "v" }, desc = "Comment line" },
    },
  },

  -- namu (シンボルナビゲーション)
  {
    "bassamsdata/namu.nvim",
    keys = {
      { "<Leader>ns", "<cmd>Namu symbols<cr>", desc = "Namu symbols" },
    },
    opts = {},
  },

  -- scope (タブごとにバッファを分離)
  {
    "tiagovla/scope.nvim",
    event = "VeryLazy",
    config = true,
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
}
