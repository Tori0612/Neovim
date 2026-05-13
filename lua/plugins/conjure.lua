-- @p lua/plugins/conjure.lua
local gh = require("utils.github").gh

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "clojure", "fennel", "scheme", "lisp" },
  once = true,
  callback = function()
    vim.pack.add({ { src = gh("Olical/conjure") } })
  end
})

