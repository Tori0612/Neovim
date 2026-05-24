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
local M = {}

local is_windows = vim.fn.has("win32") == 1

local map = require('utils.map')

local state = {
  term = { name = "terminal", buf = -1, win = -1, cmd = vim.o.shell },
  lazygit = { name = "lazygit", buf = -1, win = -1, cmd = "lazygit" },
  lazydocker = { name = "lazydocker", buf = -1, win = -1, cmd = "lazydocker" },
  tsmanager = { name = "tsmanager", buf = -1, win = -1, cmd = vim.o.shell },
  tetris = { name = 'tetro', buf = -1, win = -1, cmd = 'tetro-tui' },
}

local ts_items = {
  "Install",
  "Remove",
  "List",
  "Quit",
}

local ts_index = 1

local function close_later(win, ms)
  vim.defer_fn(function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, ms or 1500)
end

local function append_log(buf, line)
  vim.api.nvim_set_option_value("modifiable", true, { buf = buf })

  local lines = vim.split(line, "\n", { plain = true })

  local last = vim.api.nvim_buf_line_count(buf)

  vim.api.nvim_buf_set_lines(buf, last, last, false, lines)

  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

  local win = vim.fn.bufwinid(buf)

  if win ~= -1 then
    vim.api.nvim_win_set_cursor(win, {
      vim.api.nvim_buf_line_count(buf),
      0,
    })
  end
end

local function start_log(buf, title)
  vim.api.nvim_set_option_value("modifiable", true, { buf = buf })

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
    "󰣇 Tree-sitter Manager",
    "",
    title,
    ""
  })

  vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
end

local function toggle_tool(tool)
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

  local function render_ts_menu(buf)
    local lines = { "󰣇 Tree-sitter Manager", "" }

    for i, item in ipairs(ts_items) do
      local prefix = (i == ts_index) and " " or " "
      table.insert(lines, prefix .. item)
    end

    vim.api.nvim_set_option_value("modifiable", true, { buf = tool.buf })
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_set_option_value("modifiable", false, { buf = tool.buf })
  end

  if tool.name == 'tsmanager' then
    render_ts_menu(tool.buf)


    map.n("j", function()
      ts_index = math.min(ts_index + 1, #ts_items)
      render_ts_menu(tool.buf)
    end, { buffer = tool.buf })

    map.n("k", function()
      ts_index = math.max(ts_index - 1, 1)
      render_ts_menu(tool.buf)
    end, { buffer = tool.buf })

    map.n("<CR>", function()
      local ts = require("custom.treesitter_manager")
      local choice = ts_items[ts_index]

      if choice == "Install" then
        vim.ui.input({ prompt = "Git URL: " }, function(url)
          if url and url ~= "" then
            start_log(tool.buf, "󰣇 Installing parser...")
            ts.set_logger(function(level, msg)
              local icons = {
                step = "⏳ ",
                info = "󰈞 ",
                success = "✔ ",
                warn = "⚠ ",
                error = "✖ ",
              }

              append_log(tool.buf, (icons[level] or "") .. msg)
            end)

            ts.install(url)
            close_later(tool.win, 67000)
          end
        end)
      elseif choice == "Remove" then
        vim.ui.input({ prompt = "Language: " }, function(lang)
          if lang and lang ~= "" then
            ts.remove(lang)
            close_later(tool.win, 2400)
          end
        end)
      elseif choice == "List" then
        ts.list()
        close_later(tool.win, 2700)
      elseif choice == "Quit" then
        vim.api.nvim_win_close(tool.win, true)
      end
    end, { buffer = tool.buf })

    map.n("q", function()
      vim.api.nvim_win_close(tool.win, true)
    end, { buffer = tool.buf })

    vim.bo[tool.buf].buftype = "nofile"
    vim.bo[tool.buf].bufhidden = "wipe"
    vim.bo[tool.buf].swapfile = false
    vim.bo[tool.buf].modifiable = false

    vim.api.nvim_set_current_win(tool.win)
    vim.cmd("normal! gg")

    return
  end

  if vim.bo[tool.buf].buftype ~= "terminal" then
    local opts = {
      term = true,
      on_exit = function ()
        if vim.api.nvim_buf_is_valid(tool.buf) then
          vim.api.nvim_buf_delete(tool.buf, { force = true })
        end
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

    if tool.name == "terminal" then
      map.t("<Esc>", [[<C-\><C-n>]], { buffer = tool.buf, desc = "Enables escaping to Normal mode inside the terminal" })
      map.t("jj", "<Esc>", { remap = true, desc = "Escapes to Normal mode inside the terminal" })
    end
  end

  vim.cmd("startinsert")
end

function M.run_cmd(opts)
  if type(opts) == "string" then
    opts = { cmd = opts, mode = "hold" }
  end

  local cmd = opts.cmd
  local mode = opts.mode or "hold"
  local full_cmd

  if mode == "hold" then
    full_cmd = {
      vim.o.shell,
      "-c",
      cmd .. [[; echo; echo "-----------------------"; printf "Process finished. Press ENTER to close..."; read _]]
    }
  elseif mode == "repl" then
    -- full_cmd = {
    --   vim.o.shell,
    --   "-ic",
    --   cmd
    -- }
    full_cmd = cmd
  else
    full_cmd = cmd
  end

  local temp_tool = {
    name = "temp",
    buf = -1,
    win = -1,
    cmd = full_cmd
  }
  toggle_tool(temp_tool)
end

map.nt("<C-\\>", function() toggle_tool(state.term) end, { desc = "Toggle Terminal" })
map.n("<leader>tg", function() toggle_tool(state.lazygit) end, { desc = "Toggle Lazygit" })
map.n("<leader>td", function() toggle_tool(state.lazydocker) end, { desc = "Toggle Lazydocker" })
map.n("<leader>tm", function() toggle_tool(state.tsmanager) end, { desc = "Toggle TSManager" })
map.n("<leader>tt", function() toggle_tool(state.tetris) end, { desc = "Toggle Tetro-TUI" })

return M
