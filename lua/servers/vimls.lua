---@brief
---
--- https://github.com/iamcco/vim-language-server
---
--- You can install vim-language-server via npm:
--- ```sh
--- npm install -g vim-language-server
--- ```

-- local cmd = require("helpers.lsp")
local capabilities = require("lsp.capabilities").get_capabilities()
local cmd = require('lsp.cmd')

-- │ @VIMLS_CONFIG │
---@type vim.lsp.Config
return {
  cmd = { cmd.get_cmd("vim_ls", 'vim-language-server'), '--stdio' },
  capabilities = capabilities,
  filetypes = { 'vim' },
  root_markers = { '.git' },
  init_options = {
    isNeovim = true,
    iskeyword = '@,48-57,_,192-255,-#',
    vimruntime = vim.env.VIMRUNTIME,
    runtimepath = vim.o.runtimepath,
    diagnostic = { enable = true },
    indexes = {
      runtimepath = true,
      gap = 100,
      count = 3,
      projectRootPatterns = { 'runtime', 'nvim', '.git', 'autoload', 'plugin', 'after', 'ftplugin' },
    },
    suggest = { fromVimruntime = true, fromRuntimepath = true },
  },
}
