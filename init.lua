vim.g.python3_host_prog = vim.fn.expand("~/.neovim-venv/bin/python")
vim.opt.shada = "!,'100,<50,s10,h"
vim.g.mapleader = " "
vim.g.vimtex_view_sumatrapdf_check_for_update = 1
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {})
require('config.settings')
require("config.keymaps")
