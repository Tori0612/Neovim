-- @p lua/globals/autocmds.lua
local map = require('utils.map')

vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    map.n("l", "<CR>", { buffer = true, remap = true, desc = "Go One Directory Below (netrw)" })
    map.n("h", "-", { buffer = true, remap = true, desc = "Go One Directory Above (netrw)" })
    map.n('<leader>sc', function()
      vim.g.netrw_list_cmd = "ls -lah --group-directories-first --sort=time --time=birth -r"
      vim.cmd('Lexplore')
    end, {
      buffer = true,
      desc = 'Sort by creation time'
    })

    map.n("<leader>sn", function()
      vim.g.netrw_sort_sequence =
        "[\\/]$,*,\\(\\.bak\\|\\~\\|\\.o\\|\\.h\\|\\.info\\|\\.swp\\|\\.obj\\)[*@]\\=$"

      vim.g.netrw_list_cmd =
        "ls -Fa"

      vim.cmd("Lexplore")
    end, {
      buffer = true,
      desc = "Restore normal netrw sorting",
    })
  end,
})

vim.api.nvim_create_user_command("PackSync", function()
  vim.pack.sync()
end, {})

vim.api.nvim_create_user_command("PackUpdate", function()
  vim.pack.update()
end, {})
