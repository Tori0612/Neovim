return {
  {
    'jeryldev/pyworks.nvim',
    config = function()
      require('pyworks').setup({
        virtualenv = true,
        virtualenv_name = 'myenv',  -- Corrected to your venv
        jupyter = false,  -- Disable Jupyter to skip jupytext/image.nvim
        check_packages = { 'matplotlib', 'pandas', 'numpy', 'pynvim', 'jupyter', 'ipykernel', 'selenium', 'jupynium' },
      })
    end,
    keys = {
      { '<leader>ps', '<cmd>PyworksSetup<cr>', desc = 'Setup Python project' },
    },
  },
}
