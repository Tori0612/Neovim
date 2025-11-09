-- lua/plugins/colorscheme.lua

return {
    "scottmckendry/cyberdream.nvim",
    lazy = false,        -- load immediately
    priority = 1000,     -- load before other plugins
    config = function()
        require("cyberdream").setup({
            -- 🌙 Optional customization
            transparent = false,  -- Set true if you use a transparent terminal
            italic_comments = true,
            hide_fillchars = false,
            borderless_telescope = true,
            terminal_colors = true,
            colors = {
                bg = "#060206",
            },

            -- You can tweak palette overrides if desired
            theme = {
                variant = "dark", -- other option: "light"
            },
        })

        -- Apply the colorscheme
        vim.cmd("colorscheme cyberdream")
    end,
}


-- lua/plugins/oxocarbon.lua
--[[
return {
    {
        'nyoom-engineering/oxocarbon.nvim',
        lazy = false,    -- Make sure the colorscheme is loaded on startup
        priority = 1000, -- Load it before other plugins
        config = function()
            -- Set the background to dark
            -- (You can also set it to "light" if you prefer the light variant)
            vim.o.background = "dark"

            -- Load the colorscheme
            vim.cmd.colorscheme 'oxocarbon'
            local darker_bg = '#030303'
            vim.api.nvim_set_hl(0, 'Normal', { bg = darker_bg })
            vim.api.nvim_set_hl(0, 'NormalFloat', { bg = darker_bg })
        end,
    },
} 
]]--
--[[
return {
    {
        "EdenEast/nightfox.nvim",
        lazy = false,      -- load immediately
        priority = 1000,   -- make sure it loads before everything else
        config = function()
            require("nightfox").setup({
                options = {
                    styles = {
                        comments = "italic",
                        keywords = "italic",
                        functions = "NONE",
                        variables = "NONE",
                    },
                },
            })
            vim.cmd("colorscheme carbonfox")
        end,
    },
}
]]--

--[[
return {
    {
        "jacoborus/tender.vim",
        lazy = false,
        priority = 1000,
        config = function()
            -- enable true color support
            vim.o.termguicolors = true

            -- optionally set background mode, if you want “dark” explicitly
            vim.o.background = "dark"

            -- activate the theme
            vim.cmd("colorscheme tender")

            -- override highlights to make background transparent, italics, etc.
            local hl = vim.api.nvim_set_hl

            -- Make Normal background transparent
            hl(0, "Normal", { bg = "none" })
            hl(0, "NormalFloat", { bg = "none" })
            hl(0, "SignColumn", { bg = "none" })
            hl(0, "VertSplit", { bg = "none" })

            -- Italics for comments, maybe keywords
            hl(0, "Comment", { italic = true })
            hl(0, "Keyword", { italic = true })

            -- optionally more overrides as needed
            -- e.g. function names, strings, etc.
            hl(0, "Function", { italic = true })
            -- hl(0, "String", { italic = false, bg = "none" })

            -- If using LSP / Treesitter, you might override those as well
            hl(0, "@comment", { italic = true })
            hl(0, "@keyword", { italic = true })
            hl(0, "CursorLineNr", { fg = "#f4bf75", bold = true })
        end,
    },
}
]]--
--[[
return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        style = 'night',
        transparent = true,
        terminal_colors = true,
        styles = {
            comments = { italic = true },
            keywords = { italic = true },
            functions = {},
            variables = {},
        },
    },
    config = function(_, opts)
        require('tokyonight').setup(opts)
        vim.cmd[[colorscheme tokyonight]]
  --end,
--} ]]--

--[[return {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
        require('rose-pine').setup({
            variant = "moon",
            dark_variant = "moon",
            dim_interactive_windows = false,
            extend_background_behind_borders = false,

            enable = {
                terminal = true,
                legacy_highlights = true,
                migrations = true
            },

            styles = {
                bold = true,
                italic = true,
                transparency = true,
            },
        })
        vim.cmd("colorscheme rose-pine")
    end
} ]]--

--[[
return {
  {
    'rebelot/kanagawa.nvim',
    name = 'kanagawa',
    priority = 1000,  -- Load early for colorschemes
    config = function()
      require('kanagawa').setup({
        compile = true,              -- Enable compilation for faster loading
        undercurl = true,            -- Enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,         -- Keep solid background for main buffer
        dimInactive = false,         -- Dim inactive windows
        terminalColors = true,       -- Define vim.g.terminal_color_*
        colors = {
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors)
          local theme = colors.theme
          return {
            NormalFloat = { bg = theme.ui.bg_p2, fg = theme.ui.fg, bg_alpha = 0.99 }, -- Semi-opaque background for floats
            FloatBorder = { bg = theme.ui.bg_p2, fg = theme.ui.fg_dim }, -- Match border to float
            FloatTitle = { bg = theme.ui.bg_p2, fg = theme.ui.fg }, -- Match title
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 }, -- For darker windows
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim }, -- Lazy.nvim UI
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim }, -- Mason UI
          }
        end,
        theme = "dragon",            -- Default theme
        background = {
          dark = "dragon",           -- Dark mode
          light = "lotus",           -- Light mode
        },
      })
      vim.cmd.colorscheme("kanagawa")  -- Apply the colorscheme
    end,
  },
}
]]--

--[[ return {
  -- Remove 'wbthomason/packer.nvim' - you don't need it, you're using lazy.nvim!

  -- Color Scheme
  {
    'sainnhe/gruvbox-material',
    name = "gruvbox-material",
    lazy = false, -- Load immediately since it's a color scheme
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('gruvbox-material')
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_foreground = 'original'
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_transparent_background = 1
    end
  },

  -- Essential dependencies
  'nvim-lua/plenary.nvim',
}
]]--
