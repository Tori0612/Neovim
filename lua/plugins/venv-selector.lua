return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    { "nvim-telescope/telescope.nvim", branch = "*", dependencies = { "nvim-lua/plenary.nvim" } }, -- optional: you can also use fzf-lua, snacks, mini-pick instead.
  },
  ft = "python", -- Load when opening Python files
  opts = {
    settings = {
      options = {
        notify_user_on_venv_activation = true,
      },
    },
    search = {
      cwd = false,
      workspace = false,
      git = false,
      anaconda = false,
      poetry = false,
      pipenv = false,
      pyenv = false,
      hatch = false,
      venv = false,
      -- my venvs
      my_venvs = {
        command = "fd python$ " .. vim.fn.expand("~/.venvs") .. " --full-path --color never -E /proc",
        type = "venv",
      },
    },
  },
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>" }, -- Open picker on keymap
  },
}
