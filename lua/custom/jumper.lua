-- @p lua/custom/jumper.lua
-- ╭──────────────────────────────────────────────────────────╮
-- │                        Jumper                            │
-- ╰──────────────────────────────────────────────────────────╯
-- This is "native plugin" is inspired in Harpoon (@l https://github.com/ThePrimeagen/harpoon ) it is not so pretty and prolly
-- not so effective as his, but it does the work, i'm trying to run as much away from plenary
-- in these configs, to be the most native as possible, so yeah it works just like harpoon.
-- You can use the table of contents @p lua/custom/toc.lua or go to the end of the file to change keymaps.

-- { Main Variables {{{
local M = {};
local marks_win = nil
-- }}}

-- { Persistence Setup {{{
local data_path = vim.fn.stdpath("data") .. "/jumper.json"

local function load_marks()
  local f = io.open(data_path, "r")
  if not f then return {} end
  local content = f:read("*a")
  f:close()
  if content == "" then return {} end
  local ok, parsed = pcall(vim.fn.json_decode, content)
  return ok and parsed or {}
end

local function save_marks()
  local f = io.open(data_path, "w")
  if f then
    f:write(vim.fn.json_encode(M.all_marks))
    f:close()
  end
end

M.all_marks = load_marks()

local function get_current_marks()
  local cwd = vim.fn.getcwd()
  if not M.all_marks[cwd] then
    M.all_marks[cwd] = {}
  end
  return M.all_marks[cwd]
end
-- }}}

-- { Add Mark to The List {{{
function M.add_mark()
  local buf_name = vim.api.nvim_buf_get_name(0)
  if buf_name == "" then return end

  local relative_path = vim.fn.fnamemodify(buf_name, ":.")
  local marks = get_current_marks()

  for _, path in ipairs(marks) do
    if path == relative_path then
      print("Already added to jumplist")
      return
    end
  end

  table.insert(marks, relative_path)
  save_marks()
  print("Pinned: " .. vim.fn.fnamemodify(relative_path, ":t"))
end
-- }}}

-- { Go to a mark (file) {{{
function M.goto_mark(id)
  local marks = get_current_marks()
  local path = marks[id]
  if path then
    vim.cmd('edit ' .. path)
  else
    print("Slot " .. id .. " is empty.")
  end
end
-- }}}

-- { Clear Marks List {{{
function M.clear_marks()
  local cwd = vim.fn.getcwd()
  M.all_marks[cwd] = {}
  save_marks()
  print('Jumper list cleared for current directory')
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
  local marks = get_current_marks()

  if marks_win and vim.api.nvim_win_is_valid(marks_win) then
    vim.api.nvim_set_current_win(marks_win)
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)

  -- local lines = {}
  -- for i, path in ipairs(M.marks) do
  --   table.insert(lines, string.format("[%d] %s", i, vim.fn.fnamemodify(path, ":p")))
  -- end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, marks)

  local width = math.floor(vim.o.columns * 0.7)
  local height = math.max(#marks, 5)
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
      local id = vim.fn.line('.')
      M.close_marks()
      M.goto_mark(id)
  end, { buffer = buf })

  vim.keymap.set("n", "q", M.close_marks, { buffer = buf, silent = true })

  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = buf,
    callback = function()
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      local new_marks = {}
      for _, line in ipairs(lines) do
        if line ~= "" then
          table.insert(new_marks, line)
        end
      end

      M.all_marks[vim.fn.getcwd()] = new_marks
      save_marks()
    end,
  })
end
-- }}}

-- { Show Index for Statusline {{{
function M.get_current_index()
  local buf_name = vim.api.nvim_buf_get_name(0)
  local relative_path = vim.fn.fnamemodify(buf_name, ":.")
  local marks = get_current_marks()

  for i, path in ipairs(marks) do
    if path == relative_path then
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

vim.keymap.set("n", "<A-1>", function () M.goto_mark(1) end, opts)
vim.keymap.set("n", "<A-2>", function () M.goto_mark(2) end, opts)
vim.keymap.set("n", "<A-3>", function () M.goto_mark(3) end, opts)
vim.keymap.set("n", "<A-4>", function () M.goto_mark(4) end, opts)
vim.keymap.set("n", "<A-q>", function () M.goto_mark(5) end, opts)
vim.keymap.set("n", "<A-w>", function () M.goto_mark(6) end, opts)
vim.keymap.set("n", "<A-e>", function () M.goto_mark(7) end, opts)
vim.keymap.set("n", "<A-r>", function () M.goto_mark(8) end, opts)
-- }}}

return M
