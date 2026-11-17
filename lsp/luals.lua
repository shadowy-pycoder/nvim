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
  settings = {
    Lua = {
      format = { enable = false },
      runtime = { version = 'LuaJIT' },
      diagnostics = {
        globals = { 'vim' },
        workspaceDelay = 3000,
      },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
        maxPreload = 2000,
        preloadFileSize = 200,
      },
      telemetry = { enable = false },
    },
  },
}
