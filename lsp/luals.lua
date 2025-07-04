return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  Lua = {
    format = {
      enable = false,
    },
    diagnostics = {
      globals = { 'vim', 'it', 'describe', 'before_each', 'after_each' },
    },
  },
}
