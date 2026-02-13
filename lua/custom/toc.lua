-- @p lua/custom/toc.lua
-- ╭──────────────────────────────────────────────────────────╮
-- │                           TOC                            │
-- ╰──────────────────────────────────────────────────────────╯
-- This "native plugin" was intended to organize the configs on a more readable way
-- but it can be quite useful for organizing your own code, it looks better when you have
-- @p lua/globals/highlights.lua enabled, and its color changes with colorschemes (if you use @p bin/nvim_themes ).
-- Its one that i enjoyed doing a lot, cuz it was not really inspired by anything, came out of my head,
-- but is worth noting that i just discovered this foldable marking (apparently exists since the old days of vim) 
-- from a dude's config, you can check on (@l https://github.com/Rishabh672003/Neovim/tree/main ) my config dont 
-- even get close to his. Also, you can either use the keymap, that calls a Location List, or use it with 
-- @l mini.pick .

-- @t [ Collecting Contents ]
local function collect_toc()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local items = {}

  local patterns = {
      "%-%-%s*{(.-){{{",      -- -- { Title {{{
      "%-%-%s*@t%s*%[(.-)%]", -- -- @t [ Title ]

  }
  for i, line in ipairs(lines) do
    for _, pat in ipairs(patterns) do
      local section = line:match(pat)
      if section then
        table.insert(items, {
          bufnr = vim.api.nvim_get_current_buf(),
          lnum = i,
          text = section:gsub("^%s*(.-)%s*$", "%1")
        })
        break
      end
    end
  end

  return items
end

-- @t [ Location List TOC ]
local function toc_loclist()
  local items = collect_toc()
  if #items == 0 then
    vim.notify("No sections found", vim.log.levels.WARN)
    return
  end

  vim.fn.setloclist(0, items, "r")
  vim.cmd("lopen")

  vim.bo.filetype = 'toc'
  vim.bo.syntax = 'toc'

  vim.notify("Table of Contents generated!", vim.log.levels.INFO)
end

local augroup = vim.api.nvim_create_augroup("TOC_LL", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "qf",
  callback = function ()
    vim.api.nvim_create_autocmd("BufLeave", {
      group = augroup,
      buffer = 0,
      once = true,
      callback = function ()
        vim.cmd("lclose")
      end
    })
  end,
})

-- @t [ UI Select TOC ]
local function toc_select()
  local items = collect_toc()

  if #items == 0 then
    vim.notify("No sections found", vim.log.levels.WARN)
    return
  end

  vim.ui.select(items, {
    prompt = "Table Of Contents",
    format_item = function (item)
      return string.format("%4d %s", item.lnum, item.text)
    end,
  }, function (choice)
    if choice then
      vim.api.nvim_win_set_cursor(0, { choice.lnum, 0 })
    end
  end)
end

-- @t [ TOC Keymaps ]
vim.keymap.set("n", "<leader>ft", toc_select, { desc = "Generate Table of Contents (Selection Ui)" })
vim.keymap.set("n", "<leader>tc", toc_loclist, { desc = "Generate Table of Contents (Location List)" })
