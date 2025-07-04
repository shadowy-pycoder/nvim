return {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'ruff.toml',
    '.ruff.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
  settings = {
    ruff = {
      init_options = {
        settings = {
          configuration = '~/.config/nvim/ruff.toml',
          organizeImports = true,
          format = {
            enable = true,
          },
        },
      },
    },
  },
}
