return {
  {
    "tpope/vim-fugitive",
    lazy = false, -- load immediately
    config = function()
      -- Optional: keymaps
      vim.api.nvim_set_keymap("n", "<leader>gs", ":G<CR>", { noremap = true, silent = true }) -- git status
      vim.api.nvim_set_keymap("n", "<leader>gc", ":Git commit<CR>", { noremap = true, silent = true }) -- git commit
      vim.api.nvim_set_keymap("n", "<leader>gp", ":Git push<CR>", { noremap = true, silent = true }) -- git push
      vim.api.nvim_set_keymap("n", "<leader>gl", ":Git pull<CR>", { noremap = true, silent = true }) -- git pull
    end,
  }
}
