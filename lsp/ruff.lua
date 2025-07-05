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
  -- https://github.com/astral-sh/ruff/issues/14483#issuecomment-2526717736
  capabilities = {
    general = {
      -- positionEncodings = { "utf-8", "utf-16", "utf-32" }  <--- this is the default
      positionEncodings = { 'utf-16' },
    },
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
