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
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
        disableOrganizeImports = true,
        typeCheckingMode = 'all',
        enableTypeIgnoreComments = true,
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
        '**/__pycache__',
        '**/node_modules',
        '**/.git',
      },
    },
  },
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightSetPythonPath', set_python_path, {
      desc = 'Reconfigure basedpyright with the provided python path',
      nargs = 1,
      complete = 'file',
    })
  end,
}
