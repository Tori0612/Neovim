return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "gruvbox", -- let lualine pick tender colors
      },
      sections = {
        lualine_a = {
          {
            "mode",
            color = function()
              -- different colors per mode
              local mode_color = {
                n = { fg = "#282828", bg = "#a3be8c" }, -- normal
                i = { fg = "#282828", bg = "#88c0d0" }, -- insert
                v = { fg = "#282828", bg = "#d08770" }, -- visual
                R = { fg = "#282828", bg = "#bf616a" }, -- replace
              }
              local mode = vim.fn.mode()
              return mode_color[mode] or { fg = "#282828", bg = "#b48ead" }
            end,
            padding = { left = 1, right = 1 },
          },
        },
      },
    },
  },
}
