return {
    vim.keymap.set('n', '<leader>mw', function()
        vim.cmd('vsplit')  -- Open vertical split
        vim.cmd('terminal marimo --log-level INFO edit ' .. vim.fn.expand('%') .. ' --watch')
    end, { desc = 'Launch marimo watch in side terminal' })
}
