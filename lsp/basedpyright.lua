---@brief
---
--- https://detachhead.github.io/basedpyright
---
--- `basedpyright`, a static type checker and language server for python

local function set_python_path(command)
  local path = command.args
  local clients = vim.lsp.get_clients({
    bufnr = vim.api.nvim_get_current_buf(),
    name = 'basedpyright',
  })
  for _, client in ipairs(clients) do
    if client.settings then
      client.settings.python = vim.tbl_deep_extend('force', client.settings.python or {}, { pythonPath = path })
    else
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
    end
    client:notify('workspace/didChangeConfiguration', { settings = nil })
  end
end

---@type vim.lsp.Config
return {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    '.git',
  },
  settings = {
    basedpyright = {
      analysis = {
        fileEnumerationTimeout = 5,
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
        disableOrganizeImports = true,
        typeCheckingMode = 'all',
        enableTypeIgnoreComments = true,
        useTypingExtensions = true,
        diagnosticSeverityOverrides = {
          reportUnusedCallResult = 'none',
          reportExplicitAny = 'none',
          reportUnknownMemberType = 'none',
          reportUnknownVariableType = 'none',
          reportUnknownArgumentType = 'none',
          reportAny = 'none',
          reportUnknownLambdaType = 'none',
          reportConstantRedefinition = 'none',
          reportArgumentType = 'none',
          reportGeneralTypeIssues = 'none',
          reportUnannotatedClassAttribute = 'none',
          reportMissingTypeStubs = 'none',
          reportUnusedVariable = 'none',
          reportUndefinedVariable = 'none',
          reportUnusedImport = 'none',
          reportImplicitOverride = 'none',
          reportCallInDefaultInitializer = 'none',
          reportOptionalMemberAccess = 'none',
        },
      },
      exclude = {
        '/usr/*',
        '/usr/**',
        '/lib/*',
        '/lib/**',
        '/lib32/*',
        '/lib32/**',
        '/lib64/*',
        '/lib64/**',
        '/bin/*',
        '/bin/**',
        '/sbin/*',
        '/sbin/**',
        '/etc/*',
        '/etc/**',
        '/sys/*',
        '/sys/**',
        '/proc/*',
        '/proc/**',
        '/dev/*',
        '/dev/**',
        '/var/*',
        '/var/**',
        '/media/*',
        '/media/**',
        '/mnt/*',
        '/mnt/**',
        '/opt/*',
        '/opt/**',
        '/root/*',
        '/root/**',
        '/run/*',
        '/run/**',
        '/boot/*',
        '/boot/**',
        '/srv/*',
        '/srv/**',
        '/tmp/*',
        '/tmp/**',
        '**/.git',
        '**/__pycache__',
        '**/.git',
        '**/.venv',
        '**/venv',
        '**/build',
        '**/dist',
        '**/node_modules',
        '**/.mypy_cache',
        '**/.pytest_cache',
        '**/.ruff_cache',
      },
    },
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightSetPythonPath', set_python_path, {
      desc = 'Reconfigure basedpyright with the provided python path',
      nargs = 1,
      complete = 'file',
    })
    local ft = vim.bo[bufnr].filetype
    local name = vim.api.nvim_buf_get_name(bufnr)
    if ft == 'fugitive' or vim.bo[bufnr].buftype == 'nowrite' then
      vim.schedule(function()
        vim.lsp.stop_client(client.id)
      end)
      return
    end
    if name:match('^fugitive://') then
      vim.schedule(function()
        vim.lsp.stop_client(client.id)
      end)
      return
    end
  end,
}
