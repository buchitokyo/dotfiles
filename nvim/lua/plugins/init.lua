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
  ---@diagnostic disable: undefined-global
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
  ---@diagnostic enable: undefined-global

  -- bufferline (タブ/バッファライン)
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    opts = {
      options = {
        offsets = {
          {
            filetype = "neo-tree",
            text = "Explorer",
            text_align = "center",
            highlight = "Directory",
            separator = true,
          },
        },
        always_show_bufferline = true,
      },
    },
  },

  -- neo-tree (サイドバー型ファイルツリー)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<Leader>E", "<cmd>Neotree toggle<cr>", desc = "Toggle file tree" },
      { "<Leader>gE", "<cmd>Neotree toggle git_status<cr>", desc = "Git status tree" },
    },
    config = function()
      -- ディレクトリで開いたとき neo-tree を自動表示
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function(data)
          if vim.fn.isdirectory(data.file) == 1 then
            vim.cmd.cd(data.file)
            vim.schedule(function()
              require("neo-tree.command").execute({
                source = "filesystem",
                position = "left",
                toggle = false,
              })
              -- ディレクトリバッファを非表示・自動削除にする
              if vim.api.nvim_buf_is_valid(data.buf) then
                vim.bo[data.buf].buflisted = false
                vim.bo[data.buf].bufhidden = "wipe"
                vim.bo[data.buf].buftype = "nofile"
                vim.api.nvim_buf_set_lines(data.buf, 0, -1, false, {})
              end
            end)
          end
        end,
      })

      -- neo-tree が唯一のウィンドウになったらスクラッチバッファを右に作る
      vim.api.nvim_create_autocmd("WinClosed", {
        callback = function()
          vim.schedule(function()
            local wins = vim.tbl_filter(function(w)
              return vim.api.nvim_win_get_config(w).relative == ""
            end, vim.api.nvim_list_wins())
            if #wins == 1 and vim.bo[vim.api.nvim_win_get_buf(wins[1])].filetype == "neo-tree" then
              vim.cmd("botright vnew")
              vim.bo.buflisted = false
              vim.bo.buftype = "nofile"
              vim.bo.bufhidden = "wipe"
            end
          end)
        end,
      })

      require("neo-tree").setup({
        close_if_last_window = false,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        enable_normal_mode_for_inputs = false,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf", "neo-tree" },
        sort_case_insensitive = false,
        source_selector = {
          winbar = true,
          sources = {
            { source = "filesystem", display_name = "󱧷 Files" },
            { source = "buffers", display_name = "󰈚 Buffers" },
            { source = "git_status", display_name = " Git" },
          },
        },
        default_component_configs = {
          container = {
            enable_character_fade = true,
          },
          indent = {
            indent_size = 2,
            padding = 1,
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            with_expanders = nil,
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
            provider = function(icon, node)
              if node.type == "file" or node.type == "terminal" then
                local success, web_devicons = pcall(require, "nvim-web-devicons")
                local name = node.type == "terminal" and "terminal" or node.name
                if success then
                  local devicon, hl = web_devicons.get_icon(name)
                  icon.text = devicon or icon.text
                  icon.highlight = hl or icon.highlight
                end
              end
            end,
            default = "*",
            highlight = "NeoTreeFileIcon",
          },
          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              -- Change type
              added = "",
              modified = "",
              deleted = "✖",
              renamed = "󰁕",
              -- Status type
              untracked = "",
              ignored = "",
              unstaged = "󰄱",
              staged = "",
              conflict = "",
            },
          },
          file_size = {
            enabled = true,
            required_width = 64,
          },
          type = {
            enabled = true,
            required_width = 122,
          },
          last_modified = {
            enabled = true,
            required_width = 88,
          },
          created = {
            enabled = true,
            required_width = 110,
          },
          symlink_target = {
            enabled = false,
          },
        },
        commands = {},
        window = {
          position = "left",
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = {
              "toggle_node",
              nowait = false,
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "cancel",
            ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
            ["l"] = "focus_preview",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["w"] = "open_with_window_picker",
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            ["a"] = {
              "add",
              config = {
                show_path = "none",
              },
            },
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy",
            ["m"] = "move",
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
            ["i"] = "show_file_details",
          },
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_hidden = true,
            hide_by_name = {},
            hide_by_pattern = {},
            always_show = {},
            never_show = {},
            never_show_by_pattern = {},
          },
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
          group_empty_dirs = false,
          hijack_netrw_behavior = "open_default",
          use_libuv_file_watcher = true,
          window = {
            mappings = {
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["/"] = "fuzzy_finder",
              ["D"] = "fuzzy_finder_directory",
              ["#"] = "fuzzy_sorter",
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["[g"] = "prev_git_modified",
              ["]g"] = "next_git_modified",
              ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["og"] = { "order_by_git_status", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            },
            fuzzy_finder_mappings = {
              ["<down>"] = "move_cursor_down",
              ["<C-n>"] = "move_cursor_down",
              ["<up>"] = "move_cursor_up",
              ["<C-p>"] = "move_cursor_up",
            },
          },
          commands = {},
        },
        buffers = {
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
          group_empty_dirs = true,
          show_unloaded = true,
          window = {
            mappings = {
              ["bd"] = "buffer_delete",
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            },
          },
        },
        git_status = {
          window = {
            position = "float",
            mappings = {
              ["A"] = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
              ["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            },
          },
        },
      })
    end,
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
      open_for_directories = false,
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

  -- trouble.nvim (診断・LSP結果リスト)
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<Leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (project)" },
      { "<Leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (buffer)" },
      { "<Leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
      { "<Leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP" },
    },
  },

  -- diffview (git diff / マージ / ファイル履歴)
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<Leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git diff view" },
      { "<Leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File git history" },
      { "<Leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Project git history" },
    },
  },

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

  -- close-buffers (バッファ一括削除)
  {
    "kazhala/close-buffers.nvim",
    keys = {
      { "<Leader>bo", function() require("close_buffers").delete({ type = "other" }) end, desc = "Close other buffers" },
      { "<Leader>bh", function() require("close_buffers").delete({ type = "hidden", force = true }) end, desc = "Close hidden buffers" },
      { "<Leader>ba", function() require("close_buffers").delete({ type = "all", force = true }) end, desc = "Close all buffers" },
    },
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

      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          always_show_tabline = false,
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
            "branch",
            "diff",
            {
              "filename",
              file_status = true,
              newfile_status = true,
              path = 0,
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
          },
          lualine_x = {
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = {
                fg = "#ff9e64",
              },
            },
            "encoding",
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
            "progress",
          },
          lualine_z = {
            "location",
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
        tabline = {},
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

  -- vim-visual-multi (マルチカーソル)
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
    init = function()
      vim.g.VM_mouse_mappings = 1
    end,
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
