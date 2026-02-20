-- @p lua/globals/completion.lua
-- This is an attempt to "do what blink does" locally, it pretty much works, poorly? yes!, but works? YES.
-- First, i'm still constantly failing on capturing and showing the snippets on the completion menu,
-- the problem is prolly on the way that i'm implementing the table, but i got tired of trying and just
-- gave up on it for now.
-- The Icons were AI generated, and i didn't even check, just accepted it. About the completion itself, there
-- are some points:
-- # i didnt check on any source for making the priority table, so you can disagree and change it.
-- # the filtering works but sometimes it falls back to the default behavior, i tried changing, the
     -- way it handles the debounce more than once but it is still weird, sometimes it will just turn
     -- off completly until you type another word.
-- # the way i made it so that the menu "always" appears is definitely "brute force" i just call
     -- <C-x><C-o> whenever something is being typed, letting the lsp handle it was just not doing it,
     -- it seems that blink have some fall backs to it, that directly calls the lsp in certain situations
     -- that the lsp wouldn't call it, like keyword, consts, mostly snippets, and that's what i plan to do
     -- next.

-- { Snippet Handlers {{{
local ls = require('luasnip')
local recent_usage = {}

local function matches_prefix(trigger, prefix)
  return trigger:sub(1, #prefix) == prefix
end

local function get_current_prefix()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  return line:sub(1, col):match("[%w_]+$") or ""
end

local function get_snippet_completions()
  local ft = vim.bo.filetype
  local snippets = ls.get_snippets(ft) or {}
  local prefix = get_current_prefix()
  local items = {}

  if prefix == "" then return items end

  for _, snip in ipairs(snippets) do
    if snip.snippetType ~= "autosnippet" then
      if matches_prefix(snip.trigger, prefix) then
        table.insert(items, {
          word = snip.trigger,
          abbr = snip.trigger,
          kind = vim.lsp.protocol.CompletionItemKind.Snippet,
          user_data = {
            luasnip = true,
            snip = snip,
          }
        })
      end
    end
  end

  return items
end
-- }}}

-- { Icons {{{
local icons = {
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰊄",
}
-- }}}

-- { Kind Priorities {{{
local kind_priority = {
  Keyword = 1,
  Function = 2,
  Method = 3,
  Constructor = 4,
  Variable = 5,
  Field = 6,
  Class = 7,
  Struct = 8,
  Interface = 9,
  Module = 10,
  Snippet = 20,
  Text = 99,
}
-- }}}

-- { Priority Handler {{{
local function score_item(item)
  local score = 0

  local word = item.word or ""
  local input = get_current_prefix()

  if word:sub(1, #input) == input then score = score - 50 end

  local kind_name = vim.lsp.protocol.CompletionItemKind[item.kind] or "Text"
  score = score + (kind_priority[kind_name] or 50)
  score = score + (#word * 0.01)

  if word:match("^-+") then score = score + 20 end

  if recent_usage[word] then score = score - 30 end

  return score
end
-- }}}

-- { Filter Completions {{{
local orig = vim.lsp.completion._convert_results
vim.lsp.completion._convert_results = function(...)
  local items = orig(...)

  local snippet_items = get_snippet_completions()

  for _, item in ipairs(snippet_items) do
    table.insert(items, item)
  end

  for _, item in ipairs(items) do
    if item.kind then
      local kind_name = vim.lsp.protocol.CompletionItemKind[item.kind]
      local icon = icons[kind_name]
      if icon then
        item.abbr = icon .. " " .. (item.abbr or item.word)
      end
    end
  end

  table.sort(items, function(a, b)
    return score_item(a) < score_item(b)
  end)

  return items
end
-- }}}

-- { Tracking Variables {{{
local last_col = 0
local last_tick = 0
local cooldown = 120 -- ms
-- }}}

-- { Suggestion Handlers {{{
local function accept_suggestion()
  if vim.fn.pumvisible() == 1 then
    local info = vim.fn.complete_info({ "selected", "items" })
    local selected = info.selected
    if selected ~= -1 then
      local entry = info.items[selected + 1]
      if entry.user_data and entry.user_data.luasnip then
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes("<C-e>", true, false, true),
          "n",
          true
        )

        local prefix = get_current_prefix()
        if prefix ~= "" then
          vim.api.nvim_buf_set_text(
            0,
            vim.fn.line('.') - 1,
            vim.fn.col('.') - 1 - #prefix,
            vim.fn.line('.') - 1,
            vim.fn.col('.') - 1,
            {}
          )
        end

        recent_usage[entry.word] = (recent_usage[entry.word] or 0) + 1
        ls.snip_expand(entry.user_data.snip)
        return ""
      end
    end

    last_tick = vim.loop.now()
    return vim.api.nvim_replace_termcodes("<C-y>", true, false, true)
  end
  return "ç"
end

local function update_suggestions()
  if vim.fn.pumvisible() == 1 then return end
  if vim.bo.buftype ~= "" then return end

  local col = vim.fn.col(".")
  if col <= last_col then return end

  local now = vim.loop.now()
  if now - last_tick < cooldown then return end

  last_col = col
  last_tick = now

  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true),
    "n",
    true
  )
end
-- }}}

-- { Enable Completion {{{
local function enable_completion(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then return end

  if client:supports_method('textDocument/completion', args.buf) then
    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
  end
end
-- }}}

-- { AutoCommands {{{
vim.api.nvim_create_autocmd("TextChangedI", {
  callback = update_suggestions
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    last_col = 0
    last_tick = 0
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = enable_completion
})
-- }}}

-- { Keymaps {{{
vim.keymap.set("i", "<CR>", function()
  if vim.fn.pumvisible() == 1 then
    return vim.api.nvim_replace_termcodes("<C-e><CR>", true, false, true)
  end
  return "<CR>"
end, { expr = true })

vim.keymap.set("i", "ç", accept_suggestion, { expr = true, noremap = true })
-- }}}

-- { Completion Options {{{
vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy" }
vim.opt.pumheight = 10
-- }}}

-- vim: foldmethod=marker
