-- @p lua/custom/statusline.lua
-- ╭──────────────────────────────────────────────────────────╮
-- │                       Statusline                         │
-- ╰──────────────────────────────────────────────────────────╯
-- This "native plugin" is a nice and personalizable (english is not my mother tongue)
-- version of nvim-lualine (@l https://github.com/nvim-lualine/lualine.nvim ), since most of the
-- interactions (if not all) are native to neovim why not do it natively? The @t [ Modes Map ] 
-- was AI-Generated, i wouldnt do it all, but the rest i implemented myself, in fact its pretty simple,
-- one of the sections of it depends on @p lua/custom/jumper.lua (a native version of harpoon) you can
-- just delete the lines that use it, you can use the table of contents @p lua/custom/toc.lua to find
-- it faster on @t [ LSP and Jumper Integration ] and on @t [ Implementation and Configs ].

-- { Modes Map {{{
local mode_map = {
    ['n']      = { name = 'NORMAL',       hl = 'StatusNormal' },
    ['no']     = { name = 'OP-PENDING',   hl = 'StatusNormal' },
    ['nov']    = { name = 'OP-PENDING',   hl = 'StatusNormal' },
    ['noV']    = { name = 'OP-PENDING',   hl = 'StatusNormal' },
    ['no\22']  = { name = 'OP-PENDING',   hl = 'StatusNormal' },
    ['niI']    = { name = 'NORMAL',       hl = 'StatusNormal' },
    ['niR']    = { name = 'NORMAL',       hl = 'StatusNormal' },
    ['niV']    = { name = 'NORMAL',       hl = 'StatusNormal' },
    ['v']      = { name = 'VISUAL',       hl = 'StatusVisual' },
    ['V']      = { name = 'V-LINE',       hl = 'StatusVisual' },
    ['\22']    = { name = 'V-BLOCK',      hl = 'StatusVisual' },
    ['i']      = { name = 'INSERT',       hl = 'StatusInsert' },
    ['ic']     = { name = 'INSERT',       hl = 'StatusInsert' },
    ['ix']     = { name = 'INSERT',       hl = 'StatusInsert' },
    ['R']      = { name = 'REPLACE',      hl = 'StatusReplace' },
    ['Rc']     = { name = 'REPLACE',      hl = 'StatusReplace' },
    ['Rv']     = { name = 'V-REPLACE',    hl = 'StatusReplace' },
    ['Rx']     = { name = 'REPLACE',      hl = 'StatusReplace' },
    ['c']      = { name = 'COMMAND',      hl = 'StatusCmd' },
    ['cv']     = { name = 'VIM EX',       hl = 'StatusCmd' },
    ['ce']     = { name = 'EX',           hl = 'StatusCmd' },
    ['r']      = { name = 'PROMPT',       hl = 'StatusNormal' },
    ['rm']     = { name = 'MORE',         hl = 'StatusNormal' },
    ['r?']     = { name = 'CONFIRM',      hl = 'StatusNormal' },
    ['!']      = { name = 'SHELL',        hl = 'StatusNormal' },
    ['t']      = { name = 'TERMINAL',     hl = 'StatusInsert' },
}
-- }}}

-- { LSP and Jumper Integration {{{
local function lsp_status()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then return "" end
    return " ● LSP "
end

local jumper = require("custom.jumper") --delete this whole block if not using Jumper
local function jumper_status()
  local idx = jumper.get_current_index()
  if idx then
    return string.format("J: [%d] ", idx)
  end
  return "J "
end
-- }}}

-- { Diagnostics {{{
local function diagnostics_status()
  local bufnr = 0

  local e = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR })
  local w  = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.WARN })
  local h  = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.HINT })
  local i  = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.INFO })

  if e + w + h + i == 0 then
    return ""
  end
  return table.concat({
    e > 0 and ("%#DiagnosticError# ✘" .. " " .. e .. " ") or "",
    w > 0 and ("%#DiagnosticWarn# ⚠"  .. " " .. w .. " ") or "",
    h > 0 and ("%#DiagnosticHint# ◆"  .. " " .. h .. " ") or "", -- couldn't find a nice bulb icon
    i > 0 and ("%#DiagnosticInfo# ℹ"  .. " " .. i .. " ") or "",
  })
end
-- }}}

-- { Implementation and Configs {{{
function _G.statusline()
    local raw_mode = vim.fn.mode()
    local mode_info = mode_map[raw_mode] or { name = 'UNKNOWN', hl = 'StatusNormal' }

    return table.concat({
        string.format('%%#%s# %s ', mode_info.hl, mode_info.name),   -- Mode
        '%#StatusEmpty# %f ',                                        -- File Path
        '%m%r',                                                      -- Flags (modified, readonly, etc)
        diagnostics_status(),                                        -- Diagnostics Status
        '%=',                                                        -- Right Align Spacer
        jumper_status(),                                             -- Jumper Status
        '%#StatusEmpty# %y ',                                        -- FileType
        lsp_status(),                                                -- LSP Status
        string.format('%%#%s# %%l:%%c ', mode_info.hl),              -- Line:Col matches mode color
    })
end
-- }}}

vim.o.laststatus = 3
vim.opt.statusline = '%!v:lua.statusline()'

-- vim: foldmethod=marker
