-- @p lua/custom/spelling.lua
local map = require('utils.map');

local spell_dir = vim.fn.stdpath("config") .. "/spell";
if vim.fn.isdirectory(spell_dir) == 0 then
  vim.fn.mkdir(spell_dir, "p");
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true;
    vim.opt_local.spelllang = { 'en_us' };
    vim.opt_local.spellfile = spell_dir .. "/custom.utf8.add";
  end,
})

--- { Keymaps {{{
map.n("<leader>nd", "zg", { noremap = true, desc = "Add word under cursor to dictionary" });
map.v("<leader>nd", "zg", { noremap = true, desc = "Add selected text to dictionary" });
map.n("<leader>nw", "zw", { noremap = true, desc = "Remove word under cursor from dictionary" });
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
  end
end, { desc = "Switch Spell Language" });
--- }}}
