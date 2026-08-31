-- @p lua/custom/spelling.lua
local map = require('utils.map');

local spell_dir = vim.fn.stdpath("config") .. "/spell";
if vim.fn.isdirectory(spell_dir) == 0 then
  vim.fn.mkdir(spell_dir, "p");
end

--- { Diagnostic Engine {{{
local spell_ns = vim.api.nvim_create_namespace("native_spell_diagnostics");
local suggest_cache = {};
local timer = nil;

local function update_spell_diagnostics(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then return end;

  if not vim.wo.spell then
    vim.diagnostic.set(spell_ns, bufnr, {});
    return;
  end

  local diagnostics = {};
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false);

  for i, line in ipairs(lines) do
    local col = 0;
    while col < #line do
      local sub = string.sub(line, col+1);
      if sub == "" then break end;

      local bad_info = vim.fn.spellbadword(sub)
      local bad_word = bad_info[1];
      if bad_word == "" then break end;

      local start_idx = string.find(sub, bad_word, 1, true);
      if not start_idx then break end;

      local word_start = col + start_idx - 1;
      local word_end = word_start + #bad_word;

      local suggestion = suggest_cache[bad_word];
      if suggestion == nil then
        local suggestions = vim.fn.spellsuggest(bad_word, 1);
        suggestion = (suggestions and #suggestions > 0) and suggestions[1] or false;
        suggest_cache[bad_word] = suggestion;
      end

      local msg = "Typo: " .. bad_word;
      if suggestion then
        msg = msg .. " (did you mean '" .. suggestion.. "'?)";
      end

      table.insert(diagnostics, {
        lnum = i - 1,
        col = word_start,
        end_col = word_end,
        severity = vim.diagnostic.severity.HINT,
        message = msg,
        source = "spell"
      });

      col = word_end;
    end
  end

  vim.diagnostic.set(spell_ns, bufnr, diagnostics);
end

local function schedule_spell_check()
  local bufnr = vim.api.nvim_get_current_buf();
  if timer then
    timer:stop();
    if not timer:is_closing() then timer:close(); end
  end
  local uv = vim.uv or vim.loop;
  timer = uv.new_timer();

  if timer == nil then return end

  timer:start(500, 0, vim.schedule_wrap(function()
    if vim.api.nvim_buf_is_valid(bufnr) then
      update_spell_diagnostics(bufnr);
    end
  end));
end
--- }}}

--- { Autocommands {{{
local spell_group = vim.api.nvim_create_augroup("NativeSpell", { clear = true });

vim.api.nvim_create_autocmd("FileType", {
  group = spell_group,
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true;
    vim.opt_local.spelllang = { 'en_us' };
    vim.opt_local.spellfile = spell_dir .. "/custom.utf8.add";
    schedule_spell_check();
  end,
})

vim.api.nvim_create_autocmd({ 'TextChanged', "TextChangedI", "BufEnter" }, {
  group = spell_group,
  pattern = "*.md",
  callback = schedule_spell_check,
})
--- }}}

--- { Keymaps {{{
map.n("<leader>nd", function()
  vim.cmd("normal! zg");
  schedule_spell_check();
end, { noremap = true, desc = "Add word under cursor to dictionary" });
map.v("<leader>nd", function()
  vim.cmd("normal! gvzg");
  schedule_spell_check();
end, { noremap = true, desc = "Add selected text to dictionary" });
map.n("<leader>nw", function()
  vim.cmd("normal! zw");
  schedule_spell_check();
end, { noremap = true, desc = "Remove word under cursor from dictionary" });

map.n("<leader>nl", function()
  vim.api.nvim_echo({
    {"Select Spell Language:\n", "Title"},
    {"[1] ", "Directory"}, {"English (en_us)\n", "Normal"},
    {"[2] ", "Directory"}, {"Português (pt)\n", "Normal"},
    {"[3] ", "Directory"}, {"Both (en_us, pt)\n", "Normal"},
    {"[4] ", "Directory"}, {"Disable Spell\n", "Normal"},
    {"Choice: ", "Question"}
  }, false, {});

  local choice = vim.fn.getcharstr();
  vim.cmd('redraw');

  suggest_cache = {};

  if choice == '1' then
    vim.opt_local.spell = true;
    vim.opt_local.spelllang = 'en_us';
    vim.notify("Spell: English");
  elseif choice == '2' then
    vim.opt_local.spell = true;
    vim.opt_local.spelllang = 'pt';
    vim.notify("Spell: Português");
  elseif choice == '3' then
    vim.opt_local.spell = true;
    vim.opt_local.spelllang = { 'en_us', 'pt' };
    vim.notify("Spell: Enlgish & Português");
  elseif choice == '4' then
    vim.opt_local.spell = false;
    vim.notify("Spell: Disabled");
  else
    vim.notify("Invalid choice canceled", vim.log.levels.WARN);
    return;
  end

  schedule_spell_check();
end, { desc = "Switch Spell Language" });
--- }}}
