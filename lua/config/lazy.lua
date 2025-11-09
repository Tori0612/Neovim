-- Set rtp (runtime path)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set up lazy.nvim with your plugins
require("lazy").setup({
	-- Packer can manage itself
	'wbthomason/packer.nvim',
	'neovim/nvim-lspconfig',
	'nvim-telescope/telescope.nvim',
	'nvim-lua/plenary.nvim',

	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',

	{
		'williamboman/mason.nvim',
		config = function()
			require('mason').setup()
		end

	},
	{

		'sainnhe/gruvbox-material',
		name = "gruvbox-material",
		config = function()
			vim.cmd.colorscheme('gruvbox-material'),
			vim.g.gruvbox_material_background = 'hard',
			vim.g.gruvbox_material_foreground = 'original',
			vim.g.gruvbox_material_enable_italic = 1
		end
	},

	'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'}),
}, {})
