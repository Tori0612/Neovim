-- @p lua/globals/ftypes.lua

vim.filetype.add({
  extension = {
    env = "env",
    hlyrics = "holyrics",
    hll = "xml",
    stlc = "ocaml",
    osts = "typescript",
  },
  filename = {
    [".env"] = "env",
  },
  pattern = {
    ["%.env%.[%w_.-]+"] = "env",
  },
})
