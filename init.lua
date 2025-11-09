-- Standard lazy.nvim bootstrap code (keep this as is)
vim.g.python3_host_prog = "C:\\Users\\crist\\OneDrive\\Documentos\\GitHub\\AnalysisLearningPY\\.venv\\Scripts\\python.exe"
vim.opt.shada = "!,'100,<50,s10,h"
vim.g.mapleader = " "
vim.g.vimtex_view_sumatrapdf_check_for_update = 1  -- Auto-check for PDF updates
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

-- Load ALL files in the lua/plugins directory automatically
require("lazy").setup("plugins", {})

require('config.settings')

-- Manually load your configuration files
require("config.keymaps")
-- Any general editor options can go in a new file, e.g., require("config.options")
-- 
