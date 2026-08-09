local M = {}

local parser_dir =  vim.fs.joinpath(
  vim.fn.stdpath("config"),
  "parser"
  )
local query_dir = vim.fs.joinpath(
  vim.fn.stdpath("config"),
  "/queries"
)

local dll_ext = ({
  Windows_NT = 'dll',
  Darwin = 'dylib',
})[vim.uv.os_uname().sysname] or 'so'

local parser_pattern = "%." .. dll_ext .. "$"

local logger = function(level, msg)
  vim.notify(msg)
end

function M.set_logger(fn)
  logger = fn
end

local function log(level, msg)
  logger(level, msg)
end

local function scandir(path)
  return vim.fn.readdir(path)
end

local function makedir(path, flag)
  vim.fn.mkdir(path, flag)
end

local function run(cmd, cwd, cb, env)
  vim.system(cmd, {
    cwd = cwd,
    text = true,
    env = env,
  }, function(obj)
    vim.schedule(function()
      if obj.code ~= 0 then
        log("warn", obj.stderr ~= "" and obj.stderr or "Command failed")
        return
      end
      if cb then
        cb(obj)
      end
    end)
  end)
end

local function continue_install(repo_path, tmp)
  log("step", "[5/8] Building parser...")
  run({ "tree-sitter", "build" }, repo_path, function()

    local files = scandir(repo_path)

    local parser_file, filename, lang

    for _, file in ipairs(files) do
      if file:match(parser_pattern) then
        local name = file:gsub(parser_pattern, "")

        if name ~= "parser" and name ~= "scanner" then
          parser_file = repo_path .. "/" .. file
          filename = file
          lang = name
          break
        end
      end
    end

    if not parser_file then
      local found = vim.fs.find(function(name)
          return name:match(parser_pattern)
        end, {
        path = repo_path, type = "file",
        limit = -1,
      })

      for _, file in ipairs(found) do
        log("info", "FOUND " .. file)
      end

      for _, path in ipairs(found) do
        local base = vim.fs.basename(path)
        local name = base:gsub(parser_pattern, "")

        if name ~= "parser" and name ~= "scanner" then
          parser_file = path
          filename = base
          lang = name
          break
        end
      end
    end

    if not parser_file then
      local found = vim.fs.find(function(name)
          return name:match(parser_pattern)
        end, {
        path = repo_path, type = "file",
        limit = -1,
      })
      if found[1] then
        parser_file = found[1]
        filename = vim.fs.basename(parser_file)
        lang = filename:gsub(parser_pattern, "")
      end
    end

    if not parser_file then
      log("error", "No .so file found.")
      vim.fn.delete(tmp, "rf")
      return
    end

    makedir(parser_dir, "p")
    makedir(query_dir, "p")

    log("step", "[6/8] Installing parser: " .. lang)

    vim.fn.delete(parser_dir .. "/" .. filename)
    vim.uv.fs_copyfile(parser_file, parser_dir .. "/" .. filename)

    if vim.fn.isdirectory(repo_path .. "/queries") == 1 then
      vim.fn.delete(query_dir .. "/" .. lang, "rf")
      makedir(query_dir .. "/" .. lang, "p")

      local query_files = scandir(repo_path .. "/queries")

      log("step", "[7/8] Installing queries...")
      for _, file in ipairs(query_files) do
        vim.uv.fs_copyfile(
          repo_path .. "/queries/" .. file,
          query_dir .. "/" .. lang .. "/" .. file
        )
      end
    end

    vim.fn.delete(tmp, "rf")

    log("success", "[8/8] Installed parser: " .. lang)
  end,
  { CC = "gcc" })
end

function M.install(url)
  local tmp = vim.fn.tempname()

  log("step", "[1/8] Creating temporary directory ...")
  makedir(tmp, "p")

  log("step", "[2/8] Cloning repository ...")
  run({ "git", "clone", url }, tmp, function()

    local entries = scandir(tmp)
    local repo

    for _, name in ipairs(entries) do
      if name ~= ".git" then
        repo = name
        break
      end
    end

    if not repo then
      log("error", "Could not detect cloned repo.")
      vim.fn.delete(tmp, "rf")
      return
    end

    local repo_path = tmp .. "/" .. repo
    log("step", "[3/8] Entering repo: " .. repo)

    log("step", "[4/8] Generating parser...")
    run({ "tree-sitter", "generate" }, repo_path, function()
      continue_install(repo_path, tmp)
    end)
  end)
end

function M.remove(lang)
  vim.fn.delete(parser_dir .. "/" .. lang .. "." .. dll_ext)
  vim.fn.delete(query_dir .. "/" .. lang, "rf")

  log("success", "Removed parser: " .. lang)
end

function M.list()
  local files = scandir(parser_dir)
  local langs = {}

  for _, file in ipairs(files) do
    local lang = file:gsub(parser_pattern, "")
    table.insert(langs, lang)
  end

  log("info", "Installed: " .. table.concat(langs, ", "))
end

return M
