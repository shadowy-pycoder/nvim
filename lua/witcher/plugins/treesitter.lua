return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  build = ':TSUpdate',
  dependencies = {
    'windwp/nvim-ts-autotag',
  },
  config = function()
    local treesitter = require('nvim-treesitter.configs')

    treesitter.setup({
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function()
          return vim.b.large_buf
        end,
      },
      indent = { enable = true },
      autotag = {
        enable = true,
      },
      ensure_installed = {
        'json',
        'javascript',
        'typescript',
        'tsx',
        'yaml',
        'html',
        'css',
        'markdown',
        'markdown_inline',
        'bash',
        'lua',
        'vim',
        'dockerfile',
        'gitignore',
        'c',
        'go',
        'python',
        'toml',
        'sql',
        'comment',
      },
      rainbow = {
        enable = true,
        disable = { 'html' },
        extended_mode = false,
        max_file_lines = nil,
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    })
  end,
}
