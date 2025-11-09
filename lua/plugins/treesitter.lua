return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate', -- The correct way to run the update command
    dependencies = {
        'windwp/nvim-ts-autotag',
    },
	config = function()
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

        -- Tell treesitter about the new 'vbscript' parser
        parser_config.vbscript = {
            install_info = {
                -- This is the community-made parser for VBA/VBScript
                url = "https://github.com/JJK96/tree-sitter-vbscript",
                files = {"src/parser.c"},
                branch = "master",
            },
            -- List of filetypes to automatically map to this parser
            filetype = { "vba", "vb", "vbs", "bas" },
        }
		require('nvim-treesitter.configs').setup ({
			-- A list of parser names, or "all" (the listed parsers MUST always be installed)
			ensure_installed = {
                "python", "javascript", 'css', 'typescript', 'html', "lua",
                "vim", "vimdoc", "query", "markdown", "markdown_inline", "latex",
                "vbscript",
            },

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,

			---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
			-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

			highlight = {
				enable = true,

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
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
}
