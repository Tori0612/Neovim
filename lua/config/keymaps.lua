vim.g.mapleader = " "
local map = vim.keymap.set
map("n", "<leader>pl", vim.cmd.Ex)
map("i", "jj", "<Esc>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    map("n", "l", "<CR>", { buffer = true, remap = true })
    map("n", "h", "-", { buffer = true, remap = true })
  end,
})

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map('n', '<leader>v', "\"+p")
map("x", "<leader>p", "\"_dP")

map("n", "<leader>y", "\"+y")
map("v", "<leader>y", "\"+y")
map("n", "<leader>y", "\"+Y")

map("n", "<leader>d", "\"_d")
map("v", "<leader>d", "\"_d")

map("n", "Q", "<nop>")
map("n", "<leader>y", "\"+y")

map("i", "<C-c>", "<Esc>")

map("n", "<C-k>", "<cmd>cnext<CR>zz")
map("n", "<C-j>", "<cmd>cprev<CR>zz")
map("n", "<leader>k", "<cmd>lnext<CR>zz")
map("n", "<leader>j", "<cmd>lprev<CR>zz")

map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
map("v", "<leader>s", "\"hy:%s#<C-r>h#<C-r>h#gI<Left><Left><Left>")
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent=true })
map("n", "<leader>r", ":s/\\s\\+/\\r/g")
map("n", "<leader>z", "_izx<Esc>u")

map("o", "i9", "i(", { noremap = true })
map("o", "ii", "i[", { noremap = true })
map("o", "io", "i{", { noremap = true })

map("o", "a9", "a(", { noremap = true })
map("o", "ai", "a[", { noremap = true })
map("o", "ao", "a{", { noremap = true })

map("n", '<leader>cr', '<cmd>let @+ = expand("%")<CR>', { desc = 'Copy the relative path to the "current" file' })
map("n", '<leader>ca', '<cmd>let @+ = expand("%:p")<CR>', { desc = 'Copy the absolute path to the "current" file' })
map("n", "<leader>=a", "gg=G<C-o>", { desc = "Autoformat entire file" })

map('n', '<leader>va', function() vim.cmd('terminal myvenv\\Scripts\\activate') end, { desc = 'Activate venv' })

map('n', '<leader>cc', function ()
  local file = vim.fn.expand("%")
  local output = vim.fn.expand("%:t:r")
  vim.cmd('!gcc ' .. file .. ' -o ' .. output)
end, { desc = 'Compile c file with gcc' })

map('n', '<leader>cx', function ()
  local output = vim.fn.expand("%:t:r")
  vim.cmd('!./' .. output)
end, { desc = "Run C Binary" })

local venv_folder = vim.fn.expand("~/.venvs")
local function pick_and_activate_venv()
    local venvs = {}
    local handle = vim.loop.fs_scandir(venv_folder)
    if handle then
        while true do
            local name, type = vim.loop.fs_scandir_next(handle)
            if not name then break end
            -- Only add directories
            if type == "directory" then
                table.insert(venvs, name)
            end
        end
    end

    if #venvs == 0 then
        print("No venvs found in " .. venv_folder)
        return
    end

    -- 3. Show the Menu
    vim.ui.select(venvs, { prompt = "Select Python Venv:" }, function(selected)
        if not selected then return end

        -- Construct the full path
        local venv_path = venv_folder .. "/" .. selected
        local python_bin = venv_path .. "/bin/python"

        -- A. Set Environment Variables
        vim.env.VIRTUAL_ENV = venv_path
        vim.env.PATH = venv_path .. "/bin:" .. vim.env.PATH

        -- B. Force Neovim to use this Python
        vim.g.python3_host_prog = python_bin

        -- C. Restart LSP to pick up changes
        vim.cmd("LspRestart")

        print("Activated: " .. selected)
    end)
end

map("n", "<leader>vx", pick_and_activate_venv, { desc = "Switch Python Venv" })

map("n", "<leader>rc", ":!cargo check<CR>", { desc = "Cargo Check" })
map("n", "<leader>rx", ":!cargo run<CR>", { desc = "Cargo Run" })
