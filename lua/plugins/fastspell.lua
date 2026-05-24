-- @p lua/plugins/fastspell.lua
local gh = require('utils.github').gh

vim.pack.add({
  { src = gh("lucaSartore/fastspell.nvim") }
})

local fastspell = require('fastspell')

fastspell.setup({
  cspell_json_file_path = vim.fn.stdpath("config") .. "/cspell.json",
  diagnostic_severity = vim.diagnostic.severity.HINT,
})

local function enable_fastspell()
  local group = vim.api.nvim_create_augroup("FastSpellForMarkdown", { clear = true })
  vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    group = group,
    buffer = 0,
    callback = function(_)
      local buffer = vim.api.nvim_get_current_buf()
      local first_line = 0
      local last_line = vim.api.nvim_buf_line_count(buffer)
      fastspell.sendSpellCheckRequest(first_line, last_line)
    end,
  })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = 'markdown',
  callback = enable_fastspell,
})

local function add_word_to_cspell(word)
  if not word or word == "" then
    vim.notify("No word to add", vim.log.levels.WARN)
    return
  end

  local cspell_path = vim.fn.stdpath("config") .. "/cspell.json"

  local file = io.open(cspell_path, "r")
  if not file then
    vim.notify("cspell.json not found at " .. cspell_path, vim.log.levels.ERROR)
    return
  end

  local content = file:read("*all")
  file:close()

  local ok, config = pcall(vim.json.decode, content)
  if not ok then
    vim.notify("Invalid JSON in cspell.json", vim.log.levels.ERROR)
    return
  end

  config.words = config.words or {}

  if not vim.tbl_contains(config.words, word) then
    table.insert(config.words, word)
  else
    vim.notify("Word '" .. word .. "' already in dictionary", vim.log.levels.INFO)
    return
  end

  table.sort(config.words)

  -- Write back to file
  local indent_string = string.rep(" ", 2)
  local new_content = vim.json.encode(config, { indent = indent_string, sort_keys = true })
  file = io.open(cspell_path, "w")
  if not file then
    vim.notify("Cannot write to " .. cspell_path, vim.log.levels.ERROR)
    return
  end
  file:write(new_content)
  file:close()

  vim.notify("Added '" .. word .. "' to dictionary", vim.log.levels.INFO)

  -- Optional: Trigger a re-check to clear the diagnostic immediately
  local buffer = vim.api.nvim_get_current_buf()
  local last_line = vim.api.nvim_buf_line_count(buffer)
  fastspell.sendSpellCheckRequest(0, last_line)
end

vim.api.nvim_set_keymap("n", "<leader>nd", "", {
  noremap = true,
  silent = true,
  callback = function()
    local word = vim.fn.expand("<cword>")
    add_word_to_cspell(word)
  end,
  desc = "Add word under cursor to spell dictionary",
})

vim.api.nvim_set_keymap("v", "<leader>nd", "", {
  noremap = true,
  silent = true,
  callback = function()
    local start_pos = vim.api.nvim_buf_get_mark(0, "<")
    local end_pos = vim.api.nvim_buf_get_mark(0, ">")
    local lines = vim.api.nvim_buf_get_text(0, start_pos[1]-1, start_pos[2], end_pos[1]-1, end_pos[2], {})
    local word = table.concat(lines, " ")
    add_word_to_cspell(word)
  end,
  desc = "Add selected text to spell dictionary",
})

