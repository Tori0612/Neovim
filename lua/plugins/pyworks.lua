 return {
  "jeryldev/pyworks.nvim",
  dependencies = {
    "benlubas/molten-nvim",
    "3rd/image.nvim", -- optional, for images
    "gcballesteros/jupytext.nvim", -- optional, if you edit .ipynb files
  },
  config = function()
    require("pyworks").setup({
      -- This creates a keymap to toggle the environment/kernel
      -- You asked for a keybind to "activate" -> This is it.
      automount = true,
    })
  end,
  keys = {
    { "<leader>pw", ":PyworksToggle<CR>", desc = "Toggle Pyworks Environment" },
  }
}
