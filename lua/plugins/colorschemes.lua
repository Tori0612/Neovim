return {
  {
    "Zeioth/neon.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      dim_inactive = false,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { bold = true },
      },
      transparent = true,
    },
    config = function(_, opts)
      require("neon").setup(opts)
      vim.cmd.colorscheme("neon-punkpeach-night")
    end,
  },
}
