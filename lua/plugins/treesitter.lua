return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'windwp/nvim-ts-autotag',
    },
    config = function()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

      parser_config.vbscript = {
        install_info = {
          url = "https://github.com/JJK96/tree-sitter-vbscript",
          files = {"src/parser.c"},
          branch = "master",
        },
        filetype = { "vba", "vb", "vbs", "bas" },
      }
      require('nvim-treesitter.configs').setup ({
        ensure_installed = {
          "c", "cpp", "bash",
          "python", "javascript", "css", "typescript", "html", "lua",
          "vim", "vimdoc", "markdown", "markdown_inline", "latex",
          "java", "json", "julia"
        },

        modules = {},
        ignore_install = {},

        sync_install = false,

        auto_install = true,

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        fold = { enable = true },
        indent = {
          enable = true,
        },
      })

      local ok_autotag, autotag = pcall(require, 'nvim-ts-autotag')
      if ok_autotag then
        autotag.setup()
      else
        vim.notify("nvim-ts-autotag not found", vim.log.levels.WARN)
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require'treesitter-context'.setup{
        enable = true, -- Enable this plugin
        max_lines = 3, -- How many lines of context to show
      }
    end,
  }
}
