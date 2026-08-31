-- @p lua/custom/surround.lua

local map = require('utils.map')

local default_pairs = {
  ["'"] = { "'", "'" },
  ['"'] = { '"', '"' },
  ['('] = { '(', ')' },
  ['['] = { '[', ']' },
  ['{'] = { '{', '}' },
  ['<'] = { '<', '>' }
}

local function get_pair(char)
  if vim.b.custom_surround_pairs and vim.b.custom_surround_pairs[char] then
    return vim.b.custom_surround_pairs[char]
  end

  return default_pairs[char]
end

-- test
map.v('s', function()
  vim.api.nvim_echo({{ 'Surround With: ', "WarningMsg" }}, false, {})
  local char = vim.fn.getcharstr()
  vim.api.nvim_command('redraw')

  local pair = get_pair(char)
  if not pair then
    print('Invalid surround character')
    return
  end

  local cmd = string.format('c%s<C-r>"%s<Right><Esc>', pair[1], pair[2])
  local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end, { noremap = true, desc = "Prompt for surround character" })

map.n('sr', function()
  vim.api.nvim_echo({{ 'Replace What? ', "WarningMsg" }}, false, {})
  local old_char = vim.fn.getcharstr()
  vim.api.nvim_command('redraw')

  vim.api.nvim_echo({{ 'Replace With? ', "WarningMsg" }}, false, {})
  local new_char = vim.fn.getcharstr()
  vim.api.nvim_command('redraw')

  local new_pair = get_pair(new_char)
  if not new_pair then
    print('Invalid surround character')
    return
  end

  -- cascach "aaa"
  local cmd = string.format('di%s"_x"_s%s<C-r>"%s<Esc>', old_char, new_pair[1], new_pair[2])
  local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end, { desc = 'Replace surround character' })

map.n('ys', function()
  vim.o.operatorfunc = "v:lua.SurroundOperator"
  return "g@"
end, { expr = true, desc = "Surround with Motion" })

function _G.SurroundOperator()
  vim.api.nvim_echo({{ 'Surround With: ', "WarningMsg" }}, false, {})
  local char = vim.fn.getcharstr()
  vim.api.nvim_command('redraw')

  local pair = get_pair(char)
  if not pair then
    print('Invalid surround character')
    return
  end

  local cmd = string.format("`[v`]c%s<C-r>\"%s<Esc>", pair[1], pair[2])
  local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.conceallevel = 2
        vim.opt_local.concealcursor = "nc"

        vim.b.custom_surround_pairs = {
            ["b"] = { "**", "**" },
            ["i"] = { "_", "_" },
            ["l"] = { "$", "$" },
            ["c"] = { "`", "`" },
            ["n"] = { "**_", "_**" }
        }
    end
})
