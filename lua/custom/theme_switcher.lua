-- @p lua/custom/theme_switcher.lua
-- This "native plugin" is just an integration of a go "application" that i made for changing my
-- colorschemes in a nice and visual way. It was inspired in a zig application that i made a month ago,
-- for changing my whole environment at once, like: waybar, rofi, hyprland borders, swww, neovim and kitty.
-- If your config is not on the default location @p ~/.config/nvim/ it prolly wont work and i dont recommend
-- trying.
local state = {
  buf = -1,
  win = -1,
}

local function reload_colorscheme()
  local theme = vim.g.colors_name
  if not theme then return end

  local path = vim.fn.stdpath('config') .. '/lua/colors/colorscheme.lua'
  if vim.fn.filereadable(path) == 1 then
    dofile(path)
  end
end

local function reload_highlights()
  local path = vim.fn.stdpath('config') .. '/lua/custom/highlights.lua'
  if vim.fn.filereadable(path) == 1 then
    dofile(path)
  end
end

local function reload_theme()
  reload_colorscheme()
  reload_highlights()
end

local function open_theme_switcher()
  if vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_hide(state.win)
    return
  end

  state.buf = vim.api.nvim_create_buf(false, true)

  vim.bo[state.buf].buftype = "nofile"
  vim.bo[state.buf].bufhidden = "wipe"
  vim.bo[state.buf].swapfile = false

  local width = math.floor(vim.o.columns * 0.5)
  local height = math.floor(vim.o.lines * 0.6)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  state.win = vim.api.nvim_open_win(state.buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  vim.api.nvim_set_option_value("winhl",
    "NormalFloat:FloatDarkBg,FloatBorder:FloatDarkBorder",
    { win = state.win })

  local theme_switcher_path = vim.fn.stdpath('config') .. '/bin/nvim-themes'

  vim.fn.jobstart(theme_switcher_path, {
    term = true,
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        reload_theme()
        vim.notify("✓ Theme applied", vim.log.levels.INFO)
      else
        vim.notify("Theme switcher exited with an error", vim.log.levels.ERROR)
      end
    end,
  })

  vim.cmd("startinsert")
end

vim.keymap.set('n', '<leader>ts', open_theme_switcher, { desc = "Theme Switcher" })
vim.keymap.set({ "n", "t" }, "q", function()
  if vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
  end
end, { buffer = state.buf, nowait = true, desc = "Close Theme Switcher" })
