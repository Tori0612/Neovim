vim.api.nvim_create_user_command("Manim", function()
  local filepath = vim.fn.expand("%:p")
  local filename_no_ext = vim.fn.expand("%:t:r")

  if filepath == "" or vim.fn.expand("%:e") ~= "py" then
    vim.notify("Current buffer is not a Python file!", vim.log.levels.ERROR)
    return
  end

  vim.ui.input({ prompt = "Manim Class Name: " }, function(class_name)
    if not class_name or class_name == "" then return end

    vim.ui.select(
      { "1. Generate, Commit & Push to GitHub", "2. Default Manim (Local only)" },
      { prompt = "Action:" },
      function(choice, idx)
        if not choice then return end

        local cmd = string.format("manim -s -q h '%s' '%s' -o '%s.png'", filepath, class_name, class_name)

        if idx == 1 then
          local git_root = vim.fn.system("git rev-parse --show-toplevel"):gsub("%s+", "")

          if git_root:match("fatal") then
            vim.notify("Not in a git repository! Run 'git init' first.", vim.log.levels.ERROR)
            return
          end
          local dest_dir = git_root .. "/images"
          local src = string.format("media/images/%s/%s.png", filename_no_ext, class_name)
          local dest = string.format("%s/%s.png", dest_dir, class_name)

          cmd = string.format(
            "%s && mkdir -p '%s' && mv '%s' '%s' && cd '%s' && git add '%s' && git commit -m 'auto-add: %s' && git push",
            cmd, dest_dir, src, dest, git_root, dest, class_name
          )
          vim.notify("Manim: Rendering and pushing in the background...", vim.log.levels.INFO)

          vim.fn.jobstart(cmd, {
            on_exit = function(_, exit_code)
              if exit_code == 0 then
                vim.notify("Manim: Image successfully pushed to GitHub!", vim.log.levels.INFO)
              else
                vim.notify("Manim Error: Check for Python/LaTeX syntax issues.", vim.log.levels.ERROR)
              end
            end
          })
        end

        vim.cmd("! " .. cmd)
      end
    )
  end)
end, {})

local manim_augroup = vim.api.nvim_create_augroup("ManimWatcher", { clear = true })

vim.api.nvim_create_user_command("ManimWatch", function()
  -- Ask for the class name once when you start watching
  vim.ui.input({ prompt = "Class to watch: " }, function(class_name)
    if not class_name or class_name == "" then return end

    vim.notify("Live preview started for: " .. class_name, vim.log.levels.INFO)

    -- Create an autocmd attached ONLY to the current buffer
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = manim_augroup,
      buffer = 0, 
      callback = function()
        local filepath = vim.fn.expand("%:p")

        -- Forces the output to be named exactly 'preview.png' in your current folder
        local cmd = string.format("manim -s -q h '%s' '%s' -o preview.png", filepath, class_name)

        -- Run silently in the background
        vim.fn.jobstart(cmd, {
          on_exit = function(_, code)
            if code == 0 then
              vim.notify("Preview updated!", vim.log.levels.INFO)
            else
              vim.notify("Manim Error: Check your syntax.", vim.log.levels.ERROR)
            end
          end
        })
      end
    })
  end)
end, {})

-- A command to turn the watcher off
vim.api.nvim_create_user_command("ManimStop", function()
  vim.api.nvim_clear_autocmds({ group = "ManimWatcher", buffer = 0 })
  vim.notify("Live preview stopped.", vim.log.levels.INFO)
end, {})
