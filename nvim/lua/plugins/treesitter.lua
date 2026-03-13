-- Treesitter configuration
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.treesitter.language.register("markdown", "mdx")

      -- パーサー自動インストール
      local ensure_installed = {
        "typescript", "tsx", "javascript", "python", "lua",
        "vim", "vimdoc", "html", "css", "json", "yaml",
        "markdown", "markdown_inline", "bash", "dockerfile",
        "terraform", "hcl",
      }

      local installed = require("nvim-treesitter").get_installed()
      local to_install = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, ensure_installed)

      if #to_install > 0 then
        require("nvim-treesitter").install(to_install)
      end

      -- ハイライト + インデント有効化
      local in_container = vim.fn.filereadable("/.dockerenv") == 1
        or os.getenv("REMOTE_CONTAINERS") ~= nil
        or os.getenv("container") ~= nil
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          if in_container then
            -- Docker: パーサーだけ読み込む（hlchunk用）、ハイライトはvim syntaxに任せる
            pcall(vim.treesitter.get_parser)
          else
            pcall(vim.treesitter.start)
          end
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      -- Folding
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt.foldenable = false
    end,
  },
}
