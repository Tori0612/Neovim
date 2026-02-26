-- @p lua/custom/jumper.lua
-- ╭──────────────────────────────────────────────────────────╮
-- │                        Jumper                            │
-- ╰──────────────────────────────────────────────────────────╯
-- This is "native plugin" is inspired in Harpoon (@l https://github.com/ThePrimeagen/harpoon ) it is not so pretty and prolly
-- not so effective as his, but it does the work, i'm trying to run as much away from plenary
-- in these configs, to be the most native as possible, so yeah it works just like harpoon.
-- You can use the table of contents @p lua/custom/toc.lua or go to the end of the file to change keymaps.

-- { Tracker Variables {{{
local M = {}
M.makrs = {}
local marks_win = nil
-- }}}

-- { Add Mark to The List {{{
function M.add_mark()
  local buf_name = vim.api.nvim_buf_get_name(0)
  if buf_name == "" then return end

  for _, path in ipairs(M.makrs) do
    if path == buf_name then
      print("Already added to jumplist")
      return
    end
  end

  table.insert(M.makrs, buf_name)
  print("Pinned: " .. vim.fn.fnamemodify(buf_name, ":t"))
end
-- }}}

-- { Go to a mark (file) {{{
function M.goto_mark(id)
  local path = M.makrs[id]
  if path and vim.fn.filereadable(path) == 1 then
    vim.cmd('edit ' .. path)
  else
    print("Slot " .. id .. " is empty.")
  end
end
-- }}}

-- { Clear Marks List {{{
function M.clear_marks()
  M.makrs = {}
  print('Jumper list cleared')
end
-- }}}

-- { Close Marks List {{{
function M.close_marks()
  if marks_win and vim.api.nvim_win_is_valid(marks_win) then
    vim.api.nvim_win_close(marks_win, true)
  end
  marks_win = nil
end
-- }}}

-- { Open Floating Marks List {{{
function M.list_marks()
  if #M.makrs == 0 then print("Jumper list is empty") return end

  if marks_win and vim.api.nvim_win_is_valid(marks_win) then
    vim.api.nvim_set_current_win(marks_win)
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)

  local lines = {}
  for i, path in ipairs(M.makrs) do
    table.insert(lines, string.format("[%d] %s", i, vim.fn.fnamemodify(path, ":p")))
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local width = math.floor(vim.o.columns * 0.7)
  local height = #lines + 2
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal", border = "rounded", title = "Jumper Marks "
  })
  vim.api.nvim_set_option_value("winhl", "NormalFloat:FloatDarkBg,FloatBorder:FloatDarkBorder", { win = win })
  marks_win = win

  vim.keymap.set('n', '<CR>', function() -- Keymap to open the mark under cursor
      local line = vim.api.nvim_get_current_line()
      local id = tonumber(line:match("^%[(%d+)%]"))
      M.close_marks()
      if id then
        print("ID:", id)
        M.goto_mark(id)
      end
  end, { buffer = buf })

  vim.keymap.set("n", "q", M.close_marks, { buffer = buf, silent = true })
end
-- }}}

-- { Show Index for Statusline {{{
function M.get_current_index()
  local current_file = vim.api.nvim_buf_get_name(0)
  for i, path in ipairs(M.makrs) do
    if path == current_file then
      return i
    end
  end
  return nil
end
-- }}}

-- { Toggle Marks List {{{
local function toggle_marks_list()
  if marks_win and vim.api.nvim_win_is_valid(marks_win) then
    M.close_marks()
  else
    M.list_marks()
  end
end
-- }}}

-- { Keymaps {{{
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>a', M.add_mark, opts)
vim.keymap.set('n', '<leader>hc', M.clear_marks, opts)
vim.keymap.set('n', '<C-h>', toggle_marks_list,opts)

vim.keymap.set("n", "<C-1>", function () M.goto_mark(1) end, opts)
vim.keymap.set("n", "<C-2>", function () M.goto_mark(2) end, opts)
vim.keymap.set("n", "<C-3>", function () M.goto_mark(3) end, opts)
-- }}}

return M
