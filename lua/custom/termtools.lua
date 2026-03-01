-- @p lua/custom/termtools.lua
-- ╭──────────────────────────────────────────────────────────╮
-- │                        Terminal                          │
-- ╰──────────────────────────────────────────────────────────╯
-- This native plugin tried, at first, to achieve the same behavior as toggleterm
-- (@l https://github.com/akinsho/toggleterm.nvim ), but then when looking at the
-- lazygit plugin docs (you can see it on @l https://github.com/kdheepak/lazygit.nvim )
-- and at the beginning they say like 'see toggleterm as an alternative to this package',
-- and i thought 'hmm, since i made a "custom" toggleterm, then i can try implementing this'
-- so i started changing stuff, and by now, i'm fine with how it is, maybe later i'll spread
-- this into different customs, but i dont think logic will get that complicated.
local is_windows = vim.fn.has("win32") == 1

local state = {
  term = { buf = -1, win = -1, cmd = vim.o.shell },
  lazygit = { buf = -1, win = -1, cmd = "lazygit" },
  lazydocker = { buf = -1, win = -1, cmd = "lazydocker" },
}

local function toggle_tool(tool_name)
  local tool = state[tool_name]
  if vim.api.nvim_win_is_valid(tool.win) then
    vim.api.nvim_win_hide(tool.win)
    return
  end

  if not vim.api.nvim_buf_is_valid(tool.buf) then
    tool.buf = vim.api.nvim_create_buf(false, true)
  end

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  tool.win = vim.api.nvim_open_win(tool.buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  vim.api.nvim_set_option_value("winhl", "NormalFloat:FloatDarkBg,FloatBorder:FloatDarkBorder", { win = tool.win })
  vim.api.nvim_set_option_value("winblend", 3, { win = tool.win })

  if vim.bo[tool.buf].buftype ~= "terminal" then
    local opts = {
      term = true,
      on_exit = function ()
        tool.buf = -1
        if vim.api.nvim_win_is_valid(tool.win) then
          vim.api.nvim_win_close(tool.win, true)
        end
      end
    }

    if not is_windows then
      opts.env = { TERM = "xterm-256color" }
    end

    vim.api.nvim_buf_call(tool.buf, function ()
      vim.fn.jobstart(tool.cmd, opts)
    end)

    vim.api.nvim_create_autocmd("BufEnter", {
      buffer = tool.buf,
      callback = function ()
        vim.cmd("startinsert")
      end,
    })

    if tool_name == "term" then
      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { buffer = tool.buf, desc = "Enables escaping to Normal mode inside the terminal" })
      vim.keymap.set("t", "jj", "<Esc>", { remap = true, desc = "Escapes to Normal mode inside the terminal" })
    end
  end

  vim.cmd("startinsert")
end

vim.keymap.set({ "n", "t" }, "<C-\\>", function() toggle_tool("term") end, { desc = "Toggle Terminal" })
vim.keymap.set({ "n" }, "<leader>tg", function() toggle_tool("lazygit") end, { desc = "Toggle Lazygit" })
vim.keymap.set({ "n" }, "<leader>td", function() toggle_tool("lazydocker") end, { desc = "Toggle Lazydocker" })
