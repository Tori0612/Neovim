-- @p lua/custom/terminal.lua
-- ╭──────────────────────────────────────────────────────────╮
-- │                        Terminal                          │
-- ╰──────────────────────────────────────────────────────────╯
-- This native plugin tries to achieve the same behavior as toggleterm
-- (@l https://github.com/akinsho/toggleterm.nvim ) but i couldnt personalize it that much,
-- when i say i couldn't i mean that i'm pretty bad at it, but it works, maybe i'm doing something
-- wrong with the way that i'm calling the shell, but i'll leave it like that.

local state = {
    buf = -1,
    win = -1,
}

local function toggle_terminal()
    if vim.api.nvim_win_is_valid(state.win) then
        vim.api.nvim_win_hide(state.win)
        return
    end

    if not vim.api.nvim_buf_is_valid(state.buf) then
        state.buf = vim.api.nvim_create_buf(false, true)
    end

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
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
    vim.api.nvim_set_option_value("winhl", "NormalFloat:FloatDarkBg,FloatBorder:FloatDarkBorder", { win = state.win })

    if vim.bo[state.buf].buftype ~= "terminal" then
        vim.fn.jobstart(vim.o.shell, {
            term = true,
            env = { TERM = "xterm-256color" }
        })
    end

    vim.cmd("startinsert")
end

vim.keymap.set({ "n", "t" }, "<C-\\>", toggle_terminal, { desc = "Toggle Terminal" })
