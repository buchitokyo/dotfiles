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

  -- yazi.nvim (file manager)
  {
    "mikavilpas/yazi.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "-", "<cmd>Yazi<cr>", desc = "Open yazi (current file)" },
      { "<Leader>e", "<cmd>Yazi cwd<cr>", desc = "File explorer (cwd)" },
    },
    opts = {
      open_for_directories = true,
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

  -- dropbar (winbar breadcrumbs)
  {
    "Bekaboo/dropbar.nvim",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "rmehri01/onenord.nvim",
      "lewis6991/gitsigns.nvim",
      "SmiteshP/nvim-navic",
    },
    config = function()
      local colors = require("onenord.colors").load()
      colors.mypink = colors.mypink or "#FFB2CC"
      local switch_color = {
        active = { fg = colors.active, bg = colors.mypink },
        inactive = { fg = colors.active, bg = colors.light_gray },
      }

      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = {
            "mode",
          },
          lualine_b = {
            {
              "filename",
              file_status = true,
              newfile_status = true,
              path = 1,
              shorting_target = 40,
              symbols = { modified = "_󰷥", readonly = " ", newfile = "󰄛", unnamed = "[No Name]" },
            },
          },
          lualine_c = {
            {
              "diagnostics",
              sources = {
                "nvim_diagnostic",
                "nvim_lsp",
              },
              sections = {
                "error",
                "warn",
                "info",
                "hint",
              },
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = " ",
              },
              update_in_insert = false,
              always_visible = false,
            },
            { "navic" },
          },
          lualine_x = {
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = {
                fg = "#ff9e64",
              },
            },
          },
          lualine_y = {
            {
              "filetype",
              colored = true,
              icon_only = false,
              color = {
                fg = colors.fg,
              },
            },
          },
          lualine_z = {
            {
              "fileformat",
              icons_enabled = true,
              symbols = {
                unix = "",
                dos = "",
                mac = "",
              },
              separator = {
                left = "",
                right = "",
              },
            },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {
          lualine_a = {
            {
              "buffers",
              show_filename_only = true,
              hide_filename_extension = false,
              show_modified_status = true,
              mode = 0,
              max_length = vim.o.columns * 2 / 3,
              filetype_names = {
                TelescopePrompt = "Telescope",
                dashboard = "Dashboard",
                packer = "Packer",
                fzf = "FZF",
                alpha = "Alpha",
              },
              use_mode_colors = false,
              buffers_color = switch_color,
              symbols = {
                modified = "_󰷥",
                alternate_file = " ",
                directory = " ",
              },
            },
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {
            {
              "diff",
              colored = true,
              symbols = {
                added = " ",
                modified = " ",
                removed = " ",
              },
              source = nil,
            },
          },
          lualine_y = {
            {
              "b:gitsigns_head",
              icon = {
                "",
                color = {
                  fg = colors.orange,
                },
              },
              color = {
                fg = colors.fg,
              },
            },
          },
          lualine_z = {
            { "tabs", tabs_color = switch_color },
          },
        },
        winbar = {},
        inactive_winbar = {},
        extensions = {},
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
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = false,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
      })
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = "#98c379" })
      vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = "#98c379" })
    end,
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
    event = { "BufReadPre" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = " ▎" },
          change = { text = " ▎" },
          delete = { text = " " },
          topdelete = { text = " " },
          changedelete = { text = "▎ " },
          untracked = { text = " ▎" },
        },
        signs_staged = {
          add = { text = " ▎" },
          change = { text = " ▎" },
          delete = { text = " " },
          topdelete = { text = " " },
          changedelete = { text = "▎ " },
          untracked = { text = " ▎" },
        },
        signs_staged_enable = false,
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          follow_files = true,
        },
        auto_attach = true,
        attach_to_untracked = false,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
          use_focus = true,
        },
        current_line_blame_formatter = "<summary> (<author_time:%Y/%m>) - <author>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          map("n", "]c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end)
          map("n", "[c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end)
          map("n", "<leader>hs", gitsigns.stage_hunk)
          map("n", "<leader>hr", gitsigns.reset_hunk)
          map("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
          map("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
          map("n", "<leader>hS", gitsigns.stage_buffer)
          map("n", "<leader>hu", gitsigns.undo_stage_hunk)
          map("n", "<leader>hR", gitsigns.reset_buffer)
          map("n", "<leader>hp", gitsigns.preview_hunk)
          map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end)
          map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
          map("n", "<leader>hd", gitsigns.diffthis)
          map("n", "<leader>hD", function() gitsigns.diffthis("~") end)
          map("n", "<leader>td", gitsigns.toggle_deleted)
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
      })
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

  -- muren (複数検索置換)
  {
    "AckslD/muren.nvim",
    cmd = { "MurenToggle", "MurenOpen", "MurenFresh", "MurenUnique" },
    keys = {
      { "<Leader>mut", "<cmd>MurenToggle<cr>", desc = "Muren toggle" },
      { "<Leader>muf", "<cmd>MurenFresh<cr>", desc = "Muren fresh" },
      { "<Leader>mu", "<cmd>MurenUnique<cr>", desc = "Muren unique" },
    },
    config = true,
  },

  -- todo-comments (TODO/FIXME/HACK 等のハイライト)
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- copilot.lua
  {
    "zbirenbaum/copilot.lua",
    event = "VimEnter",
    opts = {
      panel = { enabled = false },
      suggestion = { enabled = false },
    },
  },

  -- copilot-cmp
  {
    "zbirenbaum/copilot-cmp",
    event = "VimEnter",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "zbirenbaum/copilot.lua",
    },
    config = function()
      require("copilot_cmp").setup()
    end,
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
