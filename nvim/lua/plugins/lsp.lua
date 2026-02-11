-- LSP configuration (Neovim 0.11+ native API)
return {
  -- Mason: LSP server installer
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- Mason-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "basedpyright",
          "lua_ls",
          "terraformls",
        },
        automatic_installation = true,
      })
    end,
  },

  -- nvim-cmp for capabilities
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true,
  },

  -- LSP setup using Neovim 0.11 native API
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- LSP keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<Leader>fm", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, opts)
        end,
      })

      -- Configure servers using vim.lsp.config (Neovim 0.11+)
      vim.lsp.config("basedpyright", {
        capabilities = capabilities,
      })

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      })

      -- Disable ts_ls (using typescript-tools.nvim instead)
      vim.lsp.enable("ts_ls", false)

      -- Disable pyright (using basedpyright instead)
      vim.lsp.enable("pyright", false)

      -- Terraform
      vim.lsp.config("terraformls", {
        capabilities = capabilities,
      })

      -- Enable servers
      vim.lsp.enable({ "basedpyright", "lua_ls", "terraformls" })

      -- Diagnostics
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      })
    end,
  },

  -- TypeScript (typescript-tools.nvim - faster than ts_ls)
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      require("typescript-tools").setup({
        capabilities = cmp_nvim_lsp.default_capabilities(),
        settings = {
          tsserver_max_memory = 4096,
        },
      })
    end,
  },
}

