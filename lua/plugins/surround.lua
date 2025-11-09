return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to track main branch
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- optional custom settings:
      keymaps = {
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "S",
        delete = "ds",
        change = "cs",
      },
      -- You can add custom surrounds if you want:
      surrounds = {
        ["b"] = { add = { "**", "**" } }, -- bold in Markdown
        ["i"] = { add = { "__", "__" } },   -- initial
        ["q"] = { add = { "\"", "\"" } }, -- double quotes
      },
    })
  end,
}

