-- @p lua/custom/secret_env.lua

local M = {}

function M.apply_conceal()
  if vim.bo.filetype ~= "env" then return end

  vim.opt_local.conceallevel = 2
  vim.opt_local.concealcursor = "nc"

  -- local regex = [[\v(\=\zs.|\ze.\@<=\zs.)]]
  -- local regex = [[\v\=.*%(\zs.)]]
  local regex =[[\v\=\zs.+$|(\=\zs.+a)@<=\zs.]]
  -- local regex = [[\v[^=]\@<=\=.* \zs.]]

  local cmd = vim.cmd("syntax match EnvSecret /" .. regex .. "/ conceal cchar=* containedin=ALL")
  vim.schedule(function()
    if vim.api.nvim_buf_is_valid(0) then
      vim.cmd(cmd)
    end
  end)
end

function M.setup()
  local group = vim.api.nvim_create_augroup("SecretEnv", { clear = true })

  vim.api.nvim_create_autocmd({ 'FileType', "BufEnter" }, {
    group = group,
    pattern = "env",
    callback = function ()
      M.apply_conceal()
    end
  })
end

return M
